//
//  AroundHelper.m
//  HappyTravelShow
//
//  Created by Amazing on 15/10/6.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "AroundHelper.h"
#import "AFNetworking.h"
#import "AroundURL.h"
#import "AroundMainModel.h"
@interface AroundHelper ()

@property (nonatomic, strong)NSMutableArray *mutableArray;

@end

@implementation AroundHelper


- (void)requestWithCityName:(NSString *)name finish:(void (^)(NSArray * array))result{
    
    NSString *urlString = AROUNDCITY(name);
    NSString *codeUrl = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //有问题 线程
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        _mutableArray = [NSMutableArray array];
        [manager GET:codeUrl parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
              AroundMainModel *model = [AroundMainModel new];
            NSDictionary *dic = responseObject[@"data"];
            NSArray *arr = dic[@"provinces"];
            NSDictionary *subdic = [arr firstObject];
            //城市名
            NSString *cityName = subdic[@"province"];
            //给对象赋值 为了筛选url拼接  
            [model setValue:cityName forKey:@"province"];
            
            NSArray *subArr = subdic[@"cities"];
         
            
            for (NSDictionary *diction in subArr) {
                [model setValuesForKeysWithDictionary:diction];
                [_mutableArray addObject:model];
            }
        dispatch_async(dispatch_get_main_queue(), ^{
       
        result(_mutableArray);
        
    });

        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            
        }];
        
         
    });
}


@end
