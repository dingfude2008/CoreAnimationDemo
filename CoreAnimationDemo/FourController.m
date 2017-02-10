//
//  FourController.m
//  CoreAnimationDemo
//
//  Created by DFD on 2017/2/7.
//  Copyright © 2017年 DFD. All rights reserved.
//

#import "FourController.h"

@interface FourController ()
@property (weak, nonatomic) IBOutlet UIView *whiteView;

@property (strong, nonatomic) IBOutlet UIView *greenView;
@property (weak, nonatomic) IBOutlet UIView *purpleView;

@property (weak, nonatomic) IBOutlet UIView *grayView;
@property (weak, nonatomic) IBOutlet UIImageView *maskImageView;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *digitViews;

@property (weak, nonatomic) NSTimer *timer;
@end

@implementation FourController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.whiteView.layer.cornerRadius = 20;
    self.whiteView.layer.masksToBounds = YES;
    
    self.greenView.layer.cornerRadius = 20;
    self.purpleView.layer.cornerRadius = 20;
    
    self.greenView.layer.masksToBounds = YES;
//    self.purpleView.layer.masksToBounds = YES;
    
    // 指定 寄宿图
    UIImage *image = [UIImage imageNamed:@"clockBackground"];
    self.purpleView.layer.contents = (__bridge id)image.CGImage;
    self.purpleView.layer.contentsGravity = kCAGravityResizeAspect;
    
    // borderWidth, borderColor
    // 注意，边框是跟随图层的边界变化的，而不是图层里面的内容
    
    
    // 阴影
    // 必须在 0 - 1 之间
    self.purpleView.layer.shadowOpacity = 0.5;
    self.purpleView.layer.shadowColor = [UIColor redColor].CGColor;
    self.purpleView.layer.shadowRadius = 12;
//    self.purpleView.layer.masksToBounds = YES;
    // 注意，如果使用了阴影的话， 再使用裁切， masksToBounds就会把阴影裁切掉
    
    self.purpleView.layer.shadowOffset = CGSizeMake(0, -3);
    // shadowOffset 是一个 CGSzie 宽度控制着横向位移， 高度控制着纵向的位移
    // {0, -3}意味着阴影相对着Y轴有3个点的位移，这和 Mac OS 是相反的
    
    /// shadowRadius 控制着阴影的模糊度，越大，越自然
    
    //  注意： 和图层边框不同，阴影继承自内容的外形，而不是根据边界和角半径来确定的，
    //        为了计算阴影的形状， Core Animation 会将寄宿图（包括子视图，如果有的话）考虑在内，然后通过这些完美搭配图形状来创建一个阴影。
    
    // 裁切是根据边界进行的，所以会把根据内容算出来的阴影裁切掉。如果像沿着内容裁切，就需要使用两个图层，一个只画阴影的外图层，和一个裁切内容的内图层
    // 外图层阴影，内图层裁切
    
    
    // 边框是沿着边界的， 但是阴影是按着内容的
    self.purpleView.layer.borderColor = [UIColor blueColor].CGColor;
    self.purpleView.layer.borderWidth = 1.0;
    
    
    
    
    // shadowPath
    // 因为实时的阴影是很消耗资源的，如果事先指定 shadowPath，会提高性能
    
//    self.purpleView.layer.shadowPath
    
    
    self.grayView.layer.borderColor = [UIColor greenColor].CGColor;
    self.grayView.layer.borderWidth = 2;
    
    
    // 设置阴影 0-1 之间
    self.grayView.layer.shadowOpacity = 0.5;
    
    self.grayView.layer.shadowColor = [UIColor redColor].CGColor;
    
    self.grayView.layer.shadowRadius = 3;
    
    // 这是一个简单的 CGPath, 如果图像复杂的话，可以使用 UIBezierPath
    
    CGMutablePathRef squarePath = CGPathCreateMutable();
    
//    CGPathAddRect(squarePath, NULL, self.greenView.bounds);   // 方形的
    
    CGPathAddEllipseInRect(squarePath, NULL, self.grayView.bounds); // 圆形的
    
    
    self.grayView.layer.shadowPath = squarePath;
    
    CGPathRelease(squarePath);
    
//    UITabBarController
    
    
    // mask  属性，是 CALayer 类型，
    // 类似于一个子视图，拥有父图层（即拥有属性的图层）布局，不同与普通子视图，它定义了父图层的部分可见区域
    // mask 图层的 Color属性是没用的，真正重要的是图层的轮廓，mask 属性就像是一个饼干切割机，mask 图层的实心部分会被保留，其他部分会被抛弃，如果 mask 图层比父图层要小，只有 mask 图层的内容才是它关心的，其他的都被隐藏起来了
    
//    CALayer
    
    // 下面这段代码展示了，给一个 UIImageView  添加一个了子图层，这个子图层有一个 mask 设置的是另一个图片，效果就变成了 两个图片的融合
    
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = self.maskImageView.bounds;
    
    UIImage *imageMask = [UIImage imageNamed:@"mask"];
    maskLayer.contents = (__bridge id)image.CGImage;
    
    self.maskImageView.layer.mask = maskLayer;
    
    
    // 拉伸过滤
    // 正常显示的图片，不应该出现拉伸
//    self.maskImageView.layer.minificationFilter
//    self.maskImageView.layer.magnificationFilter
    
    // CALayer 提供了三种拉伸过滤的方法
    
//    kCAFilterLinear
//    kCAFilterNearest
//    kCAFilterTrilinear
    
    // 缩小图片 和 放大图片默认的过滤器采用的是 kCAFilterLinear, 双线性滤波算法，这种算法比较常用，缺点是放大倍数过大会照成模糊
    
    // kCAFilterTrilinear 三线性滤波算法相对 kCAFilterLinear 没多大差别，不过它储存了多个大小相同的图片，并三维取样，同时结合大图小图的存储而得到最后的结果。这个方法的好处在于算法能够从一系列已经接近最终大小的图片中得到想要的结果，也就是不要对很多像素取样，也能避免小概率因舍入错误引起的取样失灵的问题
    
        //对于大图，双线性滤波比三线性滤波表现的更出色
     
    //  kCAFilterNearest 是一种比较武断的方法，就是取样最近的单像素点而不管其他的样色，这样做非常快，也不会是图片模糊，但是最明显的效果就是，会使得压缩图片更糟，图片放大之后也显得块状和马赛克严重
    
    ///  结论， 线性保留了形状，最近滤波保留了像素的差异
    
    
    
    
    UIImage *digits = [UIImage imageNamed:@"Digits.png"];
    
    
    for (UIView *view in self.digitViews) {
        
        view.layer.contents = (__bridge id)digits.CGImage;
        
        view.layer.contentsRect = CGRectMake(0, 0, 0.1, 1);
        
        view.layer.contentsGravity = kCAGravityResizeAspect;
        
        // 当默认的 线性滤波不清楚的时候，可以换这个滤波取样进行测试
        view.layer.magnificationFilter = kCAFilterNearest;
    }
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    
    [self tick];
}


- (void)tick{
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSUInteger units = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];
    
    NSLog(@"%@:%@:%@", @(components.hour), @(components.minute), @(components.second));
    
    
    [self setDit:components.hour / 10 forView:self.digitViews[0]];
    [self setDit:components.hour % 10 forView:self.digitViews[1]];
    
    
    
    [self setDit:components.minute / 10 forView:self.digitViews[2]];
    [self setDit:components.minute % 10 forView:self.digitViews[3]];
    
    
    [self setDit:components.second / 10 forView:self.digitViews[4]];
    [self setDit:components.second % 10 forView:self.digitViews[5]];
    
    
    // 组透明
    
    // 
    
    
    
    
}

- (void)setDit:(NSInteger)digit forView:(UIView *)view{
    view.layer.contentsRect = CGRectMake(0.1 * digit, 0, 0.1, 1);
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
