//
//  ColorfulFilter.h
//  DifferentFilters
//
//  Created by hurry.qin on 2017/2/22.
//  Copyright © 2017年 hurry.qin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ImageHelper.h"
#import <math.h>
@interface ColorfulFilter : NSObject
+ (UIImage*)blueColorFilter:(UIImage*)inputImage;
+ (UIImage*)frozenFilter:(UIImage*)inputImage;
+ (UIImage*)redFilter:(UIImage*)inputImage;
+ (UIImage*)fadeFilter:(UIImage*)inputImage;
+ (UIImage*)swapFilter:(UIImage*)inputImage;
+ (UIImage*)devilFilter:(UIImage*)inputImage;
+ (UIImage*)OldColorFilter:(UIImage*)inputImage;
+ (UIImage*)FilmFilter:(UIImage*)inputImage;
@end
