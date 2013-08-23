//
//  UIColor+Palette.m
//  BRLN
//
//  Created by Weronika Zawila-Bromirska on 8/23/13.
//  Copyright (c) 2013 home. All rights reserved.
//

#import "UIColor+Palette.h"

@implementation UIColor (Palette)

+ (UIColor *)_primaryColor
{
    return [UIColor colorWithRed:249.0/255.0 green:107.0/255.0 blue:107.0/255.0 alpha:1.0];
}

+ (UIColor *)_whiteColor
{
    return [UIColor colorWithRed:247.0/255.0 green:249.0/255.0 blue:250.0/255.0 alpha:1.0];
}

+ (UIColor *)_grayLightColor
{
    return [UIColor colorWithRed:209.0/255.0 green:214.0/255.0 blue:221.0/255.0 alpha:1.0];
}

+ (UIColor *)_grayColor
{
    return [UIColor colorWithRed:89.0/255.0 green:95.0/255.0 blue:106.0/255.0 alpha:1.0];
}

+ (UIColor *)_grayDarkColor
{
    return [UIColor colorWithRed:37.0/255.0 green:42.0/255.0 blue:51.0/255.0 alpha:1.0];
}

+ (UIColor *)_blackColor
{
    return [UIColor colorWithRed:19.0/255.0 green:21.0/255.0 blue:26.0/255.0 alpha:1.0];
}

@end
