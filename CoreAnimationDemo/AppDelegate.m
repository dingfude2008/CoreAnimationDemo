//
//  AppDelegate.m
//  CoreAnimationDemo
//
//  Created by DFD on 2017/2/6.
//  Copyright © 2017年 DFD. All rights reserved.
//

#import "AppDelegate.h"
#import "NSDate+Addition.h"
#import "NSString+CZPath.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    NSString *string = @"2017-02-10 00:39:10";
    NSString *format = @"YYYY-MM-dd HH:mm:ss";
    NSDate * _registerDateType = [NSDate dateWithString:string format:format];
    _registerDateType = [NSDate dateWithTimeInterval:13 * 60 * 60 sinceDate:_registerDateType];
    
    //NSLog(@"%@", _registerDateType);
    
    NSLog(@"%@", [@"" cz_appendDocumentDir]);
    
    
    return YES;
}


/*
    加载图片的两种方式的内存使用对比 Resourse（ +imageWithContentsOfFile:）与 imageAssets( +imageNamed:)
 
    1, Resourse ( +imageWithContentsOfFile:)
        优点：使用时载入内存，不用的时候自动销毁，内存管理及时。
        适用：不经常使用到的大图，如果开机引导页
     // 1, Resourse
     /*
     
     NSString *path = [[NSBundle mainBundle] pathForResource:@"image@2x" ofType:@"pgn"];
     UIImage *image = [UIImage imageWithContentsOfFile:path];
     
     内部实现逻辑；
     
     + (instancetype)imageWithContentOfFile:(NSString *)fileName{
     
     NSUInger scale = 0;
     
     //...
     
     scale = 2; // 使用屏幕的缩放比例，在 plus 上使用 3
     
     return [[self alloc] initWithData:[NSData dataWithContentOfFile:fileName scale:scale];
     }
     
     // 这种加载图片的方式局限性是，图片必须在.ipa的根目录或者沙盒中。
     // 2, imageAssets
     
     /*
     使用的是图片缓存，保存在一个图片缓存字典中，key:图片名，value:UIImage.一旦加载过一次，就永不销毁，
     
     内部代码实现类似
     + (NSMutableDictionary *)imageBuff{
        static NSMutableDictionary *_imageBuff;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _imageBuff = [[NSMutableDictionary alloc] init];
        });
        return _imageBuff;
     }
     
     + (instancetype)imageName:(NSString *)imageName{
        if (!imageName) {
            return nil;
        }
        UIImage *image = self.imageBuff[imageName];
        if (image) {
            return image;
        }
        NSString *path = @"这个是图片的路径";// 这里省略逻辑
        if (image) {
            self.imageBuff[imageName] = image;
        }
        return  image;
     }

        使用 icon类的图片， 大小一般在 3-20KB之间
        优点：当 icon在多个地方显示的时候，只会创建一次，公用一个UIImage对象，减少对沙盒的读写操作。
        缺点：图片缓存和APP生命周期同步
 
     */

- (void)setImage{

    
    
    
    
    
    
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
