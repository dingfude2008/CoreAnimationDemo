//
//  SecondController.m
//  CoreAnimationDemo
//
//  Created by DFD on 2017/2/6.
//  Copyright © 2017年 DFD. All rights reserved.
//

#import "SecondController.h"

@interface SecondController ()

@property (weak, nonatomic) IBOutlet UIImageView *hourHand;
@property (weak, nonatomic) IBOutlet UIImageView *minuteHand;
@property (weak, nonatomic) IBOutlet UIImageView *secondHand;

@property (weak, nonatomic) NSTimer *timer;
@end

@implementation SecondController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  UIView 的三个重要布局属性  frame, bounds, center  对应
    //  对应 CALayer的 三个       frame, bounds, position
    
    //  CALayer 的 frame 代表了 图层的外部坐标，也就是在父图层上的占据的空间
    //             bounds 代表了内部坐标 {0，0} 通常是图层的左上角，
    //  UIView 的 center 和 CALayer 的 position 都代表了相对于父图层 anchorPoint（锚点）所在的位置
    
    //  当操纵视图frame，实际上是改变位于视图下方 CALayer 的 frame, 不能够独立于特曾之外改变视图的frame
    
    //  对于视图或者图层来说， frame 并不是一个清晰的属性，它其实是一个虚拟属性，是根据 bounds, position, tranform 计算来的
    //  当改变其中任意一个值后，frame 都会变化，相反，改变frame同样会改变他们当中的值
    
    // 注意：  当对图层做变化的时候，比如旋转或者缩放， frame 实际上代表了覆盖在图层旋转之后的这个轴对齐的矩形区域， 也就是说， frame 的宽高可能和 bounds 的宽高不再一致了
    
    
    // anchorPoint 锚点
    
    // 视图的center 和图层的position属性都指定了 anchorPoint相对于父图层的位置。
    
    // 图层的 anchorPoint 通过 position 来控制它的frame 的位置，可以认为 anchorPoint 是用来移动图层的把柄
    
    // anchorPoint 位于图层的中点，所以图层将以这个点为中心放置， anchorPoint 属性没有在UIView 被暴露出来，这也是视图的position 属性被改为 center 的 原因。 但是 图层的 anchorPoint 可以被移动，比如你可以把它放置在图层 frame 左上角，于是图层的内容将会向右下角的 position方向移动，而不是居中了
    
    // 和 contentsRect 和 contentsCenter 属性类似， anchorPoint 也是用单位坐标的，即图层的相对坐标。{0，0，1，1}
    // 默认的值为 { 0.5，0.5 }， 可以通过制定的值小于0 或者大于1， 使它放置在图层之外
    // 当改变 anchorPoint 的时候，position没有发生改变，frame 改变了

    
    self.hourHand.layer.anchorPoint = CGPointMake(0.5, 0.8);
    self.minuteHand.layer.anchorPoint = CGPointMake(0.5, 0.8);
    self.secondHand.layer.anchorPoint = CGPointMake(0.5, 0.8);
    
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
}

- (void)tick{

    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSUInteger units = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];
    
    NSLog(@"%@:%@:%@", @(components.hour), @(components.minute), @(components.second));
    
    CGFloat hoursAngle = components.hour / 12.0 * M_PI * 2.0;
    
    CGFloat minsAngle = components.minute / 60.0 * M_PI * 2.0;
    
    CGFloat secondAngle = components.second / 60.0 * M_PI * 2.0;
    
    self.hourHand.transform = CGAffineTransformMakeRotation(hoursAngle);
    
    self.minuteHand.transform = CGAffineTransformMakeRotation(minsAngle);
    
    self.secondHand.transform = CGAffineTransformMakeRotation(secondAngle);
    
    
    
    
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
