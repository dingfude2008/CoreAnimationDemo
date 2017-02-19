//
//  AnimationGroupController.m
//  CoreAnimationDemo
//
//  Created by DFD on 2017/2/19.
//  Copyright © 2017年 DFD. All rights reserved.
//

#import "AnimationGroupController.h"

@interface AnimationGroupController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, copy) NSArray *images;

@end

@implementation AnimationGroupController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.images = @[[UIImage imageNamed:@"Snowman_00_00.jpg"],
                    [UIImage imageNamed:@"Snowman_00_01.jpg"],
                    [UIImage imageNamed:@"Snowman_00_02.jpg"],
                    [UIImage imageNamed:@"Snowman_00_03.jpg"]];
    
    [self setView2];
}

- (void)setView2{
    
    /*
     过渡
     
     CATrasition 另一个 CAAnimation的子类
     
     使用 type 和 subtype 来标示效果
     
     type :NSString  
     可选值有
     kCATransitionFade      默认  平滑的淡入淡出效果
     kCATransitionMoveIn    顶部进入，老图层不是推走，而是渐隐
     kCATransitionPush      左侧推入，老图层推走
     kCATransitionReveal    滑动进入
     
     subtype 来设置上述动画的方向
     可选值有
     kCATransitionFromRight
     kCATransitionFromLeft
     kCATransitionFromTop
     kCATransitionFromBottom
     
     */
    
    
    /*
        隐式过渡
     
        当设置 CALayer 的 content属性的时候， CATransition是默认行为，但是对于视图关联的图层，或者其他隐式动画的行为，这个特性依然是禁用的。自己创建的图层，对图层 content图片做改动都会自动附上淡入淡出的效果
     
     */
    
    
    /*
     
        对图层树的修改
     
        CATransition并不作用于指定的图层属性，这就是说即使不能准确的知道改变了什么情况下对图层做动画。例如，在不知道 UITableView 哪一行添加或者删除的时候，直接就可以平滑的刷新他。 或者不知道 UIViewController内部的视图层级的情况下对两个不同的实例做动画。
        他们不仅涉及到图层的属性，而且是对整个图层树的改变。我们在这种动画过程中手动的在层级中添加或移除图层。
        
        注意：要确保 CATransition 添加到不会被移除的图层上，不然会被一起移除。一般添加到 superLayer 上
     
     */
    
}
- (IBAction)swithImage:(id)sender {
    
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    [self.imageView.layer addAnimation:transition forKey:nil];
    
    UIImage *image = self.imageView.image;
    NSUInteger index = [self.images indexOfObject:image];
    index = (index + 1) % self.images.count;
    self.imageView.image = self.images[index];
    
}



- (void)setView1{
    /*
        动画组
     
     */
    
    // 路径
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(0, 150)];
    [bezierPath addCurveToPoint:CGPointMake(300, 150) controlPoint1:CGPointMake(75, 0) controlPoint2:CGPointMake(225, 300)];
    //draw the path using a CAShapeLayer
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = bezierPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.0f;
    [self.containerView.layer addSublayer:pathLayer];
    
    //add a colored layer
    CALayer *colorLayer = [CALayer layer];
    colorLayer.frame = CGRectMake(0, 0, 64, 64);
    colorLayer.position = CGPointMake(0, 150);
    colorLayer.backgroundColor = [UIColor greenColor].CGColor;
    [self.containerView.layer addSublayer:colorLayer];
    //create the position animation
    
    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animation];
    animation1.keyPath = @"position";
    animation1.path = bezierPath.CGPath;
    animation1.rotationMode = kCAAnimationRotateAuto;
    //create the color animation
    
    CABasicAnimation *animation2 = [CABasicAnimation animation];
    animation2.keyPath = @"backgroundColor";
    animation2.toValue = (__bridge id)[UIColor redColor].CGColor;
    //create group animation
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[animation1, animation2];
    groupAnimation.duration = 4.0;
    //add the animation to the color layer
    [colorLayer addAnimation:groupAnimation forKey:nil];

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
