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
#import "HotSearchModel.h"

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
   // NSLog(@"======================%@",codeUrl);//有值
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
- (void)requestLittleScenicWithScenicName:(NSString *)scenicName cityName:(NSString *)cityName finish:(void (^)(NSArray * array))result{
    
    NSString *url = littleScenicURL(scenicName, cityName);
    
    NSString *codeUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
   //NSLog(@"little%@",codeUrl);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        _littleScine = [NSMutableArray array];
        [manager GET:codeUrl parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            NSDictionary *dic = responseObject[@"data"];
            NSArray *array = dic[@"items"];
            for (NSDictionary *d in array) {
                AroundKindModel *model = [AroundKindModel new];
                [model setValuesForKeysWithDictionary:d];
                [_littleScine addObject:model];
            }
 
            dispatch_async(dispatch_get_main_queue(), ^{
                result(_littleScine);
                
            });

        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];

    });
 
}

//筛选
//当目的城市为全部使筛选  cityName 是定位时的城市

- (void)chooseScenicWithSortType:(NSString *)sortType TagName:(NSString *)tagName cityName:(NSString *)cityName finish:(void(^)(NSArray * array))result{
    
    NSString *url = chooseAllScenic(sortType, tagName, cityName);
    
    NSString *codeUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",codeUrl);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        _littleScine = [NSMutableArray array];
        [manager GET:codeUrl parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            NSDictionary *dic = responseObject[@"data"];
            NSArray *array = dic[@"items"];
            for (NSDictionary *d in array) {
                AroundKindModel *model = [AroundKindModel new];
                [model setValuesForKeysWithDictionary:d];
                [_littleScine addObject:model];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                result(_littleScine);
                
            });
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
        
    });
}


//筛选
//// 当目的城市选定 景点选定 排序方式 sortType 任意  筛选方式改变  景点(scenicName) 三清山  city(是目的城市 @"上饶")
//如果 scenicName 为空时   使用另一个URl 筛选 当目的城市选定 景点全部 排序方式 sortType 任意  筛选方式改变  city(是目的城市 @"上饶")

- (void)chooseScenicWithScenicName:(NSString *)scenicName SortType:(NSString *)sortType TagName:(NSString *)tagName cityName:(NSString *)cityName finish:(void(^)(NSArray * array))result{
    
    if (![scenicName isEqualToString:@"全部"]) {
        //cityName目的城市
        NSString *url = chooseLittleScenic(sortType, tagName, cityName);
        NSString *codeUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
       // NSLog(@"%@",codeUrl);
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            _littleScine = [NSMutableArray array];
            [manager GET:codeUrl parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                NSDictionary *dic = responseObject[@"data"];
                NSArray *array = dic[@"items"];
                for (NSDictionary *d in array) {
                    AroundKindModel *model = [AroundKindModel new];
                    [model setValuesForKeysWithDictionary:d];
                    [_littleScine addObject:model];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    result(_littleScine);
                    
                });
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                
            }];
        });

    }else{
        
        NSString *url = chooseAllCity(scenicName, sortType, tagName, cityName);
        
        NSString *codeUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        //NSLog(@"%@",codeUrl);
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            _littleScine = [NSMutableArray array];
            [manager GET:codeUrl parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                NSDictionary *dic = responseObject[@"data"];
                NSArray *array = dic[@"items"];
                for (NSDictionary *d in array) {
                    AroundKindModel *model = [AroundKindModel new];
                    [model setValuesForKeysWithDictionary:d];
                    [_littleScine addObject:model];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    result(_littleScine);
                    
                });
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                
            }];
            
        });

    }

}





//排序  目的城市全部 景点全部 city传进来的城市 (景德镇的经纬度)

- (void)sortDataWithType:(NSString *)type cityName:(NSString *)cityName finish:(void(^)(NSArray * array))result{
    
    NSString *url = sortDataUp(type, cityName);
   
    NSString *codeUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",codeUrl);
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSMutableArray * sortDataUp = [NSMutableArray array];
        [manager GET:codeUrl parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            NSDictionary *dic = responseObject[@"data"];
            NSArray *array = dic[@"items"];
            for (NSDictionary *d in array) {
                AroundKindModel *model = [AroundKindModel new];
                [model setValuesForKeysWithDictionary:d];
                [sortDataUp addObject:model];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                result(sortDataUp);
                
            });
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
        
    });

}


//排序 当目的城市选定 景点全部时 列表
- (void)requsetAllScenicsWithScenicName:(NSString *)scenicName finish:(void(^)(NSArray *scenic))result{
    
    NSString *url = partScenic(scenicName);
    
    NSString *codeUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //NSLog(@"%@",codeUrl);
     dispatch_async(dispatch_get_global_queue(0, 0), ^{
         AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
          NSMutableArray * sortDataUp = [NSMutableArray array];
         [manager GET:codeUrl parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
             NSDictionary *dic = responseObject[@"data"];
             NSArray *array = dic[@"items"];
             for (NSDictionary *d in array) {
                 AroundKindModel *model = [AroundKindModel new];
                 [model setValuesForKeysWithDictionary:d];
                 [sortDataUp addObject:model];
             }
             
             dispatch_async(dispatch_get_main_queue(), ^{
                 result(sortDataUp);
                 
             });

         } failure:^(NSURLSessionDataTask *task, NSError *error) {
             
         }];
         
     });

}

//排序 目的城市选定 景点全部

- (void)partSortDataWithType:(NSString *)type cityName:(NSString *)cityName finish:(void (^)(NSArray *))result{
    
    NSString *url = sortPartDataUp(type, cityName);
    NSString *codeUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
   // NSLog(@"%@",codeUrl);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSMutableArray * sortDataUp = [NSMutableArray array];
        [manager GET:codeUrl parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            NSDictionary *dic = responseObject[@"data"];
            NSArray *array = dic[@"items"];
            for (NSDictionary *d in array) {
                AroundKindModel *model = [AroundKindModel new];
                [model setValuesForKeysWithDictionary:d];
                [sortDataUp addObject:model];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                result(sortDataUp);
                
            });
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
        
    });

}
//排序 目的城市选定 景点选定

- (void)littleSortDataWithScenicName:(NSString *)scenicName type:(NSString *)type cityName:(NSString *)cityName finish:(void (^)(NSArray *))result{
    
    NSString *url = sortLittleDataUp(scenicName, type, cityName);
    NSString *codeUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
     NSLog(@"%@",codeUrl);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSMutableArray * sortDataUp = [NSMutableArray array];
        [manager GET:codeUrl parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            NSDictionary *dic = responseObject[@"data"];
            NSArray *array = dic[@"items"];
            for (NSDictionary *d in array) {
                AroundKindModel *model = [AroundKindModel new];
                [model setValuesForKeysWithDictionary:d];
                [sortDataUp addObject:model];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                result(sortDataUp);
                
            });
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
        
    });
    
}

//--------------------------------------------------

- (void) requestDataFromURLStringWithScenicName:(NSString *)scenicName sort:(NSString *)sort tagName:(NSString *)tagName cityName:(NSString *)cityName finish:(void(^)(NSArray * array))result{
    
    
    if (nil == tagName) {
        
        
        NSString *url = scenicList(scenicName, sort, cityName);
        
        NSString *codeUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"%@",codeUrl);
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            NSMutableArray * sortDataUp = [NSMutableArray array];
            [manager GET:codeUrl parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                NSDictionary *dic = responseObject[@"data"];
                NSArray *array = dic[@"items"];
                for (NSDictionary *d in array) {
                    AroundKindModel *model = [AroundKindModel new];
                    [model setValuesForKeysWithDictionary:d];
                    [sortDataUp addObject:model];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    result(sortDataUp);
                    
                });
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                
            }];
            
        });

        
        
    }else{
        
        NSString *url = partScenicList(scenicName, sort, tagName, cityName);
        
        NSString *codeUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"%@",codeUrl);
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            NSMutableArray * sortDataUp = [NSMutableArray array];
            [manager GET:codeUrl parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                NSDictionary *dic = responseObject[@"data"];
                NSArray *array = dic[@"items"];
                for (NSDictionary *d in array) {
                    AroundKindModel *model = [AroundKindModel new];
                    [model setValuesForKeysWithDictionary:d];
                    [sortDataUp addObject:model];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    result(sortDataUp);
                    
                });
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                
            }];
            
        });
        
        
        
    }
    
    
    
    
}


- (void)requestHotCityWithCityID:(NSInteger)cityID result:(void (^)(NSArray * array))result{
    
    NSString *url = hotCity(cityID);
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            
            NSDictionary *dic= responseObject[@"data"];
            NSArray *array = dic[@"keys"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
              
                result(array);
            });
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];

    });
    
    
    
    
    
}

//热门城市列表
- (void)requestHotCityListWithKeyWord:(NSString *)keyWord city:(NSString *)city result:(void(^)(NSArray * array)) result{
    
    NSString *url = hotCityList(keyWord, city);
    
    NSString *codeUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",codeUrl);
    
    NSMutableArray *arr = [NSMutableArray array];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        [manager GET:codeUrl parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            
        
            NSDictionary *dic = responseObject[@"data"];
            NSArray *array = dic[@"rows"];
            for (NSDictionary *dict in array) {
                HotSearchModel *model = [[HotSearchModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                [arr addObject:model];
            }
            
            
     dispatch_async(dispatch_get_main_queue(), ^{
        
         result(arr);
         
     });
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
        
    });
    
    
    
    
}





@end
