//
//  CAMediaTimingController.m
//  CoreAnimationDemo
//
//  Created by DFD on 2017/2/19.
//  Copyright © 2017年 DFD. All rights reserved.
//

#import "CAMediaTimingController.h"
#import <QuartzCore/QuartzCore.h>

@interface CAMediaTimingController ()
{
    CALayer *doorLayer;
}
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation CAMediaTimingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self viewSet];
}

- (void)viewSet2{
    /*
        图层的属性： 相对时间
     
        beginTime：开始时间，相对于添加到图层的那个时间
        
        speed:相对于总时间，如果是2.0的速度， 一个 duration = 1 的动画 0.5就完成了
     
        timeOffest: 0-1.0 之间，动画开始的时间，0.5就意味着动画从一半的时候开始
     
     
     */
    
    
    
    /*
        动画的属性：
     
        fillMode
     
        对于一个 beginTime != 0 , 和被设置 removeOnCompletion = NO 的动画，在动画开始之前，和动画结束之后
     
        fillMode 设置动画不再播放的时候，定格在什么状态
     
        这用来避免动画在结束的时候急速返回。
     
        但是需要设置 removeOnCompletion = NO
     
     
     
     */
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    
    
    
    animation.fillMode = kCAFillModeRemoved;        // 默认移除
    
    animation.fillMode = kCAFillModeForwards;
    
    animation.fillMode = kCAFillModeBackwards;
    
    animation.fillMode = kCAFillModeBoth;
    
    
    
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
    
    doorLayer = [CALayer layer];
    doorLayer.frame = CGRectMake(0, 0, 128, 256);
    doorLayer.position = CGPointMake(150 - 64, 150);
    doorLayer.anchorPoint = CGPointMake(0, 0.5);
    UIImage *image = [UIImage imageNamed:@"door.png"];
    doorLayer.contents = (__bridge id)image.CGImage;
    
    [self.containerView.layer addSublayer:doorLayer];
    
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1 / 500;
    self.containerView.layer.sublayerTransform = perspective;
    
    // 设置图层的 speed   这个是设置时间的速度
    doorLayer.speed = 0;
    
    
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation.y";
    
    
    //animation.speed = 0;
    animation.toValue = @(-M_PI_2);
    
    animation.duration = 1.0;
//    animation.repeatCount = INFINITY;
//    animation.autoreverses = YES;
    
    // 设置手拉门的动画
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] init];
    [pan addTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];
    
    [doorLayer addAnimation:animation forKey:nil];
    
}

- (void)pan:(UIPanGestureRecognizer *)pan{
    
    CGFloat x = [pan translationInView:self.view].x;
    
    x /= 200.0f;
    
    CFTimeInterval timeOffest = doorLayer.timeOffset;
    
    timeOffest = MIN(0.999, MAX(0.0, timeOffest - x));
    
    NSLog(@"%@", @(timeOffest));
    
    
    // 设置图层的 timeOffest
    doorLayer.timeOffset = timeOffest;
    
    [pan setTranslation:CGPointZero inView:self.view];
    
    
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
