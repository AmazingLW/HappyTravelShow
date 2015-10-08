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

@interface HomepageHelper()

@property(nonatomic,strong)NSMutableArray*CarouseArr;
@property(nonatomic,strong)NSMutableArray*ProductArr;
@property(nonatomic,strong)NSMutableArray*PackageArr;


@end

@implementation HomepageHelper

//+(HomepageHelper*)shareHelp{
//    static HomepageHelper*helper = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        helper =[HomepageHelper new];
//    });
//    
//    return helper;
//}

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
           // [self.CarouseArr removeObjectAtIndex:4];
            dispatch_async(dispatch_get_main_queue(), ^{
                result(self.CarouseArr);
            });
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            
        }];

    });
    
    
    
}


-(NSArray*)CarouseArray{
    return [_CarouseArr mutableCopy];
}
-(NSArray*)ProductArray{
    return [_ProductArr mutableCopy];
}
-(NSArray*)PackageArray{
    return [_PackageArr mutableCopy];
}
@end
