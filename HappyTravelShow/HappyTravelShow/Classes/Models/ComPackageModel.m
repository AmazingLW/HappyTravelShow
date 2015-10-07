//
//  ComPackageModel.m
//  HappyTravelShow
//
//  Created by Amazing on 15/10/6.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "ComPackageModel.h"

@implementation ComPackageModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    NSLog(@"");
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", _bigImageUrl];
}
@end
