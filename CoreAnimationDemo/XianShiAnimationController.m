//
//  XianShiAnimationController.m
//  CoreAnimationDemo
//
//  Created by DFD on 2017/2/16.
//  Copyright © 2017年 DFD. All rights reserved.
//

#import "XianShiAnimationController.h"

@interface XianShiAnimationController ()<CAAnimationDelegate>
@property (nonatomic, strong)  CALayer *colorLayer;
@property (weak, nonatomic) IBOutlet UIView *layerView;
@property (weak, nonatomic) IBOutlet UIView *containView;

@end

@implementation XianShiAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //create sublayer
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(50.0f, 50.0f, 100.0f, 100.0f);
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    //add it to our view
    [self.layerView.layer addSublayer:self.colorLayer];
    
    
    [self viewSet1];
}
- (IBAction)changeColor {
    //create a new random color
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
    
//    CABasicAnimation *animation = [CABasicAnimation animation];
//    animation.keyPath = @"backgroundColor";
//    animation.toValue = (__bridge id)color.CGColor;
//    animation.delegate = self;
//    //apply animation to layer
//    [self.colorLayer addAnimation:animation forKey:nil];
    
    
    // 可以个 animation 使用 KVC 的方式打上标记 ，用于区分
    
//    [animation setValue:handView forKey:@"handView"];
//    [handView.layer addAnimation:animation forKey:nil];
    
    
    
    /*
     CAKeyframeAnimation 关键帧动画，他不同于 CABasicAnimation ，不限制于设置一个起始值 fromValue 和结束之 toValue
     他可以根据一连串随意的值来做动画， 他只提供关键帧，其余的帧有 Core Animation 来插入
     
     
     */
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.duration = 2.0;
    animation.values = @[
                         (__bridge id)[UIColor yellowColor].CGColor,
                         (__bridge id)[UIColor redColor].CGColor,
                        (__bridge id)[UIColor greenColor].CGColor,
                         (__bridge id)[UIColor purpleColor].CGColor ];
    //apply animation to layer
    animation.delegate = self;
    [self.colorLayer addAnimation:animation forKey:nil];
    
    
    /*
        在动画开始的时候突然跳到第一帧，然后运行完，再结束的时候恢复到原来的帧
     
     */
    
}

- (void)viewSet1
{
    //create a path
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(0, 150)];
    [bezierPath addCurveToPoint:CGPointMake(300, 150) controlPoint1:CGPointMake(75, 0) controlPoint2:CGPointMake(225, 300)];
    //draw the path using a CAShapeLayer
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = bezierPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.0f;
    [self.containView.layer addSublayer:pathLayer];
    //add the ship
    CALayer *shipLayer = [CALayer layer];
    shipLayer.frame = CGRectMake(0, 0, 64, 64);
    shipLayer.position = CGPointMake(0, 150);
    shipLayer.contents = (__bridge id)[UIImage imageNamed: @"Ship.png"].CGImage;
    
    
    
    [self.containView.layer addSublayer:shipLayer];
    //create the keyframe animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.duration = 4.0;
    animation.path = bezierPath.CGPath;
    // 让动画的方向和 路径的方向保持一致
    animation.rotationMode = kCAAnimationRotateAuto;
    [shipLayer addAnimation:animation forKey:nil];
}


// CAKeyframeAnimation
- (void)animationDidStop:(CAKeyframeAnimation *)anim finished:(BOOL)flag{
    //set the backgroundColor property to match animation toValue
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    // 在结束的时候，将颜色定位到最后一个
    self.colorLayer.backgroundColor = (__bridge CGColorRef)anim.values.lastObject;
    
    [CATransaction commit];
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
