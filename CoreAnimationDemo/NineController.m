//
//  NineController.m
//  CoreAnimationDemo
//
//  Created by DFD on 2017/2/14.
//  Copyright © 2017年 DFD. All rights reserved.
//

#import "NineController.h"
#import <QuartzCore/QuartzCore.h>

@interface NineController ()

@end

@implementation NineController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // CAEmitterLayer 高性能的粒子引擎
    
    /*
     
     
     
     */
    
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    
    emitter.frame = self.view.bounds;
    
    [self.view.layer addSublayer:emitter];
    
    // 混合模式 混合在一起会更亮
    emitter.renderMode = kCAEmitterLayerAdditive;
    
    // 发射位置
    emitter.emitterPosition = CGPointMake(emitter.bounds.size.width / 2.0, emitter.bounds.size.height / 2.0);
    
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    
    cell.contents = (__bridge id)[UIImage imageNamed:@"speek"].CGImage;
    
    // 每一秒发射出的数量
    cell.birthRate = 150;
    
    // 存活时间
    cell.lifetime = 5.0;
    
    // 混合图片内容颜色的混合色
    cell.color = [UIColor colorWithRed:1 green:0.5 blue:0.1 alpha:1.0].CGColor;
    
    // 在时间线上变化，每过1秒，透明度减少 0.4
    cell.alphaSpeed = -0.4;

    // 初始速度，初始的范围
    cell.velocity = 50;
    cell.velocityRange = 50;
    
    // 扩散范围，这 2pi, 就是  360度的扩散出去
    cell.emissionRange = M_PI * 2.0;
    
    emitter.emitterCells = @[cell];
    
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
