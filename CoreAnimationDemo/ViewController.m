//
//  ViewController.m
//  CoreAnimationDemo
//
//  Created by DFD on 2017/2/6.
//  Copyright © 2017年 DFD. All rights reserved.
//

#import "ViewController.h"
#import "CAMediaTimingController.h"
#import "CAAnimationVelocityController.h"

@interface ViewController ()<CALayerDelegate, UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIView *test1View;


@property (weak, nonatomic) IBOutlet UIView *layerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    CALayer *bluelayer = [CALayer layer];
    bluelayer.frame = CGRectMake(50, 50, 100, 100);
    bluelayer.backgroundColor = [UIColor blueColor].CGColor;
    
    [self.layerView.layer addSublayer:bluelayer];
    
    
//    UIImage *image = [UIImage imageNamed:@"snowman"];
//    
//    bluelayer.contents = (__bridge id)image.CGImage;
//    
//    // 
//    bluelayer.contentsGravity = kCAGravityResizeAspect;
//    
//    bluelayer.contentsGravity = kCAGravityCenter;
    
    
//    self.view.contentMode = UIViewContentModeScaleAspectFit;
    
    
//    bluelayer.contentsScale = 1.0;
    
    // 定义了寄宿图的像素尺寸和视图大小的比例，默认情况下是 1.0.  因为有设置过 contentsGravity 属性，图片已经被拉伸
    // contentScale 支持 Retina 屏幕，它被用来判断绘制图层的时候应该为寄宿图创建的空间的大小和需要显示图片的拉伸度（假如没有设置contentsGravity的情况下） UIView 中有一个类似的属性， contentScaleFactor
    
    // contentsScale 1.0 会以一个点 1 个小像素来绘制图片
    // contentsScale 2.0 会以一个点 2 个小像素来绘制图片， 就是 Retina 屏幕
    
    // 这个属性的设置并不会对我们使用 kCAGravityResizeAspect 造成影响，因为他是拉伸图片来适应图层而已，并不会考虑分辨率的问题，但是如果设置为 kCAGravityCenter 就会受到影响
    // 结果是，整个图片铺满了屏幕，这是因为， contentsScale 设置成了 1.0 ，但是显示在了 Retina 屏幕上，看起来图片还有点像素的颗粒感，这是因为，UIImage 和 CGImage 不同，CGImage 没有拉伸的概念，当我们用 UIImage 读取图片时，读取的是 高质量的 Retina 版本的图片，但是我们又用CGImage来设置图像内如时，拉伸这个因素在转换的时候就丢失了，不过我们可以通过手动设置 contentsScale 来修复
    
    
    self.view.layer.contentsScale = [UIScreen mainScreen].scale;
    
//    bluelayer.contentsScale = image.scale;
    
    // 相当于是 ，   裁切
    // self.view.clipsToBounds = YES;
    
    bluelayer.masksToBounds = YES;
    
    
    // 这个属性是使用了 单位坐标
    // bluelayer.contentsRect
    
    
    // 点，最常用的坐标体系，虚拟像素，也是逻辑像素，在普通的屏幕上大小 1*1， 在 Retina屏幕上， 是 2*2
    
    // 像素，物理像素的点，但是并不会用来布局，  底层的，如CGImage 就会使用像素，所以也就造成了 使用 CGImage 在普通屏幕上和 Renita 屏幕上的不同
    
    // 单位， 很方便的显示， 也经常用在 openGL中
    
    
    // 默认的 contentsRect = { 0， 0， 1， 1 } 这也意味着这个寄宿图片都是可见的，
    
    // 事实上，给 contentRect 设置一个负数的原点，或者是大于  { 1， 1} 也是可以的，这种情况下，最外面的像素就会拉伸以填充剩下的区域
    
    
    // contentsRect 最有意思的就是 图片拼合，利用区域显示，对一张图片进行不同区域的显示， 这种好处有 1，内存使用，载入时间，渲染性能提升等
    
    //
    

    
//    self.test1View.layer.contents = (__bridge id)image.CGImage;
    
//    self.test1View.layer.contentsGravity = kCAGravityResizeAspect;
    
    self.test1View.layer.contentsRect = CGRectMake(0, 0, 0.5, 0.5);
    
    // Mac 上有一些软件可以自动拼合图片，并会生成一包含拼合坐标的 XML或者 plist 文件。
    
    // https://github.com/nicklockwood/LayerSprites 这个开源库
    
    
    // contentsCenter
    // 定义了一个固定的边框和一个在图层上可以拉伸的区域
    // 改变contentsCenter 不会影响到寄宿图的显示，除非这个图层的大小改变了。
    // 默认情况下 contentsCenter 是 { 0， 0， 1， 1}  这意味着大小（由 contentGravity 决定）改变了，那么寄宿图就会均匀的拉伸，但是如果我们增加了原点的值，并减小尺寸，就会像 图片裁切中间设置的那样，拉伸中间的，被隔离的不变 类似于  UIImage 的image resizableImageWithCapInsets:<#(UIEdgeInsets)#> resizingMode:<#(UIImageResizingMode)#> 这个方法
    
    //
    
    
    
    
    // ----------
    
    // Custom Drawing
    
    // 通过  - drawRect:
    
    // 当 UIView 检测到 drawRect 被创建了， 会默认生成一张寄宿图， 这个寄宿图的像素尺寸等于视图大小 * contentScale
    
    // 如果没有自定义绘制的任务，不建议使用这个。
    
    // drawRect 创建的寄宿图会被缓存起来，只等再次更新， 调用 setNeedDisplay 会导致 再次更新。 创建和缓存寄宿图是由 CALayer操作的
    
    // 有一个 CALayerDelegate 协议
    
    // 当需要重绘时，CALayer就会请求他的代理个他一个寄宿图来显示，他通过这个代理方法做到的
    // 可以在这个代理方法中设置 contents 的属性
    // - (void)displayLayer:(CALayer *)layer;
    
    //  如果上面的代理方法没有实现，就会走下面的这个代理方法
    // 在调用这个方法之前 CALayer 会创建一个合适尺寸的空寄宿图，尺寸有bounds 和 contentScale 决定，和一个 Core Graphics 的绘制上下文环境，为绘制寄宿图做准备， 他作为 ctx 参数传入
    // - (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx;
    
    /* If defined, called by the default implementation of the -display method.
     * Allows the delegate to configure any layer state affecting contents prior
     * to -drawLayer:InContext: such as `contentsFormat' and `opaque'. It will not
     * be called if the delegate implements -displayLayer. */
    
    // - (void)layerWillDraw:(CALayer *)layer
    
    
    /* Called by the default -layoutSublayers implementation before the layout
     * manager is checked. Note that if the delegate method is invoked, the
     * layout manager will be ignored. */
    
    // - (void)layoutSublayersOfLayer:(CALayer *)layer;
    
    /* If defined, called by the default implementation of the
     * -actionForKey: method. Should return an object implementating the
     * CAAction protocol. May return 'nil' if the delegate doesn't specify
     * a behavior for the current event. Returning the null object (i.e.
     * '[NSNull null]') explicitly forces no further search. (I.e. the
     * +defaultActionForKey: method will not be called.) */
    
//    - (nullable id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)event;
    
//    bluelayer.delegate
    
    
    bluelayer.delegate = self;
    
    // 不同于 UIView， layer 显示在屏幕上，不会自动重绘它的内容，需要显式的调用 display
    [bluelayer display];
}

// 通常我们不使用 layer 的代理，而是在 UIView 的 drawRect 方法中实现，包括帮我们调用 display 方法
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    
    
    
    // 设置线宽
    CGContextSetLineWidth(ctx, 10.0);
    
    // 设置线的颜色
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    
    // 当使用代理进行寄宿图绘制的时候，并不会绘制超出这个边界。
    // 填充
    CGContextStrokeEllipseInRect(ctx, layer.bounds);
}

- (IBAction)buttonClick:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Go" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"1",@"2",@"3",@"4", nil];
    [actionSheet showInView:self.view];
    
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    UIViewController *vc;
    switch (buttonIndex + 1) {
        case 1:
            vc = [[CAMediaTimingController alloc] init];
            break;
        case 2:
            vc = [[CAAnimationVelocityController alloc] init];
            
            break;
        case 3:
            
            break;
        case 4:
            
            break;
            
        default:
            break;
    }
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
