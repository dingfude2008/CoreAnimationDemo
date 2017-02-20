//
//  CAAnimationVelocityController.m
//  CoreAnimationDemo
//
//  Created by DFD on 2017/2/20.
//  Copyright © 2017年 DFD. All rights reserved.
//

#import "CAAnimationVelocityController.h"
#import <QuartzCore/QuartzCore.h>

@interface CAAnimationVelocityController ()

@property (nonatomic, strong) CALayer *colorLayer;

@end

@implementation CAAnimationVelocityController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self viewSet1];
}

- (void)viewSet1{
    
    /*
        缓冲之动画速度
     
        缓冲函数：
     
        CAAnimation 的 timingFuction 是一个 CAMediaTimingFuction 缓冲类对象
     
        隐式动画 CATransaction 的 +setAnimationTimingFuction 方法
     
     
     
     创建  CAMediaTimingFunction 最简单的方法的构造方法 +functionWithName:
     可选值：
     kCAMediaTimingFunctionLinear               线性动画（默认）
     kCAMediaTimingFunctionEaseIn               慢慢加速然后突然停止
     kCAMediaTimingFunctionEaseOut              全速开始慢慢减速停止
     kCAMediaTimingFunctionEaseInEaseOut        慢慢加速然后再慢慢减速。  最真实的。使用 UIView动画的时候，是默认的
     kCAMediaTimingFunctionDefault          和 kCAMediaTimingFunctionEaseInEaseOut很像，创建显示的动画，不是默认的
     
     
     */
    
    
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(0, 0, 100, 100);
    self.colorLayer.position = CGPointMake(self.view.bounds.size.width/2.0, self.view.bounds.size.height/2.0);
    self.colorLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:self.colorLayer];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    /*
        使用隐式动画
     
    [CATransaction begin];
    
    
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    self.colorLayer.position = [[touches anyObject] locationInView:self.view];
    
    
    [CATransaction commit];
    */
    
    /*
        使用 UIView
     
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.colorLayer.position =  [[touches anyObject] locationInView:self.view];
        
    } completion:NULL];
     */
    
    
    [self changeColor];
}

- (void)changeColor{

    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.duration = 2.0;
    animation.values = @[
                                                     (__bridge id)[UIColor blueColor].CGColor,
                                                                                 (__bridge id)[UIColor redColor].CGColor,
                                                                                 (__bridge id)[UIColor greenColor].CGColor,
                                                                                 (__bridge id)[UIColor blueColor].CGColor ];
    //add timing function
    CAMediaTimingFunction *fn = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn];
    
    // 设置 每个点之间的变化模式，是 vlues个数 -1
    animation.timingFunctions = @[fn, fn, fn];
    [self.colorLayer addAnimation:animation forKey:nil];
    
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
