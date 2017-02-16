//
//  CALayerAnimationController.m
//  CoreAnimationDemo
//
//  Created by DFD on 2017/2/15.
//  Copyright © 2017年 DFD. All rights reserved.
//

#import "CALayerAnimationController.h"

@interface CALayerAnimationController ()
@property (weak, nonatomic) IBOutlet UIView *layerView;

@property (nonatomic, strong)  CALayer *colorLayer;

@end

@implementation CALayerAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //create sublayer
//    self.colorLayer = [CALayer layer];
//    self.colorLayer.frame = CGRectMake(50.0f, 50.0f, 100.0f, 100.0f);
//    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
//    //add it to our view
//    [self.layerView.layer addSublayer:self.colorLayer];
//    
//    
    
    
    
    /*
        Core Animation 是使用事务来管理动画的， CATransaction 这个类不能初始化alloc，也不能init, 但是可以使用 +begin +commit  分别管理入栈和出栈
     
        任何可以做动画的图层属性都会被添加到栈顶的事务， 可以通过 +setAnimationDuration 方法设置当前事务的动画时间
     
        通过  +animationDuration来获取，默认是 0.25
     
        Core Animation 会在每个  runLoop周期中自动开始一个新的事务。
     
        因为修改当前事务的时间会影响到同一时刻别的动画(屏幕旋转), 所以最后在调整之前压入一个新的事务
     
     */
    
    
    //create sublayer
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(50.0f, 50.0f, 100.0f, 100.0f);
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    
    
    //add a custom action
    // 实现一个手动的图层效果
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    self.colorLayer.actions = @{@"backgroundColor": transition};
    //add it to our view
    [self.layerView.layer addSublayer:self.colorLayer];
    
    
    // 这个为nil
    NSLog(@"OutSide:%@", [self.layerView actionForLayer:self.layerView.layer forKey:@"backgroundColor"]);
    
    [UIView beginAnimations:nil context:nil];
    
    // 这个为  CABasicAnimation  对象
    NSLog(@"InSide:%@", [self.layerView actionForLayer:self.layerView.layer forKey:@"backgroundColor"]);
    
    [UIView commitAnimations];
    
    
    /*
        这就是在 动画块之外发生改变的，UIView 直接返回 nil来禁用隐式动画，如果在动画块内改变属性，会更具动画具体的类型返回相应的属性。
     
        返回 nil 可以禁用动画，也可以 在 begin后 调用  [CATransaction setDisableActions:YES]; 来禁用动画
     
    
     
        使用UIView动画，需要使用  UIView 的动画函数，或者集成 UIView, 重写 -actionForLayer:forKey方法，或者直接创建一个隐式动画。
        对于一个单独的图层，是有对应的属性的动画的，我们也可以通过实现-actionForLayer:forKey委托方法，或者提供一个actions字典来控制动画。
     
     
     
     */
    
    
    
}



- (IBAction)changeColor {
    
    
    
    [self changeColor1];
}


- (void)changeColor1{
    
    // 在这里修改，会对中间的事务都起效果
    //    [CATransaction begin];
    //
    //    [CATransaction setAnimationDuration:1.0];
    //
    //    //randomize the layer background color
    //    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    //    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    //    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    //    self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    //
    //    [CATransaction commit];
    
    
    // 类似的方法
    // 这两个方法之间 都会受到影响
    //UIView beginAnimations:<#(nullable NSString *)#> context:<#(nullable void *)#>
    // [UIView commitAnimations]
    
    
    // 这个也是同样的
    // UIView animateWithDuration:<#(NSTimeInterval)#> animations:<#^(void)animations#>
    
    
    // 完成块
    
    //begin a new transaction
    [CATransaction begin];
    //set the animation duration to 1 second
    [CATransaction setAnimationDuration:1.0];
    //add the spin animation on completion
    [CATransaction setCompletionBlock:^{
        //rotate the layer 90 degrees
        CGAffineTransform transform = self.colorLayer.affineTransform;
        transform = CGAffineTransformRotate(transform, M_PI_2);
        self.colorLayer.affineTransform = transform;
    }];
    //randomize the layer background color
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    //commit the transaction
    [CATransaction commit];
    
    
    // 新的API
    // UIView animateWithDuration:<#(NSTimeInterval)#> animations:<#^(void)animations#> completion:<#^(BOOL finished)completion#>
    
    // 图层行为
    
    // 如果直接对视图的属性进行修改，会发现，及时添加了事务，但是仍然没有动画，
    // 我们知道Core Animation通常对CALayer的所有属性（可动画的属性）做动画”  UIKit 没有实现动画的效果回调，所以就没有动画
    //但是UIView把它关联的图层的这个特性关闭了”
    
    /*
     当 CALayer的属性被修改时，会自动调用一个-actionForKey:的方法，传递属性的名称，
     实质上分为以下几步：
     1，图层是否有委托，并实现了 CALayerDelegate 的协议方法 -actionForLayer:forKey 方法，如果有，直接调用并返回结果。
     2，如果没有委托，货这委托对象没有实现 -actionForLayer:forKey方法，图层接着检查包含属性名称对应的映射的actions字典。
     3，如果 actions字典中没有包含对应的属性，那么图层会接着在她的style字典接着搜索属性名，。
     4，最后，如果在 style中里面也找不到对应的行为，那么图层会直接调用定义了每个属性的标准行为，-defaultActionForKey：
     
     所以一整轮的搜索结束之后， -actionForKey:要么返回空（这种情况下不会有动画）要么是 CAAction协议中对应的对象，最后 CALayer拿这个结果对先前和当前的值做动画。
     
     UIKit禁用了动画的原因：每一个UIView 都扮演着起关联Layer 的委托对象，并且实现了一个-actionForLayer:forKey的方法，并对这个方法中应该返回的图层行为返回为nil, 就禁用了动画。 但是在 UIView的block范围内，就返回的是一个非空值，就实现了动画
     
     */
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
