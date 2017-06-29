//
//  EmbossFilter.m
//  DifferentFilters
//
//  Created by hurry.qin on 2017/2/20.
//  Copyright © 2017年 hurry.qin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmbossFilter.h"
#import "ImageHelper.h"

@implementation EmbossFilter
+ (UIImage*)embossFiter:(UIImage*)inputImage{
    unsigned char *imageBytes = [ImageHelper convertUIImageToBitmapRGBA8:inputImage];
    int width = inputImage.size.width;
    int height = inputImage.size.height;
    
    //浮雕效果1
    for (int i = 0; i<width; i++) {
        for (int j = 0; j<height; j++) {
            if (i + 1 < width) {
                imageBytes[(j*width + i)*4 ]  = imageBytes[(j*width + i)*4 ] - imageBytes[(j*width + i)*4 + 4] + 128;
                imageBytes[(j*width + i)*4 + 1]  = imageBytes[(j*width + i)*4 + 1] - imageBytes[(j*width + i)*4 + 5] + 128;
                imageBytes[(j*width + i)*4 + 2]  = imageBytes[(j*width + i)*4 + 2] - imageBytes[(j*width + i)*4 + 6] + 128;
            }
        }
    }
    
    //浮雕效果 2
    //    for (int i = width-1; i>0; i--) {
    //        for (int j = height -1; j>0; j--) {
    //            if (i - 1 >=0 && j -1 >=0) {
    //                imageBytes[(j*width + i)*4 ]  = imageBytes[(j*width + i)*4 ] - imageBytes[((j-1)*width + i-1)*4 ] + 128;
    //                imageBytes[(j*width + i)*4 + 1]  = imageBytes[(j*width + i)*4 + 1] - imageBytes[((j-1)*width + i-1)*4 + 1] + 128;
    //                imageBytes[(j*width + i)*4 + 2]  = imageBytes[(j*width + i)*4 + 2] - imageBytes[((j-1)*width + i-1)*4 + 2] + 128;
    //            }
    //        }
    //    }
    //
    
    UIImage * new = [ImageHelper convertBitmapRGBA8ToUIImage:imageBytes withWidth:width withHeight:height];
    return  [ImageHelper getGrayImage:new];
}
@end
