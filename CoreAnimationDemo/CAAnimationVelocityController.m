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

@property (nonatomic, strong) UIView *layerView;

@end

@implementation CAAnimationVelocityController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    0 0; 320 568
//         375 667
//    
    
    self.layerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 300, 300)];
    [self.view addSubview:self.layerView];
    self.layerView.backgroundColor = [UIColor yellowColor];
    
    
    NSLog(@"%@ %@", @([UIScreen mainScreen].bounds.size.width), @([UIScreen mainScreen].bounds.size.height));
    
//    
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    
//    [self.view layoutIfNeeded];
    
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
    self.colorLayer.position = CGPointMake([UIScreen mainScreen].bounds.size.width/2.0, [UIScreen mainScreen].bounds.size.height/2.0);
    [self.view.layer addSublayer:self.colorLayer];
    
    
    
    [self changeColor2];
    
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
        使用 UIView 的动画缓冲
     
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.colorLayer.position =  [[touches anyObject] locationInView:self.view];
        
    } completion:NULL];
     
     
     
     
     
     */
    
    

    
    
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
    //add timing functions
    CAMediaTimingFunction *fn = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn];
    
    
    /*
     
     
     缓冲和关键帧动画
     
     */
    
    // 设置 每个点之间的变化模式，是 vlues个数 -1
    animation.timingFunctions = @[fn, fn, fn];
    [self.colorLayer addAnimation:animation forKey:nil];
    
}

- (void)changeColor1{
    /*
        自定义缓冲函数
     
     */
    
    
    CAMediaTimingFunction *fn = [CAMediaTimingFunction functionWithControlPoints:0.1 :0.2 :0.4 :0.9];
    
}

- (void)changeColor2{
    /*
        三次贝塞尔曲线
     
        CAMediaTimingFunction 函数的主要原则在于它把输入的时间转换成起点和终点的比例的改变。我们可以用一个简单的图标
     
     
     |             /
     |            /
     |           /
     |          /
     |         /
     |        /
     |       /
     |      /
     |     /
     |    /
     |   /
     |  /
     |______________
     
     横轴代表时间，纵轴代表该表的量，于是线性的缓冲就是一条从起点开的的简单的斜线
     
     这条斜线的斜率代表着速度，斜率的改变代表了加速度，原则上说，任何加速的斜线都可以用这种图像来表示。但是 CAMediaTimingFunction 使用了一个叫做 三次贝塞尔曲线的函数，它可以产出指定缓冲函数的子集。 一个三次贝塞尔曲线通过4个点来定义，第一个和最后一个代表了曲线的起点和终点。剩下的两个点叫做控制点，因为它控制了曲线的形状。贝塞尔曲线的控制点其实位于曲线之外的点，也就是说曲线不一定穿过他们，像吸引曲线经过的磁铁。
     
     
     
     
     
     */
    
    CAMediaTimingFunction *function = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];
    //get control points
    CGPoint controlPoint1, controlPoint2;
    
    
    float first[2] = { 0.0, 0.0 };
    float second[2] = { 0.0, 0.0 };
    
    
//    float abc[2] = [0.0, 0.0];
    [function getControlPointAtIndex:1 values:(float *)&first];
    [function getControlPointAtIndex:2 values:(float *)&second];
    
    NSLog(@"(%@,%@) (%@,%@)", @(first[0]),@(first[1]),@(second[0]),@(second[1]));
    
    //create curve
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointZero];
    [path addCurveToPoint:CGPointMake(1, 1)
                    controlPoint1:controlPoint1 controlPoint2:controlPoint2];
    //scale the path up to a reasonable size for display
    [path applyTransform:CGAffineTransformMakeScale(200, 200)];
    //create shape layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 4.0f;
    shapeLayer.path = path.CGPath;
    [self.layerView.layer addSublayer:shapeLayer];
    //flip geometry so that 0,0 is in the bottom-left
    self.layerView.layer.geometryFlipped = YES;
    
    
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
