//
//  main.m
//  CATiledLayerDemo
//
//  Created by DFD on 2017/2/12.
//  Copyright © 2017年 DFD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

/*
 
 菜单 Product -> Edit Scheme
 
 左边找到run xxx点击后在右边选择Arguments面板中就可以设置XCode在运行命令行app时模拟输参数
 
 设置完成后再次run就会自动填入设置好的参数了
 
 这是输入地址
 /Users/dingfude/Documents/2560-1600/1.jpg
 
 
 
 */



int main(int argc, const char * argv[]) {
    @autoreleasepool {
        if (argc < 2) {
            NSLog(@"");
            return 0;
        }
        
        NSString *inputPath = [NSString stringWithCString:argv[1] encoding:NSUTF8StringEncoding];
        
        CGFloat tileSize = 256;
        
        NSString *outputPath = [inputPath stringByDeletingPathExtension];
        
        NSImage *image = [[NSImage alloc] initWithContentsOfFile:inputPath];
        
        NSSize size = [image size];
        
        NSArray *representations = [image representations];
        
        if ([representations count]) {
            
            NSBitmapImageRep *representation = representations[0];
            size.width = [representation pixelsWide];
            size.height = [representation pixelsHigh];
        }
        
        NSRect rect = NSMakeRect(0, 0, size.width, size.height);
        
        CGImageRef imageRef = [image CGImageForProposedRect:&rect context:NULL hints:nil];
        
        NSInteger rows = ceil(size.height / tileSize);
        NSInteger cols = ceil(size.width /  tileSize);
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *outPathFile = [outputPath stringByAppendingFormat: @"/"];
        
        BOOL isExist = [fileManager fileExistsAtPath:outPathFile];
        if (!isExist) {
            BOOL isCreated =  [fileManager createDirectoryAtPath:outPathFile withIntermediateDirectories:NO attributes:nil error:NULL];
            if (isCreated) {
                NSLog(@"创建成功");
            }
        }
        
        for (int y = 0; y < rows; ++y) {
            for (int x = 0; x < cols; ++x) {
                //extract tile image
                CGRect tileRect = CGRectMake(x*tileSize, y*tileSize, tileSize, tileSize);
                CGImageRef tileImage = CGImageCreateWithImageInRect(imageRef, tileRect);
                
                //convert to jpeg data
                NSBitmapImageRep *imageRep = [[NSBitmapImageRep alloc] initWithCGImage:tileImage];
                NSData *data = [imageRep representationUsingType: NSJPEGFileType properties:@{}];
                CGImageRelease(tileImage);
                
                //save file
                NSString *path = [outPathFile stringByAppendingFormat: @"Snowman_%02i_%02i.jpg", x, y];
                
                
                BOOL result = [data writeToFile:path atomically:YES];
                if (result) {
                    NSLog(@"保存成功一张");
                }else{
                    NSLog(@"保存失败");
                }
            }
        }
        
        return 0;
    }
    

}
