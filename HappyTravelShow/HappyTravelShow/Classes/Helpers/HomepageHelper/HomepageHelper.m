//
//  HomepageHelper.m
//  HappyTravelShow
//
//  Created by Amazing on 15/10/6.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "HomepageHelper.h"
#import "AFNetworking.h"
#import "HomepageURL.h"
#import "HomepageHeaderModel.h"
#import "HomepageScenicModel.h"
#import "HomepagePackageModel.h"
#import "AroundKindModel.h"
#import "HomepageCityModel.h"
#import "HomepageCityListModel.h"

@interface HomepageHelper()

@property(nonatomic,strong)NSMutableArray*CarouseArr;
@property(nonatomic,strong)NSMutableArray*CityArr;
@property(nonatomic,strong)NSMutableArray*RecommendationArr;

@end

@implementation HomepageHelper



- (void)requestAllPackage:(NSString*)title
               WithFinish:(void (^)(NSMutableArray *arr))result{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes  = [NSSet setWithObject:@"text/html"];
        [manager GET:kPackage parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dict= (NSDictionary *)responseObject;
            self.CarouseArr=[NSMutableArray array];
            NSArray*arr=dict[@"content"];
            for (NSDictionary*dic1 in arr) {
                if ([dic1[@"titleAlias"] isEqualToString:title]) {
                    NSArray*array=dic1[@"ad"];
                    for (NSDictionary*dic in array) {
                        NSDictionary*dict1=dic[@"ct"];
                        HomepageHeaderModel*product=[HomepageHeaderModel new];
                        [product setValuesForKeysWithDictionary:dict1];
                        [self.CarouseArr addObject:product];
                    }
                }
            }
//            if (_CarouseArr.count==5) {
//                 [self.CarouseArr removeObjectAtIndex:4];
//            }
          
            dispatch_async(dispatch_get_main_queue(), ^{
                result(self.CarouseArr);
            });
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            
        }];

    });
  
}




- (void)requestAllCity:(NSString*)kind
            WithFinish:(void (^)(NSMutableArray *arr))result{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes  = [NSSet setWithObject:@"text/html"];
        [manager GET:kCity parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dict= (NSDictionary *)responseObject;
            self.CityArr=[NSMutableArray array];
            
            NSDictionary*dic=dict[@"content"];
            NSArray*cityArray=dic[kind];
            for (NSDictionary*dict1 in cityArray) {
                HomepageScenicModel*scenic=[HomepageScenicModel new];
                [scenic setValuesForKeysWithDictionary:dict1];
                [_CityArr addObject:scenic];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                result(self.CityArr);
            });
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            
        }];
        
    });
    
}


- (void)requestAllRecommendation:(void (^)(NSMutableArray *arr))result{
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes  = [NSSet setWithObject:@"text/html"];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
        [manager GET:kRecommendation parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dict= (NSDictionary *)responseObject;
            self.RecommendationArr=[NSMutableArray array];

            NSArray*Array=dict[@"content"];
            for (NSDictionary*dict in Array) {
                HomepagePackageModel*package =[HomepagePackageModel new];
                [package setValuesForKeysWithDictionary:dict];
                [_RecommendationArr addObject:package];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                result(self.RecommendationArr);
            });
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            
        }];
        
    });
 
}


- (void)requestAllTicket:(NSString*)tagId
                withSort:(NSString*)sort
            WithFinish:(void (^)(NSMutableArray *arr))result{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes  = [NSSet setWithObject:@"text/html"];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
        NSString*url = KTicket(tagId, @"%E5%8C%97%E4%BA%AC", sort);
        [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dict= (NSDictionary *)responseObject;
            
            self.CityArr=[NSMutableArray array];
        
            NSDictionary*dic=dict[@"data"];
            NSArray*cityArray=dic[@"items"];
            for (NSDictionary*dict1 in cityArray) {
               AroundKindModel *scenic=[AroundKindModel new];
                [scenic setValuesForKeysWithDictionary:dict1];
                [_CityArr addObject:scenic];
            }
        
            dispatch_async(dispatch_get_main_queue(), ^{
                result(self.CityArr);
            });
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           // NSLog(@"Error: %@", error);
            
        }];
        
    });
    
}

- (void)requestAllFamily:(NSString*)tagId
                withSort:(NSString*)sort
              WithFinish:(void (^)(NSMutableArray *arr))result
{  dispatch_async(dispatch_get_global_queue(0, 0), ^{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes  = [NSSet setWithObject:@"text/html"];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
        NSString*url = KFamily(tagId, @"%E5%8C%97%E4%BA%AC", sort);
        [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dict= (NSDictionary *)responseObject;
            
            self.CityArr=[NSMutableArray array];
            
            NSDictionary*dic=dict[@"data"];
            NSArray*cityArray=dic[@"items"];
            for (NSDictionary*dict1 in cityArray) {
                AroundKindModel *scenic=[AroundKindModel new];
                [scenic setValuesForKeysWithDictionary:dict1];
                [_CityArr addObject:scenic];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                result(self.CityArr);
            });
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
        
    });

    
    
}

- (void)requestAllCityDetail:(NSString*)citycold
                    cityName:(NSString*)cityName
                withSort:(NSInteger)sort
              WithFinish:(void (^)(NSMutableArray *arr))result
{  dispatch_async(dispatch_get_global_queue(0, 0), ^{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes  = [NSSet setWithObject:@"text/html"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    NSString*url = KCityDetails(citycold, cityName, sort);
    NSString *codeUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
   // NSLog(@"=-=-=-=-=-=-=-=-=-=-=-=-=-=%@",codeUrl);
    [manager GET:codeUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"=============%@",responseObject);
        NSDictionary *dict= (NSDictionary *)responseObject;
        
        self.CityArr=[NSMutableArray array];
        
       
        NSArray*cityArray=dict[@"content"];
        for (NSDictionary*dict1 in cityArray) {
//            AroundKindModel *scenic=[AroundKindModel new];
            HomepageCityModel*scenic =[HomepageCityModel new];
            [scenic setValuesForKeysWithDictionary:dict1];
            [_CityArr addObject:scenic];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            result(self.CityArr);
        });
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
    }];
    
});
    
    
    
}

-(void)requestallCityList:(NSString*)kind
               WithFinish:(void (^)(NSMutableArray *arr))result
{  dispatch_async(dispatch_get_global_queue(0, 0), ^{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes  = [NSSet setWithObject:@"text/html"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager GET:kCityList parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict= (NSDictionary *)responseObject;
        self.CityArr=[NSMutableArray array];
        NSDictionary*dic=dict[@"data"];
        NSArray*array = dic[kind];
        for (NSDictionary*dict1 in array) {
            HomepageCityListModel*city=[HomepageCityListModel new];
            [city setValuesForKeysWithDictionary:dict1];
            [_CityArr addObject:city];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            result(self.CityArr);
        });
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
});
    
    
    
}
-(NSArray*)CarouseArray{
    return [_CarouseArr mutableCopy];
}

@end

