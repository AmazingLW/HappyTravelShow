//
//  AroundDataBase.m
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/13.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "AroundDataBase.h"
#import "HomepageHelper.h"


@interface AroundDataBase ()

@property (nonatomic,strong)NSMutableArray *array;


@end

@implementation AroundDataBase

- (void)request{
    
    HomepageHelper *helper = [HomepageHelper new];
    
    [helper requestallCityList:@"positionCity" WithFinish:^(NSMutableArray *arr) {
        
        
        
    }];
    
}




- (HomepageCityListModel *)selectDataFromTableWithSQLString:(NSString *)selectSql{
    
    FMResultSet *result = [self.dataBase executeQuery:selectSql];
    while ([result next]) {
        
        
        
        
    }
    return nil;
}

@end
