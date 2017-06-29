//
//  ColorfulFilter.m
//  DifferentFilters
//
//  Created by hurry.qin on 2017/2/22.
//  Copyright © 2017年 hurry.qin. All rights reserved.
//

#import "ColorfulFilter.h"

@implementation ColorfulFilter
/*  
 newR = (G - B) * (G - B) / 128
 newG = (R - B) * (R - B) / 128
 newB = (R - G) * (R - G) / 128
 */

+ (UIImage*)blueColorFilter:(UIImage*)inputImage{
    unsigned char *imageBytes = [ImageHelper convertUIImageToBitmapRGBA8:inputImage];
    unsigned char *outImageBytes = [ImageHelper convertUIImageToBitmapRGBA8:inputImage];
    int width = inputImage.size.width;
    int height = inputImage.size.height;
    
    for (int i = 0; i<width; i++) {
        for (int j = 0; j<height; j++) {
            float r = imageBytes[(j*width + i)*4 ];
            float g = imageBytes[(j*width + i)*4 + 1];
            float b = imageBytes[(j*width + i)*4 + 2];
            outImageBytes[(j*width + i)*4 ]  = (unsigned char) ((g - b)*(g-b)/128);
            outImageBytes[(j*width + i)*4 + 1]  = (unsigned char)((r-b)*(r-b)/128);
            outImageBytes[(j*width + i)*4 + 2]  = (unsigned char)((r-g)*(r-g)/128);
        }
    }
    return  [ImageHelper convertBitmapRGBA8ToUIImage:outImageBytes withWidth:width withHeight:height];
}

/*
 R = |r - g - b| * 3 / 2
 G = |g - b - r| * 3 / 2
 B = |b - r - g| * 3 / 2
 */
+ (UIImage*)frozenFilter:(UIImage*)inputImage{
    unsigned char *imageBytes = [ImageHelper convertUIImageToBitmapRGBA8:inputImage];
    unsigned char *outImageBytes = [ImageHelper convertUIImageToBitmapRGBA8:inputImage];
    int width = inputImage.size.width;
    int height = inputImage.size.height;
    
    for (int i = 0; i<width; i++) {
        for (int j = 0; j<height; j++) {
            float r = imageBytes[(j*width + i)*4 ];
            float g = imageBytes[(j*width + i)*4 + 1];
            float b = imageBytes[(j*width + i)*4 + 2];
            
            outImageBytes[(j*width + i)*4 ]  = (unsigned char) (fabs(r-g-b)*3/2.0);
            outImageBytes[(j*width + i)*4 + 1]  = (unsigned char)(fabs(g-b-r)*3/2.0);
            outImageBytes[(j*width + i)*4 + 2]  = (unsigned char)(fabs(b-r-g)*3/2.0);
        }
    }
    return  [ImageHelper convertBitmapRGBA8ToUIImage:outImageBytes withWidth:width withHeight:height];
}

/*
 newR = R * 128 / (G + B + 1)
 newG = G * 128 / (G + B + 1)
 newB = B * 128 / (G + B + 1)
 */

+ (UIImage*)redFilter:(UIImage*)inputImage{
    unsigned char *imageBytes = [ImageHelper convertUIImageToBitmapRGBA8:inputImage];
    unsigned char *outImageBytes = [ImageHelper convertUIImageToBitmapRGBA8:inputImage];
    int width = inputImage.size.width;
    int height = inputImage.size.height;
    
    for (int i = 0; i<width; i++) {
        for (int j = 0; j<height; j++) {
            float r = imageBytes[(j*width + i)*4 ];
            float g = imageBytes[(j*width + i)*4 + 1];
            float b = imageBytes[(j*width + i)*4 + 2];
            outImageBytes[(j*width + i)*4 ]  = (unsigned char) ((r*128)/(g+b+1));
            outImageBytes[(j*width + i)*4 + 1]  = (unsigned char)((g*128)/(g+b+1));
            outImageBytes[(j*width + i)*4 + 2]  = (unsigned char)((b*128)/(g+b+1));
        }
    }
    return  [ImageHelper convertBitmapRGBA8ToUIImage:outImageBytes withWidth:width withHeight:height];
}

/*
 newR = (R * R / 255)
 newG = (G * G / 255)
 newB = (B * B / 255)
*/
+ (UIImage*)fadeFilter:(UIImage*)inputImage{
    unsigned char *imageBytes = [ImageHelper convertUIImageToBitmapRGBA8:inputImage];
    unsigned char *outImageBytes = [ImageHelper convertUIImageToBitmapRGBA8:inputImage];
    int width = inputImage.size.width;
    int height = inputImage.size.height;
    
    for (int i = 0; i<width; i++) {
        for (int j = 0; j<height; j++) {
            float r = imageBytes[(j*width + i)*4 ];
            float g = imageBytes[(j*width + i)*4 + 1];
            float b = imageBytes[(j*width + i)*4 + 2];
            outImageBytes[(j*width + i)*4 ]  = (unsigned char) (r*r/255);
            outImageBytes[(j*width + i)*4 + 1]  = (unsigned char)(g*g/255);
            outImageBytes[(j*width + i)*4 + 2]  = (unsigned char)(b*b/255);
        }
    }
    return  [ImageHelper convertBitmapRGBA8ToUIImage:outImageBytes withWidth:width withHeight:height];
}

/*
 R= (G * B / 255)
 G = (B * R / 255)
 B = (R * G / 255)
 */
+ (UIImage*)swapFilter:(UIImage*)inputImage{
    unsigned char *imageBytes = [ImageHelper convertUIImageToBitmapRGBA8:inputImage];
    unsigned char *outImageBytes = [ImageHelper convertUIImageToBitmapRGBA8:inputImage];
    int width = inputImage.size.width;
    int height = inputImage.size.height;
    
    for (int i = 0; i<width; i++) {
        for (int j = 0; j<height; j++) {
            float r = imageBytes[(j*width + i)*4 ];
            float g = imageBytes[(j*width + i)*4 + 1];
            float b = imageBytes[(j*width + i)*4 + 2];
            outImageBytes[(j*width + i)*4 ]  = (unsigned char) (g*b/255);
            outImageBytes[(j*width + i)*4 + 1]  = (unsigned char)(b*r/255);
            outImageBytes[(j*width + i)*4 + 2]  = (unsigned char)(r*g/255);
        }
    }
    return  [ImageHelper convertBitmapRGBA8ToUIImage:outImageBytes withWidth:width withHeight:height];
}

/*
 R = Sin(atan2(G, B)) * 255
 G = Sin(atan2(B, R)) * 255
 B = Sin(atan2(R, G)) * 255
 */
+ (UIImage*)devilFilter:(UIImage*)inputImage{
    unsigned char *imageBytes = [ImageHelper convertUIImageToBitmapRGBA8:inputImage];
    unsigned char *outImageBytes = [ImageHelper convertUIImageToBitmapRGBA8:inputImage];
    int width = inputImage.size.width;
    int height = inputImage.size.height;
    
    for (int i = 0; i<width; i++) {
        for (int j = 0; j<height; j++) {
            float r = imageBytes[(j*width + i)*4 ];
            float g = imageBytes[(j*width + i)*4 + 1];
            float b = imageBytes[(j*width + i)*4 + 2];
            outImageBytes[(j*width + i)*4 ]  = (unsigned char) (sin(atan2(g, b))*255);
            outImageBytes[(j*width + i)*4 + 1]  = (unsigned char)(sin(atan2(b, r))*255);
            outImageBytes[(j*width + i)*4 + 2]  = (unsigned char)(sin(atan2(r, g))*255);
        }
    }
    return  [ImageHelper convertBitmapRGBA8ToUIImage:outImageBytes withWidth:width withHeight:height];
}

+ (UIImage*)FilmFilter:(UIImage*)inputImage{
    unsigned char *imageBytes = [ImageHelper convertUIImageToBitmapRGBA8:inputImage];
    unsigned char *outImageBytes = [ImageHelper convertUIImageToBitmapRGBA8:inputImage];
    int width = inputImage.size.width;
    int height = inputImage.size.height;
    
    for (int i = 0; i<width; i++) {
        for (int j = 0; j<height; j++) {
            float r = imageBytes[(j*width + i)*4];
            float g = imageBytes[(j*width + i)*4 + 1];
            float b = imageBytes[(j*width + i)*4 + 2];
            outImageBytes[(j*width + i)*4 ]  = 255-r;
            outImageBytes[(j*width + i)*4 + 1]  = 255-g;
            outImageBytes[(j*width + i)*4 + 2]  = 255-b;
        }
    }
    return  [ImageHelper convertBitmapRGBA8ToUIImage:outImageBytes withWidth:width withHeight:height];
}

/*
 R = 0.393 * r + 0.769 * g + 0.189 * b
 G = 0.349 * r + 0.686 * g + 0.168 * b
 B = 0.272 * r + 0.534 * g + 0.131 * b
 */

+ (UIImage*)OldColorFilter:(UIImage*)inputImage{
    unsigned char *imageBytes = [ImageHelper convertUIImageToBitmapRGBA8:inputImage];
    unsigned char *outImageBytes = [ImageHelper convertUIImageToBitmapRGBA8:inputImage];
    int width = inputImage.size.width;
    int height = inputImage.size.height;
    
    for (int i = 0; i<width; i++) {
        for (int j = 0; j<height; j++) {
            float r = imageBytes[(j*width + i)*4];
            float g = imageBytes[(j*width + i)*4 + 1];
            float b = imageBytes[(j*width + i)*4 + 2];
            outImageBytes[(j*width + i)*4 ]  = (unsigned char) (0.393*r + 0.769*g + 0.189*b);
            outImageBytes[(j*width + i)*4 + 1]  = (unsigned char)(0.349 * r + 0.686*g + 0.168*b);
            outImageBytes[(j*width + i)*4 + 2]  = (unsigned char)(0.272 * r + 0.534*g + 0.131*b);
        }
    }
    return  [ImageHelper convertBitmapRGBA8ToUIImage:outImageBytes withWidth:width withHeight:height];
}


@end
