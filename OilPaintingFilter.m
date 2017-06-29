//
//  OilPaintingFilter.m
//  DifferentFilters
//
//  Created by hurry.qin on 2017/2/20.
//  Copyright © 2017年 hurry.qin. All rights reserved.
//

#import "OilPaintingFilter.h"
#import "ImageHelper.h"
#import <math.h>

#define PointWidth 15
#define PointHeight 15
#define Radius 4

@implementation OilPaintingFilter
+ (UIImage*)MosaicFilter:(UIImage*)inputImage{
    unsigned char *imageBytes = [ImageHelper convertUIImageToBitmapRGBA8:inputImage];
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
    for (int i = 0; i<width; i+=PointWidth) {
        for (int j = 0; j<height; j+=PointHeight) {
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
            for (int w = 0; w<PointWidth; w++) {  //统计区域rgb直方图
                for (int h = 0; h<PointHeight; h++) {
                    if (j+h <height && i+w <width) {
                        long des = ((j+h)*width + i + w)*4;
                        imageBytes[des] = rAv;
                        imageBytes[des+1]= gAV;
                        imageBytes[des+2]= bAv;
                    }
                }
            }
        }
    }
    return [ImageHelper convertBitmapRGBA8ToUIImage:imageBytes withWidth:width withHeight:height];
}



+ (UIImage*)oilPaintingFilter:(UIImage*)inputImage{
    unsigned char *imageBytes = [ImageHelper convertUIImageToBitmapRGBA8:inputImage];
    unsigned char *outImageBytes = [ImageHelper convertUIImageToBitmapRGBA8:inputImage];
    int width = inputImage.size.width;
    int height = inputImage.size.height;
    OilPaintingRGB(imageBytes,outImageBytes,width,height,30,5,15);
//    long redSum = 0;
//    long greenSum = 0;
//    long blueSum = 0;
//    int pointCount = 0;
//    int rAv=0;
//    int gAV=0;
//    int bAv=0;
//    for (int i = 0; i<width; i+=1) {
//        for (int j = 0; j<height; j+=1) {
//            redSum = 0; rAv=0;
//            greenSum = 0;gAV=0;
//            blueSum = 0;bAv= 0;
//            pointCount = 0;
//            //统计区域rgb直方图
//            for (int w = i-Radius;w < i+Radius; i++) {
//                for (int h = j-Radius; h<j+Radius; j++) {
//                    if (w>=0 && w<width && h>=0 && h<height && sqrt((w-i)*(w-i) + (h-j)*(h-j))<=Radius ){
//                        long des = (h*width + w)*4;
//                        redSum += imageBytes[des];
//                        greenSum += imageBytes[des+1];
//                        blueSum += imageBytes[des+2];
//                        pointCount +=1;
//                    }
//                }
//            }
//            //求均值
//            if (pointCount != 0) {
//                rAv = redSum/pointCount;
//                gAV = greenSum/pointCount;
//                bAv = blueSum/pointCount;
//            }
//            //赋值
//            if (j<height&&i<width) {
//                long des = (j*width + i)*4;
//                outImageBytes[des] = rAv;
//                outImageBytes[des+1]= gAV;
//                outImageBytes[des+2]= bAv;
//            }
//        }
//    }
    
    return [ImageHelper convertBitmapRGBA8ToUIImage:outImageBytes withWidth:width withHeight:height];
}

void OilPaintingRGB(unsigned char* pInput,unsigned char* pOutput,int width,int height,int nStride,int radius,int smooth)
{
    int intensity, maxIntensity;
    unsigned char* src = pInput;
    unsigned char* dst = pOutput;
    unsigned char* p;
    int i,j,x,y,t;
    int offset = nStride-width*3;
    double scale = smooth/255.0;
    int _smooth = smooth + 1;
    
    int* red = (int*)malloc(sizeof(int)*_smooth);
    int* green = (int*)malloc(sizeof(int)*_smooth);
    int* blue = (int*)malloc(sizeof(int)*_smooth);
    int* intensities = (int*)malloc(sizeof(int)*_smooth);
    
    if(pInput == NULL || pOutput == NULL)
        return;
    
    if(width <= 0 || height <= 0)
        return;
    
    if(radius<1)
        radius = 1;
    
    // for each line
    for ( y = 0; y < height; y++ )
    {
        // for each pixel
        for ( x = 0; x < width; x++, src += 4, dst += 4 )
        {
            memset(red,0,sizeof(int)*_smooth);
            memset(green,0,sizeof(int)*_smooth);
            memset(blue,0,sizeof(int)*_smooth);
            memset(intensities,0,sizeof(int)*_smooth);
            
            // for each kernel row
            for ( i = -radius; i <= radius; i++ )
            {
                t = y + i;
                // skip row
                if ( t < 0 )
                    continue;
                // break
                if ( t >= height )
                    break;
                
                // for each kernel column
                for ( j = -radius; j <= radius; j++ )
                {
                    t = x + j;
                    // skip column
                    if ( t < 0 )
                        continue;
                    
                    if ( t < width )
                    {
                        p = &src[i * nStride + j * 3];
                        intensity = (int)( 0.2125 * (*p) + 0.7154 * (*(p+1))) + 0.0721 * (*(p+2));
                        
                        intensity = intensity * scale;
                        
                        intensities[intensity] ++;
                        // red
                        red[intensity]      += *p;
                        // green
                        green[intensity]    += *(p+1);
                        // blue
                        blue[intensity]     += *(p+2);
                        //a
                    }
                }
            }
            
            // get most frequent intesity
            maxIntensity = 0;
            j = 0;
            
            for ( i = 0; i < _smooth; i++ )
            {
                if ( intensities[i] > j )
                {
                    maxIntensity = i;
                    j = intensities[i];
                }
            }
            
            // set destination pixel
            *dst = (unsigned char)( red[maxIntensity] / intensities[maxIntensity] );
            *(dst+1) = (unsigned char)( green[maxIntensity] / intensities[maxIntensity] );
            *(dst+2) = (unsigned char)( blue[maxIntensity] / intensities[maxIntensity] );
        }
        src += offset;
        dst += offset;  
    }  
    
    free(red);  
    free(green);  
    free(blue);  
    free(intensities);  
}

@end
