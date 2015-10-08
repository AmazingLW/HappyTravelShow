//
//  ComDetailHelper.h
//  DetailpageDemo
//
//  Created by Amazing on 15/10/7.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComDetailHelper : NSObject


- (void)requestBookData:(NSString *)strUrl type:(NSString *)strType block:(void (^)(NSMutableArray *arr))block;

@end
