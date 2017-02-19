//
//  CAMediaTimingController.m
//  CoreAnimationDemo
//
//  Created by DFD on 2017/2/19.
//  Copyright © 2017年 DFD. All rights reserved.
//

#import "CAMediaTimingController.h"

@interface CAMediaTimingController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation CAMediaTimingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self viewSet];
}

- (void)viewSet{

    /*
        CAMediaTiming 协议定义了在一段动画内用来控制失去时间的属性集合
     
    // 开始时间
    //@property CFTimeInterval beginTime;
    
    
    // 动画时长  默认0 , 但是执行的时候是 0.25
    @property CFTimeInterval duration;
    
    // 速度  默认1
    @property float speed;
    
    //  时间的偏移， 默认0
    @property CFTimeInterval timeOffset;
    
    // 重复次数  默认0 ， 但是执行的时候是1次       如果 duration = 2, repeatCount = 4, 动画执行时间就是 8
    @property float repeatCount;
    
     
    @property CFTimeInterval repeatDuration;
    
    
    // 自动反向  默认 NO
    @property BOOL autoreverses;
    
    // Defines how the timed object behaves outside its active duration.
    // * Local time may be clamped to either end of the active duration, or
    // * the element may be removed from the presentation. The legal values
    // * are `backwards', `forwards', `both' and `removed'. Defaults to
    // * `removed'.
    
    @property(copy) NSString *fillMode;
    
     
     */
    
    CALayer *doorLayer = [CALayer layer];
    doorLayer.frame = CGRectMake(0, 0, 128, 256);
    doorLayer.position = CGPointMake(150 - 64, 150);
    doorLayer.anchorPoint = CGPointMake(0, 0.5);
    UIImage *image = [UIImage imageNamed:@"door.png"];
    doorLayer.contents = (__bridge id)image.CGImage;
    
    [self.containerView.layer addSublayer:doorLayer];
    
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1 / 500;
    self.containerView.layer.sublayerTransform = perspective;
    
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation.y";
    animation.toValue = @(-M_PI_2);
    animation.duration = 2.0;
    animation.repeatCount = INFINITY;
    animation.autoreverses = YES;
    [doorLayer addAnimation:animation forKey:nil];
    
    
    
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
