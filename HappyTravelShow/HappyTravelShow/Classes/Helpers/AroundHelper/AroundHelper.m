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
#import "AroundKindModel.h"
@interface AroundHelper ()
//AroundMainModel.h数组
@property (nonatomic, strong)NSMutableArray *mutableArray;
@property (nonatomic, strong) AroundMainModel *model;
//存放景点的all
@property (nonatomic, strong)NSMutableArray *allScien;

//存放小景点列表

@property (nonatomic, strong)NSMutableArray *littleScine;

@end

@implementation AroundHelper



 //取得目的城市 和 景点列表 和 tags
- (void)requestWithCityName:(NSString *)name finish:(void (^)(NSArray * array))result{
   
    NSString *urlString = AROUNDCITY(name);
    NSString *codeUrl = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //NSLog(@"======================%@",codeUrl);//有值
    // 异步 async
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        _mutableArray = [NSMutableArray array];
        [manager GET:codeUrl parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
          //  NSLog(@"%@",responseObject);
          
            
            NSDictionary *dic = responseObject[@"data"];
            
            NSArray *arr = dic[@"provinces"];
            NSDictionary *subdic = [arr firstObject];
            
            //城市名 可能需要到
            
            //NSString *cityName = subdic[@"province"];
            //给对象赋值 为了筛选url拼接  
            //[model setValue:cityName forKey:@"province"];
            
            NSArray *subArr = subdic[@"cities"];
            
            
            for (NSDictionary *diction in subArr) {
                 AroundMainModel *model = [AroundMainModel new];
                [model setValuesForKeysWithDictionary:diction];
                [_mutableArray addObject:model];
            }
            
 //           NSLog(@"-------------%@",_mutableArray);
//            for (AroundMainModel *m in _mutableArray) {
//                NSLog(@"%@",m);
//            }
            dispatch_async(dispatch_get_main_queue(), ^{
       
        result(_mutableArray);
        
    });

        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            
        }];
        
         
    });
}



//所有景点数据
- (void)requsetAllScenicsWithCityName:(NSString *)name finish:(void(^)(NSArray *scenic))result{
    
    NSString *url = AllScenic(name);
    
    NSString *codeUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
   //NSLog(@"all%@",codeUrl);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        _allScien = [NSMutableArray array];
        [manager GET:codeUrl parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            NSDictionary *dic = responseObject[@"data"];
            NSArray *array = dic[@"items"];
            for (NSDictionary *d in array) {
                AroundKindModel *model = [AroundKindModel new];
                [model setValuesForKeysWithDictionary:d];
                [_allScien addObject:model];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                result(_allScien);
                
            });
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
        
        
        
        
    });
    
    
    
    
}

//列表小景点请求数据
- (void)requestLittleScenicWithCithName:(NSString *)cityName scenicName:(NSString *)scenicName finish:(void (^)(NSArray * array))result{
    
    NSString *url = littleScenicURL(scenicName, cityName);
    
    NSString *codeUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
   // NSLog(@"little%@",codeUrl);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        _littleScine = [NSMutableArray array];
        [manager GET:codeUrl parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            NSDictionary *dic = responseObject[@"data"];
            NSArray *array = dic[@"items"];
            for (NSDictionary *d in array) {
                AroundKindModel *model = [AroundKindModel new];
                [model setValuesForKeysWithDictionary:d];
                [_allScien addObject:model];
            }
            
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                result(_littleScine);
                
            });
            
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
        
        
        
        
    });
    
    
    
}


//当目的城市为全部使筛选  cityName 是定位时的城市

- (void)chooseScenicWithTagName:(NSString *)tagName cityName:(NSString *)cityName finish:(void (^)(NSArray * array))result{
    
    NSString *url = chooseAllCity(tagName, cityName);
    
    NSString *codeUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
   // NSLog(@"%@",codeUrl);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableArray *array = [NSMutableArray array];
    [manager GET:codeUrl parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dic = responseObject[@"data"];
        NSArray *arr = dic[@"items"];
        for (NSDictionary *d in arr) {
            AroundKindModel *model = [AroundKindModel new];
            [model setValuesForKeysWithDictionary:d];
            [_allScien addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            result(array);
        });
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
    
}


@end
