//
//  ComDetailHelper.m
//  DetailpageDemo
//
//  Created by Amazing on 15/10/7.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "ComDetailHelper.h"
#import "AFNetworking.h"
#import "BookModel.h"
#import "DetailModel.h"


@interface ComDetailHelper ()

@property (nonatomic,strong) NSMutableArray *bookArr;

@property (nonatomic,strong) NSMutableArray *detailArr;

@end

@implementation ComDetailHelper



- (void)requestBookData:(NSString *)strUrl type:(NSString *)strType block:(void (^)(NSMutableArray *arr))block{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
        
        [manager GET:strUrl parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
           // NSLog(@"%@--",responseObject);
            
            if ([strType isEqualToString:@"bookData"]) {
                NSArray *dataArr = responseObject[@"data"];
                NSDictionary *dict = dataArr.firstObject;
                NSArray *arr = dict[@"packageInfos"];
                NSArray *firstArr = arr[0];
                
                
                _bookArr = [NSMutableArray array];
                for (NSDictionary *dit in firstArr) {
                    BookModel *model = [BookModel new];
                    [model setValuesForKeysWithDictionary:dit];
                    [_bookArr addObject:model];
                }
            }else if ([strType isEqualToString:@"detailData"]){
                _detailArr = [NSMutableArray array];
                NSDictionary *dict = responseObject[@"data"];
                DetailModel *detailModel = [DetailModel new];
                [detailModel setValuesForKeysWithDictionary:dict];
                [_detailArr addObject:detailModel];
            }
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([strType isEqualToString:@"bookData"]) {
                    block(self.bookArr);
                }else if ([strType isEqualToString:@"detailData"]){
                    block(self.detailArr);
                }
                
            });
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"%@",error);
        }];
        
        
        
    });
    
}


@end
