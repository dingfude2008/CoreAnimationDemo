//
//  eigthController.m
//  CoreAnimationDemo
//
//  Created by DFD on 2017/2/11.
//  Copyright © 2017年 DFD. All rights reserved.
//

#import "EigthController.h"

@interface EigthController ()<CALayerDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation EigthController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    /*
     
     CASrollLayer 是为了解决 CAShapeLayer 使用 contentRect 切片显示总是需要计算的问题， CASrollLayer 的方法 -scrollToPoint，会自动适应 bounds 的原点，以便图层内容出现在滚动过的地方。 但是 它不处理触摸事件，也不处理 滑动反弹
     
     
     */
    
    
    
    /*
     
     CATiledLayer 为载入大图造成的性能问题提供了解决方案：将大图分解为小片然后将他们单独加载。
     
     */
    
    
    
    CATiledLayer *tileLayer = [CATiledLayer layer];
    tileLayer.frame = CGRectMake(0, 0, 2048, 2048);
    tileLayer.delegate = self;
    
    
    [self.scrollView.layer addSublayer:tileLayer];
    
    self.scrollView.contentSize = tileLayer.frame.size;
    
    
    [tileLayer setNeedsDisplay];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - CALayerDelegate  // 这里直接修改参数
- (void)drawLayer:(CATiledLayer *)layer inContext:(CGContextRef)ctx{

    CGRect bounds = CGContextGetClipBoundingBox(ctx);

//    NSLog(@"1");
    
//    NSLog(@"")
//
    
    NSInteger x = floor(bounds.origin.x / layer.tileSize.width);
    NSInteger y = floor(bounds.origin.y / layer.tileSize.height);
    
    NSLog(@"1");
    
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
