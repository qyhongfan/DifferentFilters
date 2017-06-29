//
//  EdgeCheck.h
//  DifferentFilters
//
//  Created by hurry.qin on 2017/2/21.
//  Copyright © 2017年 hurry.qin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ImageHelper.h"
#import <math.h>
@interface EdgeCheck : NSObject
+ (UIImage*)ChaFenEdgeX:(UIImage*)inputImage;
+ (UIImage*)ChaFenEdgeY:(UIImage*)inputImage;
+ (UIImage*)Roberts:(UIImage*)inputImage;
@end
