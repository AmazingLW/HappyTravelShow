
//
//  HotCityCell.m
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/12.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "HotCityCell.h"
#define kWidth [UIScreen mainScreen].bounds.size.width
@implementation HotCityCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,(kWidth-20)/3 , 30)];
        self.lable.textAlignment =NSTextAlignmentCenter;
    [self addSubview:_lable];
    }
    return self;
}
@end
