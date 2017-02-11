//
//  eigthController.m
//  CoreAnimationDemo
//
//  Created by DFD on 2017/2/11.
//  Copyright © 2017年 DFD. All rights reserved.
//

#import "EigthController.h"

@interface EigthController ()

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
