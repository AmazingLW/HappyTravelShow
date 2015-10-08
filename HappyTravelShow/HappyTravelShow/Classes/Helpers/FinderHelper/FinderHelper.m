//
//  FinderHelper.m
//  HappyTravelShow
//
//  Created by Amazing on 15/10/6.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "FinderHelper.h"
#import "AFNetworking.h"
#import "FinderURL.h"
#import "FinderMainModel.h"
#import "FinderKindModel.h"
@interface FinderHelper ()
//接收发现书页面数据的数组
@property(nonatomic,strong)NSMutableArray *muArray;
//接收发现各种景点数据的数组
@property(nonatomic,strong)NSMutableArray *dataSource;

@end

@implementation FinderHelper
//数组懒加载
- (NSMutableArray *)muArray{
    if (_muArray==nil) {
        _muArray=[NSMutableArray array];
    }
    return _muArray;
    
}

- (NSArray *)dataArray{
    
    return [_muArray mutableCopy];
    
}

- (NSArray *)dataSource{
    
    if (_dataSource==nil) {
        _dataSource=[NSMutableArray array];
    }
    return _dataSource;
}
- (NSArray *)kindArray{
    
    return [_dataSource mutableCopy];
    
}



+ (FinderHelper *)sharedHelper{
    
    static  FinderHelper *helper=nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper=[FinderHelper new];
    });
    return helper;
    
}
//主页面数据请求
- (void)getDataWithCityCode:(NSString *)cityCode pageIndex:(NSInteger )pageIndex Finish:(void(^)())result{
    
    //子线程请求数据
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *url=fURL(cityCode, pageIndex);
        // NSLog(@"%@",url);
        //        //接口编码
        //        NSString *codeURL=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
        
        manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
        [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //
            ///定义一个数组接收responseObject的数据;
            NSDictionary *tempDict=responseObject[@"content"];
            for (NSString *key in tempDict) {
                if ([key isEqualToString:@"themeList"]) {
                    NSArray *tempArr= tempDict[key];
                    for (NSDictionary *dict in tempArr) {
                        FinderMainModel *mainModel=[FinderMainModel new];
                        [mainModel setValuesForKeysWithDictionary:dict];
                        [self.muArray addObject:mainModel];
                    }
                    
                }
                
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                result();
                
            });
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
        }];
        
        
    });
    
    
}




@end
