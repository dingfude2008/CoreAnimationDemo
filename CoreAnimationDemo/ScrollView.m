//
//  ScrollView.m
//  CoreAnimationDemo
//
//  Created by DFD on 2017/2/11.
//  Copyright © 2017年 DFD. All rights reserved.
//

#import "ScrollView.h"
#import <QuartzCore/QuartzCore.h>

@implementation ScrollView


+ (Class)layerClass{
    return [CAScrollLayer class];
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
    // 修改默认的剪切
    self.layer.masksToBounds = YES;
    
    UIPanGestureRecognizer * recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    
    [self addGestureRecognizer:recognizer];
}

- (void)pan:(UIPanGestureRecognizer *)recognizer{
    
    CGPoint offest = self.bounds.origin;
    
    offest.x -= [recognizer locationInView:self].x;
    offest.y -= [recognizer locationInView:self].y;
    
    [(CAScrollLayer *)self.layer scrollPoint:offest];
    
    [recognizer setTranslation:CGPointZero inView:self];
    
    
    
    
}

@end
