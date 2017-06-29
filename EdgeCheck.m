//
//  EdgeCheck.m
//  DifferentFilters
//
//  Created by hurry.qin on 2017/2/21.
//  Copyright © 2017年 hurry.qin. All rights reserved.
//

#import "EdgeCheck.h"

@implementation EdgeCheck
+ (UIImage*)ChaFenEdgeX:(UIImage*)inputImage{
    unsigned char *imageBytes = [ImageHelper convertUIImageToBitmapRGBA8:inputImage];
    int width = inputImage.size.width;
    int height = inputImage.size.height;
    for (int i = 0; i<width; i++) {
        for (int j = 0; j<height; j++) {
            if (i + 1 < width) {
                imageBytes[(j*width + i)*4 ]  = imageBytes[(j*width + i)*4 + 4] - imageBytes[(j*width + i)*4 ];
                imageBytes[(j*width + i)*4 + 1]  = imageBytes[(j*width + i)*4 + 5] - imageBytes[(j*width + i)*4 + 1];
                imageBytes[(j*width + i)*4 + 2]  = imageBytes[(j*width + i)*4 + 6] - imageBytes[(j*width + i)*4 + 2];
            }
        }
    }
    UIImage * new = [ImageHelper convertBitmapRGBA8ToUIImage:imageBytes withWidth:width withHeight:height];
    return  [ImageHelper getGrayImage:new];
}
+ (UIImage*)ChaFenEdgeY:(UIImage*)inputImage{
    unsigned char *imageBytes = [ImageHelper convertUIImageToBitmapRGBA8:inputImage];
    int width = inputImage.size.width;
    int height = inputImage.size.height;
    for (int j = 0; j<height; j++) {
        for (int i = 0; i<width; i++) {
            if (i+1< width && j+1<height ) {
                imageBytes[(j*width + i)*4 ]  = imageBytes[((j+1)*width + i)*4 ] - imageBytes[(j*width + i)*4 ];
                imageBytes[(j*width + i)*4 + 1]  = imageBytes[((j+1)*width + i)*4 + 1] - imageBytes[(j*width + i)*4 + 1];
                imageBytes[(j*width + i)*4 + 2]  = imageBytes[((j+1)*width + i)*4 + 2] - imageBytes[(j*width + i)*4 + 2];
            }
        }
    }
    UIImage * new = [ImageHelper convertBitmapRGBA8ToUIImage:imageBytes withWidth:width withHeight:height];
    return  [ImageHelper getGrayImage:new];
}
+ (UIImage*)Roberts:(UIImage*)inputImage{
    unsigned char *imageBytes = [ImageHelper convertUIImageToBitmapRGBA8:inputImage];
    unsigned char *outImageBytes = [ImageHelper convertUIImageToBitmapRGBA8:inputImage];
    int width = inputImage.size.width;
    int height = inputImage.size.height;
    for (int i = 0; i<width; i++) {
        for (int j = 0; j<height; j++) {
            if (i + 1 < width && j+1<height) {

                outImageBytes[(j*width+i)*4] = sqrt(pow((imageBytes[((j*width)+i)*4] - imageBytes[((j+1)*width + i+1)*4]),2) + pow((imageBytes[(j*width+i+1)*4] - imageBytes[((j+1)*width + i)*4]),2));
                
                outImageBytes[(j*width+i)*4+1]  = sqrt(pow((imageBytes[((j*width)+i)*4+1] - imageBytes[((j+1)*width + i+1)*4+1]),2) + pow((imageBytes[(j*width+i+1)*4+1] - imageBytes[((j+1)*width + i)*4+1]),2));
                
                outImageBytes[(j*width+i)*4+2]  = sqrt(pow((imageBytes[((j*width)+i)*4+2] - imageBytes[((j+1)*width + i+1)*4+2]),2) + pow((imageBytes[(j*width+i+1)*4+2] - imageBytes[((j+1)*width + i)*4+2]),2));
            }
        }
    }
    UIImage * new = [ImageHelper convertBitmapRGBA8ToUIImage:outImageBytes withWidth:width withHeight:height];
    return  [ImageHelper getGrayImage:new];
}
@end
