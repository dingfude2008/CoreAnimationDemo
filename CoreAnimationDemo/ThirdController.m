//
//  ThirdController.m
//  CoreAnimationDemo
//
//  Created by DFD on 2017/2/7.
//  Copyright © 2017年 DFD. All rights reserved.
//

#import "ThirdController.h"

@interface ThirdController (){
    CALayer *bluelayer;
}
@property (weak, nonatomic) IBOutlet UIView *layerView;

@end

@implementation ThirdController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 坐标系
    
    
    // 一个图层的 position 依赖于父图层的 bounds
    // 一个视图的 center   依赖于父视图的 bounds
    // 移动父视图，或者父图层就可以移动整个子视图，子图层
    
    // CALayer
    // 转换 layer 左边的方式
    
    
//    - (CGPoint)convertPoint:(CGPoint)p fromLayer:(nullable CALayer *)l;
//    - (CGPoint)convertPoint:(CGPoint)p toLayer:(nullable CALayer *)l;
//    - (CGRect)convertRect:(CGRect)r fromLayer:(nullable CALayer *)l;
//    - (CGRect)convertRect:(CGRect)r toLayer:(nullable CALayer *)l;
    
    
    // 翻转的几何结构
    
    // 在 iOS 中， 一个图层的 position 是相对于父视图的左上角， 但是 Mac OS 通常是相对于左下角，可以通过这个属性进行翻转
    
    
    bluelayer = [CALayer layer];
    
    // 默认是 NO
    //bluelayer.geometryFlipped = YES;  // 这就就是翻转了，他会影响到所有子视图，如果姿势图不想被一起翻转，需要再翻转过来
    
    
    // Z 轴坐标轴
    
    // UIView 是二维坐标系，CALayer 存在一个三维空间当中
    
    // 这两个是二维的
//    bluelayer.position
//    bluelayer.anchorPoint
    
    // 相应的三维的是 注意这两个值是 CGFloat类型
//    bluelayer.zPosition
//    bluelayer.anchorPointZ
    
    // zPOsition 通常用来改变图层的顺序
    // 通常，图层是根据它们的子图层的 subLayers 出现的顺序来绘制的，后面的图层会覆盖掉前面的图层，通过 zPosition就可以把图层向相机方向前置
    
    // 默认值是 0
    // 当提高一个图层的 zPosition = 1 的时候，就会在默认的图层上面显示
    //bluelayer.zPosition = 1.0;
    
    
    // Hit Testing
    
    // CALayer 的这两个方法 可以帮助处理事件
    
    //
    // - (nullable CALayer *)hitTest:(CGPoint)p;
    
    // 接受一个本图层坐标系下的CGPoint, 如果这个点在图层的 frame范围内就返回 YES,
    // - (BOOL)containsPoint:(CGPoint)p;
    
    
    //CALayer *bluelayer = [CALayer layer];
    bluelayer.frame = CGRectMake(50, 50, 100, 100);
    bluelayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.layerView.layer addSublayer:bluelayer];
    
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    // 获取在 self.view 中的坐标
    CGPoint point = [[touches anyObject] locationInView:self.view];
    
    // 转换坐标
//    point = [self.layerView.layer convertPoint:point fromLayer:self.view.layer];
//    
//    
//    if ([self.layerView.layer containsPoint:point]) {
//        
//        NSLog(@"白色区域");
//        point = [bluelayer convertPoint:point fromLayer:self.layerView.layer];
//        
//        if([bluelayer containsPoint:point]){
//            NSLog(@"蓝色区域");
//        }
//    }
//    
//    
    
    // 这个方法不需要转换坐标
    // 并且测算的顺序严格按照图层树当中的图层顺序（类似于 UIView 的事件处理顺序）
    // zPosition 可以改变屏幕上的显示顺序，但是不能改变时间的传递顺序
    // 这就意味着，当通过改变 zPosition 来让后面的视图覆盖前面的视图的时候，就会发现不能检测到最前方的视图点击点，这是因为被后面的视图遮盖住了，虽然它的zPosition小，但是在图层树中的顺序靠前。
    
    CALayer *layer = [self.layerView.layer hitTest:point];
    
    if (layer == bluelayer) {
        NSLog(@"蓝色");
    } else if (layer == self.layerView.layer){
        NSLog(@"白色");
    }
    
    
    // 自动布局
    
    // Mac OS 中 CALayer 有一个 layoutManger 的属性， 可以通过 CALayoutManager 协议和 CAConstraintLayoutManger 类来实现自动排版布局，但是在 iOS 上并不适用
    
    // 使用 视图的时候，可以充分使用 UIView 类的接口 UIViewAutoresizing 和 NSLayoutConstraint 来实现布局
    
//    UIViewAutoresizing 自动适配
//    NSLayoutConstraint 自动布局
    
    //
//    self.view.autoresizingMask
//    self.view.constraints
    
    // 但是如果像随意操作 CALayer 就需要手动操作， 最简单的方法就是实现 CALayerDelegate
    // 当图层的 bounds 发生改变的时候， 或者手动调用 setNeedLayout 的时候，这个回调就会执行，可以在这里设置子图层的位置
    // - (void)layoutSublayersOfLayer:(CALayer *)layer;
    
    // 但是不能想 UIView 的 autoresizingMask 和 constraints 做到屏幕的自动旋转。
    // 这也是为什么最好使用视图而不是单独的图层的一个重要原因
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
