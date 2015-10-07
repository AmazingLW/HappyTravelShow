//  ddlt
//
//  Created by yxlong on 15/7/27.
//  Copyright (c) 2015年 QQ:854072335. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XIColorHelper : NSObject
+ (UIColor *)SeparatorLineColor;
+ (UIColor *)ThemeColor;
@end

@interface UIColor(OpaqueColorFromHex)

+ (UIColor*)opaqueColorWithRGBBytes:(NSUInteger)hexConstant;
@end

