//
//  UIColor+Palette.h
//  BRLN
//
//  Created by Weronika Zawila-Bromirska on 8/23/13.
//  Copyright (c) 2013 home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Palette)

+ (UIColor *)_primaryColor;
+ (UIColor *)_whiteColor;
+ (UIColor *)_grayLightColor;
+ (UIColor *)_grayColor;
+ (UIColor *)_grayDarkColor;
+ (UIColor *)_blackColor;

- (UIColor *)darkenColor:(CGFloat)value;

@end
