#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface ImageHelper : NSObject {
	
}

+ (unsigned char *) convertUIImageToBitmapRGBA8:(UIImage *)image;

+ (CGContextRef) newBitmapRGBA8ContextFromImage:(CGImageRef)image;

+ (UIImage *) convertBitmapRGBA8ToUIImage:(unsigned char *)buffer 
								withWidth:(int)width
							   withHeight:(int)height;

+(UIImage*)getGrayImage:(UIImage*)sourceImage;
@end

