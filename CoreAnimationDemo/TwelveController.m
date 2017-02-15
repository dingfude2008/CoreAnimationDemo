//
//  TwelveController.m
//  CoreAnimationDemo
//
//  Created by DFD on 2017/2/15.
//  Copyright © 2017年 DFD. All rights reserved.
//

#import "TwelveController.h"
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>
#import "NSString+CZPath.h"

@interface TwelveController ()
@property (weak, nonatomic) IBOutlet UIView *containView;

@end

@implementation TwelveController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    /*
     AVPlayerLayer  是 AVFoundation 框架中提供的， 它和 Core Animation 紧密集合在一起
     
     是播放是视频的。是从高级接口 MPMoivePlayer 的底层实现的
     
     */
    
    
//    NSString *urlString = [[NSBundle mainBundle] URLForResource:@"778" withExtension:@"mp4"];
    
    //NSURL *URL = [[NSBundle mainBundle] URLForResource:@"778" withExtension:@"mp4"];
    
    
    
    // 加载工程目录中的
//    NSString *absPath = [[NSBundle mainBundle] pathForResource:@"778"
//                                                        ofType:@"mp4"];
//    
//    NSURL *URL = [NSURL fileURLWithPath:absPath];
    
    // 记载document中的
    NSString *absPath = [@"779.mp4" cz_appendDocumentDir];
    
    NSURL *URL = [NSURL fileURLWithPath:absPath];
    
    AVPlayer *player = [AVPlayer playerWithURL:URL];
    
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    
    playerLayer.frame = self.containView.bounds;
    
    [self.containView.layer addSublayer:playerLayer];
    
    
    CATransform3D tranform = CATransform3DIdentity;
    
    tranform.m34 = -1 / 500.0;
    
    tranform = CATransform3DRotate(tranform, M_PI_4, 1, 1, 0);
    
    playerLayer.transform = tranform;
    
    playerLayer.masksToBounds = YES;
    
    playerLayer.cornerRadius = 20.0;
    
    playerLayer.borderColor = [UIColor redColor].CGColor;
    
    playerLayer.borderWidth = 2;
    
    [player play];
    
    // 这样添加到一个视图的layer层，可以使用这个视图的自动旋转适配，因为 Core Animation 并不支持自动大小和自动布局
    
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


