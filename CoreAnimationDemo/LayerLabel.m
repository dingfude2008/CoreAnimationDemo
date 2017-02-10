//
//  LayerLabel.m
//  CoreAnimationDemo
//
//  Created by DFD on 2017/2/10.
//  Copyright © 2017年 DFD. All rights reserved.
//

#import "LayerLabel.h"

@implementation LayerLabel


+ (Class)layerClass{
    return [CATextLayer class];
}


- (CATextLayer *)textLayer{
    return (CATextLayer *)self.layer;
}


- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setup];
}


- (void)setText:(NSString *)text{
    super.text = text;
    [self textLayer].string = text;
}


- (void)setTextColor:(UIColor *)textColor{
    super.textColor = textColor;
    [self textLayer].foregroundColor = textColor.CGColor;
}

- (void)setFont:(UIFont *)font{
    super.font = font;
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    
    [self textLayer].font = fontRef;
    [self textLayer].fontSize = font.pointSize;
    
    CGFontRelease(fontRef);
    
    // 我们没有使用设置 contentScale 这是因为 CATextLayer 作为寄宿图时，会自动设置 contentScale 
    
}

- (void)setup{
    self.text = self.text;
    self.textColor = self.textColor;
    self.font = self.font;
    [self textLayer].alignmentMode = kCAAlignmentJustified;
    [self textLayer].wrapped = YES;
    [self.layer display];
}

@end
