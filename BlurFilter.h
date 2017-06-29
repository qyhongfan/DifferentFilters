//
//  BlurFilter.h
//  DifferentFilters
//
//  Created by hurry.qin on 2017/2/20.
//  Copyright © 2017年 hurry.qin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ImageHelper.h"
#import <math.h>
@interface BlurFilter : NSObject
+ (UIImage*)BlurFilter:(UIImage*)inputImage;
@end
