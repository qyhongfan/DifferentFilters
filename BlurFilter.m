//
//  BlurFilter.m
//  DifferentFilters
//
//  Created by hurry.qin on 2017/2/20.
//  Copyright © 2017年 hurry.qin. All rights reserved.
//

#import "BlurFilter.h"
#define PointWidth 10
#define PointHeight 10
@implementation BlurFilter
+ (UIImage*)BlurFilter:(UIImage*)inputImage{
    unsigned char *imageBytes = [ImageHelper convertUIImageToBitmapRGBA8:inputImage];
    unsigned char *outImageBytes = [ImageHelper convertUIImageToBitmapRGBA8:inputImage];
    int width = inputImage.size.width;
    int height = inputImage.size.height;
    
    //马赛克
    long redSum = 0;
    long greenSum = 0;
    long blueSum = 0;
    int pointCount = 0;
    int rAv=0;
    int gAV=0;
    int bAv=0;
    for (int i = 0; i<width; i+=1) {
        for (int j = 0; j<height; j+=1) {
            redSum = 0; rAv=0;
            greenSum = 0;gAV=0;
            blueSum = 0;bAv= 0;
            pointCount = 0;
            for (int w = 0; w<PointWidth; w++) {  //统计区域rgb直方图
                for (int h = 0; h<PointHeight; h++) {
                    if (j+h <height && i+w <width) {
                        long des = ((j+h)*width + i + w)*4;
                        redSum += imageBytes[des];
                        greenSum += imageBytes[des+1];
                        blueSum += imageBytes[des+2];
                        pointCount +=1;
                    }
                }
            }
            //求均值
            if (pointCount != 0) {
                rAv = redSum/pointCount;
                gAV = greenSum/pointCount;
                bAv = blueSum/pointCount;
            }
            //赋值
            if (j<height&&i<width) {
                long des = (j*width + i)*4;
                outImageBytes[des] = rAv;
                outImageBytes[des+1]= gAV;
                outImageBytes[des+2]= bAv;
            }
        }
    }
    return [ImageHelper convertBitmapRGBA8ToUIImage:outImageBytes withWidth:width withHeight:height];
}
@end
