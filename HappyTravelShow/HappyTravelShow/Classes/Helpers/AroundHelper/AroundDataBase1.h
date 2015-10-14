//
//  AroundDataBase1.h
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/14.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AroundDataBase1 : NSObject

+ (instancetype)shareData;


- (NSArray *)selectDataFromTable;

@end
