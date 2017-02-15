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
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(50.0f, 50.0f, 100.0f, 100.0f);
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    //add it to our view
    [self.layerView.layer addSublayer:self.colorLayer];
    
    
    
    /*
        Core Animation 是使用事务来管理动画的， CATransaction 这个类不能初始化alloc，也不能init, 但是可以使用 +begin +commit  分别管理入栈和出栈
     
        任何可以做动画的图层属性都会被添加到栈顶的事务， 可以通过 +setAnimationDuration 方法设置当前事务的动画时间
     
        通过  +animationDuration来获取，默认是 0.25
     
        Core Animation 会在每个  runLoop周期中自动开始一个新的事务。
     
        因为修改当前事务的时间会影响到同一时刻别的动画(屏幕旋转), 所以最后在调整之前压入一个新的事务
     
     */
    
    
}
- (IBAction)changeColor {
    
    // 在这里修改，会对中间的事务都起效果
    [CATransaction begin];
    
    [CATransaction setAnimationDuration:1.0];
    
    //randomize the layer background color
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;

    [CATransaction commit];
    
    
    // 类似的方法
    // 这两个方法之间 都会受到影响
    //UIView beginAnimations:<#(nullable NSString *)#> context:<#(nullable void *)#>
    // [UIView commitAnimations]
    
    
    // 这个也是同样的
    // UIView animateWithDuration:<#(NSTimeInterval)#> animations:<#^(void)animations#>
    
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
