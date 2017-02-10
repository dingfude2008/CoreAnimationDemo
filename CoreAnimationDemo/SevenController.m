//
//  SevenController.m
//  CoreAnimationDemo
//
//  Created by DFD on 2017/2/9.
//  Copyright © 2017年 DFD. All rights reserved.
//

#import "SevenController.h"
#import <QuartzCore/QuartzCore.h>
#import <GLKit/GLKit.h>
#import <CoreText/CoreText.h>

@interface SevenController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *labelView;

@end

@implementation SevenController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setCATextLayerAttributedView];
    
    
}

- (void)setCATextLayerAttributedView{
    
    CATextLayer *textLayer = [CATextLayer layer];
    
    textLayer.frame = self.labelView.bounds;
    
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    
    [self.labelView.layer addSublayer:textLayer];

    
    textLayer.alignmentMode = kCAAlignmentJustified;
    
    textLayer.wrapped = YES;
    
    UIFont *font = [UIFont systemFontOfSize:15];
    
    NSString *text = @"Lorem ipsum dolor sit amet, consectetur adipiscing \
    elit. Quisque massa arcu, eleifend vel varius in, facilisis pulvinar \
    leo. Nunc quis nunc at mauris pharetra condimentum ut ac neque. Nunc \
    elementum, libero ut porttitor dictum, diam odio congue lacus, vel \
    fringilla sapien diam at purus. Etiam suscipit pretium nunc sit amet \
    lobortis";
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text];
    
    // 转换 UIFont 到 CTFont
    
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    
    CGFloat fontSize = font.pointSize;
    
    CTFontRef fontRef = CTFontCreateWithName(fontName, fontSize, NULL);
    
    NSDictionary *attribs = nil;
    
    [string setAttributes:attribs range:NSMakeRange(0, [text length])];
    attribs = @{
               (__bridge id)kCTForegroundColorAttributeName: (__bridge id)[UIColor redColor].CGColor,
               (__bridge id)kCTUnderlineStyleAttributeName: @(kCTUnderlineStyleSingle),
               (__bridge id)kCTFontAttributeName: (__bridge id)fontRef
                    };
    [string setAttributes:attribs range:NSMakeRange(6, 5)];
    
    //release the CTFont we created earlier
    CFRelease(fontRef);
    
    //set layer text
    textLayer.string = string;
    
    /*
     IOS6 之前，UILabel 的内部绘制机制使用时的 WebKit， 之后改为了 Core Text, 使用 CATextLayer 渲染和使用 UILabel渲染出的文本行距和字距也是有些不一样的，总体来说还是很小的
     */
    
}



- (void)setCATextLayerView{
    
    /*
     CATextLayer
     
     如果想在图层中显示文字，可以借助 图层代理直接将字符串使用 Core Graphics 写入图层内容。这就是 UILabel的精髓
     
     
     */
    
    //create a text layer
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame = self.labelView.bounds;
    [self.labelView.layer addSublayer:textLayer];
    
    //set text attributes
    textLayer.foregroundColor = [UIColor blackColor].CGColor;
    textLayer.alignmentMode = kCATruncationNone;//kCAAlignmentJustified
    textLayer.wrapped = YES;
    
    //choose a font
    UIFont *font = [UIFont systemFontOfSize:15];
    
    //set layer font
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    textLayer.font = fontRef;       // CFTypeRef 类型
    textLayer.fontSize = font.pointSize;
    CGFontRelease(fontRef);
    
    //choose some text
    NSString *text = @"Lorem ipsum dolor sit amet, consectetur adipiscing \
    elit. Quisque massa arcu, eleifend vel varius in, facilisis pulvinar \
    leo. Nunc quis nunc at mauris pharetra condimentum ut ac neque. Nunc elementum, libero ut porttitor dictum, diam odio congue lacus, vel \
    fringilla sapien diam at purus. Etiam suscipit pretium nunc sit amet \
    lobortis";
    
    //set layer text  // 这个是 id 类型，可是使用 NSAttributedString 富文本
    textLayer.string = text;
    
    // 防止layer像素化
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    
    
}

- (void)setShaperView{
    
    
    /*
     
     CAShapeLayer 相对于 CALayer 的优点
     1，渲染快速
     2，高校使用内存
     3，不会被图层边界才切掉
     4，不会出现像素化
     
     */
    
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    //    [path moveToPoint:CGPointMake(175, 100)];
    
    [path addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:0 endAngle:2*M_PI clockwise:YES];
    [path moveToPoint:CGPointMake(150, 125)];
    
    [path addLineToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(125, 225)];
    //
    [path moveToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(175, 225)];
    [path moveToPoint:CGPointMake(100, 150)];
    [path addLineToPoint:CGPointMake(200, 150)];
    
    //create shape layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 5;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    //add it to our view
    [self.containerView.layer addSublayer:shapeLayer];
    
    CGRect rect = CGRectMake(40, 40, 100, 100);
    CGSize radii = CGSizeMake(20, 20);
    UIRectCorner corners = UIRectCornerTopRight | UIRectCornerBottomRight | UIRectCornerBottomLeft;
    //create path
    UIBezierPath *path1 = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    
    
    CAShapeLayer *shapeLayer1 = [CAShapeLayer layer];
    shapeLayer1.strokeColor = [UIColor redColor].CGColor;
    shapeLayer1.fillColor = [UIColor clearColor].CGColor;
    shapeLayer1.lineWidth = 5;
    shapeLayer1.lineJoin = kCALineJoinRound;
    shapeLayer1.lineCap = kCALineCapRound;
    shapeLayer1.path = path1.CGPath;
    //add it to our view
    [self.containerView.layer addSublayer:shapeLayer1];
    
    UIBezierPath *path2 = [[UIBezierPath alloc] init];
    [path2 moveToPoint:CGPointMake(100, 100)];
    [path2 addLineToPoint:CGPointMake(200, 100)];
    
    [path2 moveToPoint:CGPointMake(150, 100)];
    [path2 addLineToPoint:CGPointMake(150, 250)];
    
    [path2 moveToPoint:CGPointMake(150, 250)];
    [path2 addLineToPoint:CGPointMake(140, 240)];
    
    CAShapeLayer *shapeLayer2 = [CAShapeLayer layer];
    shapeLayer2.strokeColor = [UIColor blackColor].CGColor;
    shapeLayer2.fillColor = [UIColor blackColor].CGColor;
    shapeLayer2.lineWidth = 3;
    shapeLayer2.lineJoin = kCALineJoinRound;
    shapeLayer2.lineCap = kCALineCapRound;
    shapeLayer2.path = path2.CGPath;
    
    [self.view.layer addSublayer:shapeLayer2];
    
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
