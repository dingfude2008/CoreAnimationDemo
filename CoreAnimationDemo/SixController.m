//
//  SixController.m
//  CoreAnimationDemo
//
//  Created by DFD on 2017/2/8.
//  Copyright © 2017年 DFD. All rights reserved.
//

#import "SixController.h"
#import <GLKit/GLKit.h>
#import <QuartzCore/QuartzCore.h>

#define LIGHT_DIRECTION   0, 1, -0.5
#define AMBIENT_LIGHT 0.5


@interface SixController ()
@property (weak, nonatomic) IBOutlet UIView *containerView; // (width = 343, height = 525)

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *faces;

- (IBAction)btnClick:(UIButton *)sender;


@end

@implementation SixController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLight];
}

- (void)setLight{
    
    
    // 光亮与阴影
    
    // 为了计算不同阴影图层的不透明度，需要得到每个面的正太向量（垂直于表面的向量）然后根据一个想象的光源计算出两个向量的叉乘结果，叉乘代表了光源和图层之间的角度，从而决定了它有多大程度的光亮。
    
    // 需要 GLKit框架来做向量的计算，每个面的 CATransform3D都被转换为 GLKMatrix4, 然后通过 GLMatrix4GetMatrix3 函数得出一个 3*3的旋转矩阵，这个旋转矩阵指定了向量的方向，然后可以通过它来得到正太向量的值。
    
    
    //set up the container sublayer transform
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0 / 500.0;
    perspective = CATransform3DRotate(perspective, -M_PI_4, 1, 0, 0);
    perspective = CATransform3DRotate(perspective, -M_PI_4, 0, 1, 0);
    self.containerView.layer.sublayerTransform = perspective;
    //add cube face 1
    CATransform3D transform = CATransform3DMakeTranslation(0, 0, 100);
    [self addFace:0 withTransform:transform];
    //add cube face 2
    transform = CATransform3DMakeTranslation(100, 0, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
    [self addFace:1 withTransform:transform];
    //add cube face 3
    transform = CATransform3DMakeTranslation(0, -100, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 1, 0, 0);
    [self addFace:2 withTransform:transform];
    //add cube face 4
    transform = CATransform3DMakeTranslation(0, 100, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 1, 0, 0);
    [self addFace:3 withTransform:transform];
    //add cube face 5
    transform = CATransform3DMakeTranslation(-100, 0, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 0, 1, 0);
    [self addFace:4 withTransform:transform];
    //add cube face 6
    transform = CATransform3DMakeTranslation(0, 0, -100);
    transform = CATransform3DRotate(transform, M_PI, 0, 1, 0);
    [self addFace:5 withTransform:transform];
    
}

- (void)addFace:(NSInteger)index withTransform:(CATransform3D)transform
{
    //get the face view and add it to the container
    UIView *face = self.faces[index];
    
    if (index > 2) {
        // 这里如果不加上，会导致 后面的 3，4，5界面的遮挡了前面的 1,2,3的事件传递
        face.userInteractionEnabled = NO;
    }
    
    [self.containerView addSubview:face];
    //center the face view within the container
    CGSize containerSize = self.containerView.bounds.size;
    face.center = CGPointMake(containerSize.width / 2.0, containerSize.height / 2.0);
    // apply the transform
    face.layer.transform = transform;
    
    
    //apply lighting
    [self applyLightingToFace:face.layer];
}



- (void)applyLightingToFace:(CALayer *)face{
    
    //add lighting layer
    CALayer *layer = [CALayer layer];
    layer.frame = face.bounds;
    [face addSublayer:layer];
    
    //convert the face transform to matrix
    //(GLKMatrix4 has the same structure as CATransform3D)
    //译者注：GLKMatrix4和CATransform3D内存结构一致，但坐标类型有长度区别，所以理论上应该做一次float到CGFloat的转换，感谢[@zihuyishi](https://github.com/zihuyishi)同学~
    
    CATransform3D transform = face.transform;
    GLKMatrix4 matrix4 = *(GLKMatrix4 *)&transform;
    
//    GLKMatrix4 matrix4 = *((GLKMatrix4 *)&transform);
//    GLKMatrix4 t2 = *((GLKMatrix4 *)&t);
    
    GLKMatrix3 matrix3 = GLKMatrix4GetMatrix3(matrix4);
    //get face normal
    GLKVector3 normal = GLKVector3Make(0, 0, 1);
    normal = GLKMatrix3MultiplyVector3(matrix3, normal);
    normal = GLKVector3Normalize(normal);
    //get dot product with light direction
    GLKVector3 light = GLKVector3Normalize(GLKVector3Make(LIGHT_DIRECTION));
    float dotProduct = GLKVector3DotProduct(light, normal);
    //set lighting layer opacity
    CGFloat shadow = 1 + dotProduct - AMBIENT_LIGHT;
    UIColor *color = [UIColor colorWithWhite:0 alpha:shadow];
    layer.backgroundColor = color.CGColor;
}
- (IBAction)btnClick:(UIButton *)sender {
    NSLog(@"sender.tag:%@", @(sender.tag));
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
