//
//  PresentationModelController.m
//  CoreAnimationDemo
//
//  Created by DFD on 2017/2/16.
//  Copyright © 2017年 DFD. All rights reserved.
//

#import "PresentationModelController.h"

@interface PresentationModelController ()

@property (nonatomic, strong)  CALayer *colorLayer;

@end

@implementation PresentationModelController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    /*
     
        CALayer 的属性，设置后，如果有行为动画，会在动画后进行。但是它的值在赋值的一瞬间就已经是新值了，不过期间的动画可能会超过 1/60 秒，所以在 iOS 刷新屏幕的时候没有在屏幕上立刻显示出新值，只能在设置成一个中间值，就形成了动画
     
        在最终的结果之前，显示的值被储存在一个 呈现图层中。 可以通过 -presentationLayer访问，这个呈现视图的值是当前屏幕上真正显示出来的值。
     
        self.view.layer.presentationLayer

        presentationLayer 只有在 属性首次提交（就是首次在屏幕上显示）的时候创建，之前调用返回的都是 nil
        
        modelLayer 模型图层
     
        在 presentationLayer 上调用 modelLayer返回的时候 - self
     
        self.view.layer.presentationLayer.modelLayer
    
     
     
        一般情况下，并不需要使用 呈现图层，。在下面两种情况下变得很有用，1，同步动画，2，处理用户交互
     
        1，如果实现一个基于定时器的动画，而不仅仅是基于事务的动画，这个时候需要准确的知道在某一个时刻图层显示在什么位置，就对正确摆放图层很有用了
        2，如果要实现动画图层的用户输入，可以使用 hitTest:方法，这时候对呈现图层而不是模型图层。这个时候点击的位置要相对呈现图层的位置。而不是动画结束之后的位置
     
     */
    
    
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(0, 0, 100, 100);
    self.colorLayer.position = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2);
    self.colorLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:self.colorLayer];
    
    
    self.colorLayer.borderColor = [UIColor redColor].CGColor;
    self.colorLayer.borderWidth = 2;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self.view];
    
    // 检查是否点击在 移动的 layer上
    
    // self.colorLayer.
    
    // self.colorLayer.presentationLayer  作用于这个的时候，是检查显示的图层是否命中
    // self.colorLayer 作用于这个的时候，是检查动画结束的时候的图层是否命中
    if ([self.colorLayer hitTest:point]){
        //randomize the layer background color
        CGFloat red = arc4random() / (CGFloat)INT_MAX;
        CGFloat green = arc4random() / (CGFloat)INT_MAX;
        CGFloat blue = arc4random() / (CGFloat)INT_MAX;


        self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    } else {
        [CATransaction begin];
        
        [CATransaction setAnimationDuration:4.0];
        
        self.colorLayer.position = point;
        
        [CATransaction commit];
    }
    
    
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
