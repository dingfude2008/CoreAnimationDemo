//
//  eigthController.m
//  CoreAnimationDemo
//
//  Created by DFD on 2017/2/11.
//  Copyright © 2017年 DFD. All rights reserved.
//

#import "EigthController.h"
#import "FastCATiledLayer.h"

@interface EigthController ()<CALayerDelegate>
{
     CGFloat scale;
}



@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation EigthController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    scale = [UIScreen mainScreen].scale;
    
    /*
     
     CASrollLayer 是为了解决 CAShapeLayer 使用 contentRect 切片显示总是需要计算的问题， CASrollLayer 的方法 -scrollToPoint，会自动适应 bounds 的原点，以便图层内容出现在滚动过的地方。 但是 它不处理触摸事件，也不处理 滑动反弹
     
     
     */
    
    
    
    /*
     
     CATiledLayer 为载入大图造成的性能问题提供了解决方案：将大图分解为小片然后将他们单独加载。
     
     把 TiledLayerDemo  切好的小图拖入项目中
     
     目的：  不加载大图，而是把大图裁切成很多小图，在用户拖动显示的时候，把需要显示的小图加载的界面上，以节省内存。
     
     
     
     
     */
    
    
    
    FastCATiledLayer *tileLayer = [FastCATiledLayer layer];
    
    // 适配 Retina
    tileLayer.frame = CGRectMake(0, 0, 2560 / scale, 1600 / scale);
    tileLayer.delegate = self;
    
    // 适配 Retina
    tileLayer.contentsScale = [UIScreen mainScreen].scale;
    
    // 默认的行为是，在载入内存，显示在屏幕的时候，有一种淡入的效果，这是 CATiledLayer 的默认行为
    
    
    [self.scrollView.layer addSublayer:tileLayer];
    
    self.scrollView.contentSize = tileLayer.frame.size;
    
    
    [tileLayer setNeedsDisplay];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



// 加载的回调
#pragma mark - CALayerDelegate  // 这里直接修改参数
- (void)drawLayer:(CATiledLayer *)layer inContext:(CGContextRef)ctx{

    CGRect bounds = CGContextGetClipBoundingBox(ctx);
    
    NSInteger x = floor(bounds.origin.x / layer.tileSize.width * scale);
    NSInteger y = floor(bounds.origin.y / layer.tileSize.height * scale);
    
//    NSLog(@"1");
    
    
    //load tile image
    NSString *imageName = [NSString stringWithFormat: @"Snowman_%02d_%02d", (int)x, (int)y];
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"jpg"];
    UIImage *tileImage = [UIImage imageWithContentsOfFile:imagePath];
    
    //draw tile
    
    UIGraphicsPushContext(ctx);
    [tileImage drawInRect:bounds];
    UIGraphicsPopContext();
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
