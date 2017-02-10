//
//  FiveController.m
//  CoreAnimationDemo
//
//  Created by DFD on 2017/2/7.
//  Copyright © 2017年 DFD. All rights reserved.
//

#import "FiveController.h"

#define RADIAS_TO_DEGREES(x) ((x)/M_PI* 180.0)

@interface FiveController ()
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UIView *layerView;

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *layerView1;
@property (weak, nonatomic) IBOutlet UIView *layerView2;





@end

@implementation FiveController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button1 = [self customButton];
    button1.center = CGPointMake(50, 150);
//    button1.alpha = 0.5;
    [self.view addSubview:button1];
    
    //create translucent button
    UIButton *button2 = [self customButton];
    button2.center = CGPointMake(250, 150);
    button2.alpha = 0.5;
    [self.view addSubview:button2];
    
    //enable rasterization for the translucent button
    button2.layer.shouldRasterize = YES;
    button2.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    
    
    // 使用栅格化，
    
    
    // 旋转角度
    // CGAffineTransformMakeRotation(<#CGFloat angle#>)
    
    // 缩放
    // CGAffineTransformMakeScale(<#CGFloat sx#>, <#CGFloat sy#>)
    
    // 平移
    // CGAffineTransformMakeTranslation(<#CGFloat tx#>, <#CGFloat ty#>)
    
    
    UIImage *image = [UIImage imageNamed:@"clockBackground"];
    
    self.layerView.layer.contents = (__bridge id)image.CGImage;
    
    self.layerView.layer.contentsGravity = kCAGravityResizeAspect;
    
    // self.layerView.transform = CGAffineTransformMakeTranslation(10.0, 10.0);
    
    // self.layerView.transform = CGAffineTransformMakeRotation(M_PI_4);
    
    // 缩放 50%  -- 旋转 30度 -- 向右移动 200像素
    
    
//    CGAffineTransform tranfrom = CGAffineTransformIdentity;
//    
//    // 缩放 0.5
//    tranfrom = CGAffineTransformScale(tranfrom, 0.5, 0.5);
//    
//    // 旋转 30度
//    tranfrom = CGAffineTransformRotate(tranfrom, M_PI / 180.0 * 30);
//    
//    // 平移 x轴 100像素
//    tranfrom = CGAffineTransformTranslate(tranfrom, 100, 0);
//    
//    self.layerView.transform = tranfrom;
    
    
    
    // 3D 变换
    
    // CGAffineTransform 这个是2D类型的
    //
    // CATransform3D 这个是 3D 类型的
    
    
    // 旋转
    // CATransform3D tran3D = CATransform3DMakeRotation(<#CGFloat angle#>, <#CGFloat x#>, <#CGFloat y#>, <#CGFloat z#>)
    
    // 缩放
    // CATransform3D tran3D = CATransform3DMakeScale(<#CGFloat sx#>, <#CGFloat sy#>, <#CGFloat sz#>)
    
    // 平移
    // CATransform3D tran3D = CATransform3DMakeTranslation(<#CGFloat tx#>, <#CGFloat ty#>, <#CGFloat tz#>)
    
    // Z 轴的正方向是向屏幕外
    
    CATransform3D transform = CATransform3DIdentity;
    
    
    /*
        1 声明一个 3D 透视矩阵
        2 设置 m34， 在设置旋转等
        3 变化这个矩阵
    
     -1.0 / d 中 d 代表了视角相机和屏幕的距离，以像素为单位，通常设置 500 - 1000、
     减少距离会增强透视效果，相应的也就容易失真
     
     */
    
    
    
    transform.m34 = - 1.0 / 500.0;
    
    transform = CATransform3DRotate(transform, M_PI_4, 0, 1, 0);
    
    
    self.layerView.layer.transform = transform;
    
    
    
    /*
     灭点：当在透视角度绘图的时候，远离相机视角的物体将会变小变远，当远离到一个极限距离，它们可能就缩成了一个点，于是所有的物体最后都汇聚消失在同一个点。在现实中，这个点通常是视图的中心（图5.11），于是为了在应用中创建拟真效果的透视，这个点应该聚在屏幕中点，或者至少是包含所有3D对象的视图中点
     
     Core Animation定义了这个点位于变换图层的anchorPoint（通常位于图层中心，但也有例外，见第三章）。这就是说，当图层发生变换时，这个点永远位于图层变换之前anchorPoint的位置。
     
     当改变一个图层的position，你也改变了它的灭点，做3D变换的时候要时刻记住这一点，当你视图通过调整m34来让它更加有3D效果，应该首先把它放置于屏幕中央，然后通过平移来把它移动到指定位置（而不是直接改变它的position），这样所有的3D图层都共享一个灭点。
     
     
     */
    
    
    
    /*
     
     如果有多个视图和图层做 3D 变换，那就需要分别设置相同的 m34，以确保在变换之前都在屏幕中央共享一个position,
     
     CALayer 的 sublayerTransform 属性，也是一个 CATransform3D 类型，它会影响到所有子图层
     
     */
    
    self.layerView1.layer.contents = (__bridge id)image.CGImage;
    
    self.layerView1.layer.contentsGravity = kCAGravityResizeAspect;
    
    self.layerView2.layer.contents = (__bridge id)image.CGImage;
    
    self.layerView2.layer.contentsGravity = kCAGravityResizeAspect;
    
    
    
    
    
    
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1 / 500.0;
    
    self.containerView.layer.sublayerTransform = perspective;
    
    
    CATransform3D tran1 = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
    
    self.layerView1.layer.transform = tran1;
    
    CATransform3D tran2 = CATransform3DMakeRotation(M_PI, 0, 1, 0);
    
    self.layerView2.layer.transform = tran2;
    
    
    // 当设置  Y 轴旋转 180 的时候，图层的蒸面正好背对着我们，我们看到的值视图的镜像。
    
    // 为了节省 CPU,我们一般不绘制背面，设置 NO
    self.layerView2.layer.doubleSided = NO;
    
    
    
    /*
     
    绕 Z 轴旋转， 如果内部图层做了相对于外部图层相反的变换，就会抵消掉。
    
    但是绕 Y 轴， 就不会了，这是因为每个父图层都把它的子图层扁平化了。
     
     
     结果是
     */
    
    
    
}


- (UIButton *)customButton
{
    //create button
    CGRect frame = CGRectMake(0, 0, 150, 50);
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    button.backgroundColor = [UIColor whiteColor];
    button.layer.cornerRadius = 10;
    
    //add label
    frame = CGRectMake(20, 10, 110, 30);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = @"Hello World";
    label.textAlignment = NSTextAlignmentCenter;
    [button addSubview:label];
    return button;
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
