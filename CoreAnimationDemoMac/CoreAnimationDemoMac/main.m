//
//  main.m
//  CoreAnimationDemoMac
//
//  Created by DFD on 2017/2/11.
//  Copyright © 2017年 DFD. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AppKit/AppKit.h>

int main(int argc, const char * argv[]) {
    //return NSApplicationMain(argc, argv);
    
    @autoreleasepool {
        if (argc < 2) {
            NSLog(@"");
            return 0;
        }
        
        NSString *inputPath = [NSString stringWithCString:argv[1] encoding:NSUTF8StringEncoding];
        
        CGFloat tileSize = 256;
        
        NSString *outputPath = [inputPath stringByDeletingPathExtension];
        
        NSImage *image = [[NSImage alloc] initWithContentsOfFile:outputPath];
        
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
        
        for (int y = 0; y < rows; ++y) {
            for (int x = 0; x < cols; ++x) {
                //extract tile image
                CGRect tileRect = CGRectMake(x*tileSize, y*tileSize, tileSize, tileSize);
                CGImageRef tileImage = CGImageCreateWithImageInRect(imageRef, tileRect);
                
                //convert to jpeg data
                NSBitmapImageRep *imageRep = [[NSBitmapImageRep alloc] initWithCGImage:tileImage];
                NSData *data = [imageRep representationUsingType: NSJPEGFileType properties:nil];
                CGImageRelease(tileImage);
                
                //save file
                NSString *path = [outputPath stringByAppendingFormat: @"_%02i_%02i.jpg", x, y];
                [data writeToFile:path atomically:NO];
            }
        }
        
        return 0;
    }
    
    
    
}
