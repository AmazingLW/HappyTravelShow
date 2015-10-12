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
#import "ScenicDetailModel.h"


@interface ComDetailHelper ()

@property (nonatomic,strong) NSMutableArray *bookArr;

@property (nonatomic,strong) NSMutableArray *detailArr;

@property (nonatomic,strong) NSMutableArray * scenicDetailArr;

@property (nonatomic,strong) NSMutableArray * ticketDetailArr;

@end

@implementation ComDetailHelper



- (void)requestBookData:(NSString *)strUrl type:(NSString *)strType block:(void (^)(NSMutableArray *arr))block{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];
        
        [manager GET:strUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
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
            }else if ([strType isEqualToString:@"scenidDetailData"]){
                _scenicDetailArr = [NSMutableArray array];
                NSDictionary *dict = responseObject[@"content"];
                ScenicDetailModel *model = [ScenicDetailModel new];
                [model setValuesForKeysWithDictionary:dict];
                [_scenicDetailArr addObject:model];
            }else if ([strType isEqualToString:@"ticketDetailData"]){
                _ticketDetailArr = [NSMutableArray array];
                NSArray *arr = responseObject[@"content"];
                for (NSDictionary *dict in arr) {
                ScenicDetailModel *model = [ScenicDetailModel new];
                [model setValuesForKeysWithDictionary:dict];
                [_ticketDetailArr addObject:model];
                }
            }
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([strType isEqualToString:@"bookData"]) {
                    block(self.bookArr);
                }else if ([strType isEqualToString:@"detailData"]){
                    block(self.detailArr);
                }else if ([strType isEqualToString:@"scenidDetailData"]){
                    block(self.scenicDetailArr);
                }else if ([strType isEqualToString:@"ticketDetailData"]){
                    block(self.ticketDetailArr);
                }
                
            });
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
        }];
        
        
        
    });
    
}


@end
