//
//  OilPaintingFilter.h
//  DifferentFilters
//
//  Created by hurry.qin on 2017/2/20.
//  Copyright © 2017年 hurry.qin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OilPaintingFilter : NSObject
+ (UIImage*)MosaicFilter:(UIImage*)inputImage;
+ (UIImage*)oilPaintingFilter:(UIImage*)inputImage;
@end
