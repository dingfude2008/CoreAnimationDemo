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
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
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
    
    /*
        在动画过程中取消动画
     
        Core Animation 不支持修改动画，但是支持在动画途中获取动画，并移除它
        正常情况下，动画在进行完就自动移除，除非设置了removedOnCompletion = NO
        当设置removedOnCompletion = NO 后，动画的生命周期会跟随被添加的图层一样
     
        添加动画的时候， -addAnimation:forKey:
        获取动画的时候， -animationForKey:(NSString *)key;
        删除动画的时候， -removeAnimationForKey:(NSString *)key;
        删除所有动画，   -removeAllAnimations;
     
     */
    
    
}
- (IBAction)swithImage:(id)sender {
    [self customAnimation];
}

/// 使用 UIView
- (void)transitionView{
    
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    
    [self.imageView.layer addAnimation:transition forKey:nil];
    
    UIImage *image = self.imageView.image;
    NSUInteger index = [self.images indexOfObject:image];
    index = (index + 1) % self.images.count;
    self.imageView.image = self.images[index];
    
}

- (void)useUIViewTransition{
    
    /*
        这里的过渡动画选项可以有一下
     UIViewAnimationOptionLayoutSubviews            = 1 <<  0,
     UIViewAnimationOptionAllowUserInteraction      = 1 <<  1, // turn on user interaction while animating
     UIViewAnimationOptionBeginFromCurrentState     = 1 <<  2, // start all views from current value, not initial value
     UIViewAnimationOptionRepeat                    = 1 <<  3, // repeat animation indefinitely
     UIViewAnimationOptionAutoreverse               = 1 <<  4, // if repeat, run animation back and forth
     UIViewAnimationOptionOverrideInheritedDuration = 1 <<  5, // ignore nested duration
     UIViewAnimationOptionOverrideInheritedCurve    = 1 <<  6, // ignore nested curve
     UIViewAnimationOptionAllowAnimatedContent      = 1 <<  7, // animate contents (applies to transitions only)
     UIViewAnimationOptionShowHideTransitionViews   = 1 <<  8, // flip to/from hidden state instead of adding/removing
     UIViewAnimationOptionOverrideInheritedOptions  = 1 <<  9, // do not inherit any options or animation type
     
     UIViewAnimationOptionCurveEaseInOut            = 0 << 16, // default
     UIViewAnimationOptionCurveEaseIn               = 1 << 16,
     UIViewAnimationOptionCurveEaseOut              = 2 << 16,
     UIViewAnimationOptionCurveLinear               = 3 << 16,
     
     UIViewAnimationOptionTransitionNone            = 0 << 20, // default
     UIViewAnimationOptionTransitionFlipFromLeft    = 1 << 20,
     UIViewAnimationOptionTransitionFlipFromRight   = 2 << 20,
     UIViewAnimationOptionTransitionCurlUp          = 3 << 20,
     UIViewAnimationOptionTransitionCurlDown        = 4 << 20,
     UIViewAnimationOptionTransitionCrossDissolve   = 5 << 20,
     UIViewAnimationOptionTransitionFlipFromTop     = 6 << 20,
     UIViewAnimationOptionTransitionFlipFromBottom  = 7 << 20,
     */
    
   [UIView transitionWithView:self.imageView
                     duration:1.0
                      options:UIViewAnimationOptionTransitionFlipFromLeft
                   animations:^{
                       UIImage *image = self.imageView.image;
                       NSUInteger index = [self.images indexOfObject:image];
                       index = (index + 1) % self.images.count;
                       self.imageView.image = self.images[index];
                   } completion:^(BOOL finished) {
    
                   }];
}


/**
 自定义动画，使用属性动画
 原理是，对图层进行截图，然后使用属性动画来代替 CATransition 或者 UIKit 的过渡方法来动画
 */
- (void)customAnimation{
    
    // 因为使用 CATransition 来做自定义动画的时候，还有实现协议，在协议中把动画定位到动画结束时，所以使用 UIKit的过渡方法
    
    // 开始
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, YES, 0.0);
    
    // 绘制到 Core Graphics的上下文捕获当前内容的图片
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *coverImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIView *coverView = [[UIImageView alloc] initWithImage:coverImage];
    
    coverView.frame = self.view.bounds;
    
    [self.view addSubview:coverView];
    
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.view.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
    [UIView animateWithDuration:1.0 animations:^{
        
        // 缩放，旋转，渐隐原视图
        CGAffineTransform tranform = CGAffineTransformMakeScale(0.01, 0.01);
        
        tranform = CGAffineTransformRotate(tranform, M_PI_2);
        
        coverView.transform = tranform;
        
        coverView.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
        [coverView removeFromSuperview];
        
    }];
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
