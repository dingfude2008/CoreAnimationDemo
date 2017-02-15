//
//  CATranformLayerController.m
//  CoreAnimationDemo
//
//  Created by DFD on 2017/2/10.
//  Copyright © 2017年 DFD. All rights reserved.
//

#import "CATransformLayerController.h"

@interface CATransformLayerController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation CATransformLayerController

- (CALayer *)faceWithTransform:(CATransform3D)transform
{
    //create cube face layer
    CALayer *face = [CALayer layer];
    face.frame = CGRectMake(-50, -50, 100, 100);
    
    //apply a random color
    CGFloat red = (rand() / (double)INT_MAX);
    CGFloat green = (rand() / (double)INT_MAX);
    CGFloat blue = (rand() / (double)INT_MAX);
    face.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    
    //apply the transform and return
    face.transform = transform;
    return face;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self transformLayer];
    
//    [self replicatorLayerA];
}

- (void)replicatorLayerA{
    /*
     
     CAReplicatorLayer 是为了高效生成许多相似的图层。它会绘制一个或多个图层的子图层，并在复制体上应用不同的变换
     
     
     */
    //create a replicator layer and add it to our view
    CAReplicatorLayer *replicator = [CAReplicatorLayer layer];
    replicator.frame = self.containerView.bounds;
    [self.containerView.layer addSublayer:replicator];
    
    //configure the replicator
    replicator.instanceCount = 10;
    
    //apply a transform for each instance
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 0, 200, 0);
    transform = CATransform3DRotate(transform, M_PI / 5.0, 0, 0, 1);
    transform = CATransform3DTranslate(transform, 0, -200, 0);
    replicator.instanceTransform = transform;
    
    //apply a color shift for each instance
    replicator.instanceBlueOffset = -0.1;
    replicator.instanceGreenOffset = -0.1;
    
    //create a sublayer and place it inside the replicator
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(100.0f, 100.0f, 100.0f, 100.0f);
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    [replicator addSublayer:layer];
}

- (void)gradientLayerA{
    
    
    /*
     CAGradientLayer 是用来生成两种或更多颜色的平缓渐变的，使用了硬件加速
     
     startPoint
     endPoint
     
     
     */
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.containerView.bounds;
    [self.containerView.layer addSublayer:gradientLayer];
    
    gradientLayer.colors = @[
                             (__bridge id)[UIColor redColor].CGColor,
                             (__bridge id)[UIColor blackColor].CGColor,
                             (__bridge id)[UIColor yellowColor].CGColor,
                             (__bridge id)[UIColor blueColor].CGColor
                             ];
    
    // 使用单位坐标
    
    gradientLayer.startPoint = CGPointMake(0, 0);
    //    gradientLayer.endPoint = CGPointMake(1, 1);
    gradientLayer.endPoint = CGPointMake(1, 0);
    
    // 多重渐变
    // 默认的是均衡分布
    
    // 位置数组必须和 colors 数量一致，不然会出现空白
    gradientLayer.locations = @[@0.0, @0.25, @0.5];
    
    
}


- (void)transformLayer{
    
    
    /*
     Core Animation 在 2D 画面中，是允许独立的移动一个区域的，以肘为支点，可以移动前臂和手，而不是移动肩膀，但是在 3D 情况下就不太可能了，因为所有的子图层都把它的子图层平面化到一个场景中了
     
     CATransformLayer 就是解决这个问题的
     
     CATransformLayer 不同于普通的 Layer ,因为它不能现实自己的内容，只有当存在一个能作用于子图层的变化它才算真的存在， CATransformLayer 并不平面化他的子图层，所以它能够构造一个层级的 3D结构
     
     
     */
    
    //set up the perspective transform
    CATransform3D pt = CATransform3DIdentity;
    pt.m34 = -1.0 / 500.0;
    self.containerView.layer.sublayerTransform = pt;
    
    //set up the transform for cube 1 and add it
    CATransform3D c1t = CATransform3DIdentity;
    c1t = CATransform3DTranslate(c1t, -100, 0, 0);
    CALayer *cube1 = [self cubeWithTransform:c1t];
    [self.containerView.layer addSublayer:cube1];
    
    //set up the transform for cube 2 and add it
    CATransform3D c2t = CATransform3DIdentity;
    c2t = CATransform3DTranslate(c2t, 100, 0, 0);
    c2t = CATransform3DRotate(c2t, -M_PI_4, 1, 0, 0);
    c2t = CATransform3DRotate(c2t, -M_PI_4, 0, 1, 0);
    CALayer *cube2 = [self cubeWithTransform:c2t];
    [self.containerView.layer addSublayer:cube2];

    
}

- (CALayer *)cubeWithTransform:(CATransform3D)transform
{
    //create cube layer
    CATransformLayer *cube = [CATransformLayer layer];
    
    //add cube face 1
    CATransform3D ct = CATransform3DMakeTranslation(0, 0, 50);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    //add cube face 2
    ct = CATransform3DMakeTranslation(50, 0, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    //add cube face 3
    ct = CATransform3DMakeTranslation(0, -50, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    //add cube face 4
    ct = CATransform3DMakeTranslation(0, 50, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    //add cube face 5
    ct = CATransform3DMakeTranslation(-50, 0, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    //add cube face 6
    ct = CATransform3DMakeTranslation(0, 0, -50);
    ct = CATransform3DRotate(ct, M_PI, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    //center the cube layer within the container
    CGSize containerSize = self.containerView.bounds.size;
    cube.position = CGPointMake(containerSize.width / 2.0, containerSize.height / 2.0);
     
    //apply the transform and return
    cube.transform = transform;
    return cube;
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
