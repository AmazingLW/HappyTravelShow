//  ddlt
//
//  Created by yxlong on 15/7/27.
//  Copyright (c) 2015年 QQ:854072335. All rights reserved.
//

#import "XIColorHelper.h"

static UIColor *_gThemeColor = nil;
static UIColor *_gSeparatorLineColor = nil;
@implementation XIColorHelper

+ (void)initialize
{
    _gThemeColor = [UIColor opaqueColorWithRGBBytes:0x1fbca7];
    _gSeparatorLineColor = [UIColor opaqueColorWithRGBBytes:0xe5e5e5];
}

+ (UIColor *)SeparatorLineColor
{
    return _gSeparatorLineColor;
}

+ (UIColor *)ThemeColor
{
    return _gThemeColor;
}
@end

@implementation UIColor(OpaqueColorFromHex)

// Return an RGB color described by a hex constant.  Example: 0xF2F2F2.  Note the alpha channel is always 0xFF (1.0).
+ (UIColor*)opaqueColorWithRGBBytes:(NSUInteger)hexConstant
{
    CGFloat red = ((hexConstant >> 16) & 0xFF) / 255.0;
    CGFloat green = ((hexConstant >> 8) & 0xFF) / 255.0;
    CGFloat blue = (hexConstant & 0xFF) / 255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

@end
