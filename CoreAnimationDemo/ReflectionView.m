//
//  ReflectionView.m
//  CoreAnimationDemo
//
//  Created by DFD on 2017/2/11.
//  Copyright © 2017年 DFD. All rights reserved.
//

#import "ReflectionView.h"
#import <QuartzCore/QuartzCore.h>

@implementation ReflectionView

+ (Class)layerClass{
    return [CAReplicatorLayer class];
}

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return  self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setup];
}

- (void)setup{
    
    CAReplicatorLayer *replicatioLayer = (CAReplicatorLayer *)self.layer;
    replicatioLayer.instanceCount = 2;
    
    CATransform3D transform = CATransform3DIdentity;
    CGFloat veticalOffest = self.bounds.size.height + 2;
    transform = CATransform3DTranslate(transform, 0, veticalOffest, 0);
    
    
    transform = CATransform3DScale(transform, 1, -1, 0);
//    replicatioLayer.transform = transform;            // 设置本身的
    replicatioLayer.instanceTransform = transform;      // 设置复制的
    
    replicatioLayer.instanceAlphaOffset = -0.6;
    
}

@end
