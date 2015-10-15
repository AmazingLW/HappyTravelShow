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
             withCityCode:(NSString*)cityCode
               WithFinish:(void (^)(NSMutableArray *arr))result{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes  = [NSSet setWithObject:@"text/html"];
        NSString*url = kPackage(cityCode,@"%",@"%",@"%",@"%");
              [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dict= (NSDictionary *)responseObject;
            //self.CarouseArr=[NSMutableArray array];
            NSArray*arr=dict[@"content"];
            for (NSDictionary*dic1 in arr) {
                if ([dic1[@"titleAlias"] isEqualToString:title]) {
                    NSArray*array=dic1[@"ad"];
                    for (NSDictionary*dic in array) {
                        NSDictionary*dict1=dic[@"ct"];
                        HomepageHeaderModel*product=[HomepageHeaderModel new];
                        [product setValuesForKeysWithDictionary:dict1];
                        [self.CityArr addObject:product];
                    }
                }
            }
//            if (_CarouseArr.count==5) {
//                 [self.CarouseArr removeObjectAtIndex:4];
//            }
          
            dispatch_async(dispatch_get_main_queue(), ^{
                result(self.CityArr);
            });
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            
        }];

    });
  
}




- (void)requestAllCity:(NSString*)kind
          withCityCode:(NSString*)cityCode
            WithFinish:(void (^)(NSMutableArray *arr))result{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes  = [NSSet setWithObject:@"text/html"];
        NSString*url = kCity(cityCode);
        [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dict= (NSDictionary *)responseObject;
            //self.CityArr=[NSMutableArray array];
            
            NSDictionary*dic=dict[@"content"];
            NSArray*cityArray=dic[kind];
            for (NSDictionary*dict1 in cityArray) {
                HomepageScenicModel*scenic=[HomepageScenicModel new];
                [scenic setValuesForKeysWithDictionary:dict1];
                [self.CityArr addObject:scenic];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                result(self.CityArr);
            });
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            
        }];
        
    });
    
}


- (void)requestAllRecommendation:(NSString*)cityCode
                      WithFinish:(void (^)(NSMutableArray *arr))result{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes  = [NSSet setWithObject:@"text/html"];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
        NSString*url = kRecommendation(cityCode);
        [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dict= (NSDictionary *)responseObject;
            //self.RecommendationArr=[NSMutableArray array];

            NSArray*Array=dict[@"content"];
            for (NSDictionary*dict in Array) {
                HomepagePackageModel*package =[HomepagePackageModel new];
                [package setValuesForKeysWithDictionary:dict];
                [self.CityArr addObject:package];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                result(self.CityArr);
            });
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            
        }];
        
    });
 
}


- (void)requestAllTicket:(NSString*)tagId
                    page:(NSInteger)page
                withSort:(NSString*)sort
               cityName:(NSString*)cityName
            WithFinish:(void (^)(NSMutableArray *arr))result{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes  = [NSSet setWithObject:@"text/html"];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
        NSString*url = KTicket(tagId,page, cityName, sort);
        NSString *codeUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [manager GET:codeUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dict= (NSDictionary *)responseObject;
            
            //self.CityArr=[NSMutableArray array];
        
            NSDictionary*dic=dict[@"data"];
            NSArray*cityArray=dic[@"items"];
            for (NSDictionary*dict1 in cityArray) {
               AroundKindModel *scenic=[AroundKindModel new];
                [scenic setValuesForKeysWithDictionary:dict1];
                [self.CityArr addObject:scenic];
            }
        
            dispatch_async(dispatch_get_main_queue(), ^{
                result(self.CityArr);
            });
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           // NSLog(@"Error: %@", error);
            
        }];
        
    });
    
}

- (void)requestAllFamily:(NSInteger)page
                   tagld:(NSString*)tagId
                withSort:(NSString*)sort
                cityName:(NSString*)cityName
              WithFinish:(void (^)(NSMutableArray *arr))result
{  dispatch_async(dispatch_get_global_queue(0, 0), ^{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes  = [NSSet setWithObject:@"text/html"];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
        NSString*url = KFamily(page,tagId,cityName, sort);
       NSString *codeUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [manager GET:codeUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dict= (NSDictionary *)responseObject;
            
            //self.CityArr=[NSMutableArray array];
            
            NSDictionary*dic=dict[@"data"];
            NSArray*cityArray=dic[@"items"];
            for (NSDictionary*dict1 in cityArray) {
                AroundKindModel *scenic=[AroundKindModel new];
                [scenic setValuesForKeysWithDictionary:dict1];
                [self.CityArr addObject:scenic];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                result(self.CityArr);
            });
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
        
    });

    
    
}

- (void)requestAllCityDetail:(NSInteger)p
                    citycold:(NSString*)citycold
                    cityName:(NSString*)cityName
                withSort:(NSInteger)sort
              WithFinish:(void (^)(NSMutableArray *arr))result
{  dispatch_async(dispatch_get_global_queue(0, 0), ^{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes  = [NSSet setWithObject:@"text/html"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    NSString*url = KCityDetails(p,citycold, cityName, sort);
    NSString *codeUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:codeUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict= (NSDictionary *)responseObject;
        
        //self.CityArr=[NSMutableArray array];
        
       
        NSArray*cityArray=dict[@"content"];
        for (NSDictionary*dict1 in cityArray) {
            HomepageCityModel*scenic =[HomepageCityModel new];
            [scenic setValuesForKeysWithDictionary:dict1];
            [self.CityArr addObject:scenic];
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
        //self.CityArr=[NSMutableArray array];
        NSDictionary*dic=dict[@"data"];
        NSArray*array = dic[kind];
        for (NSDictionary*dict1 in array) {
            HomepageCityListModel*city=[HomepageCityListModel new];
            [city setValuesForKeysWithDictionary:dict1];
            [self.CityArr addObject:city];
        }
        
        for (int i=0; i<self.CityArr.count; i++) {
            if ([[self.CityArr[i] pinYinName]isEqualToString:@""] ) {
                HomepageCityListModel*city=self.CityArr[i];
                city.pinYinName= @"KenDing";
            }

        }
        if ([kind isEqualToString:@"positionCity"]) {
              [self.CityArr sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return[[obj1 pinYinName]compare:[obj2 pinYinName]];
    }];
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

-(NSMutableArray*)CityArr{
    
    if (_CityArr==nil) {
        _CityArr =[NSMutableArray new];
    }
    return _CityArr;
}
@end

