//
//  AroundDataBase.m
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/13.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "AroundDataBase.h"
#import "HomepageHelper.h"
#import "HomepageCityListModel.h"
#define insertSQl
@interface AroundDataBase ()

@property (nonatomic,strong)NSMutableArray *array;


@end

@implementation AroundDataBase

//@property (nonatomic, assign) NSInteger cityId;
//@property (nonatomic, strong) NSString *cityCode;
//@property (nonatomic, strong) NSString *pinYinName;
//@property (nonatomic, strong) NSString *cityName;
//@property (nonatomic, strong) NSString *cityNameAbbr;
//@property (nonatomic, assign) BOOL isHot;

//把所有城市放入一个数据库 , 搜索是去这个数据库匹配 把匹配出来的数据放进另一个数据库 有删除操作

+ (instancetype)shareData{
    static AroundDataBase *data = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        data = [[AroundDataBase alloc] init];
        
        
    });
    
    return data;
}


- (void)request{
    
    HomepageHelper *helper = [HomepageHelper new];
    
    [helper requestallCityList:@"positionCity" WithFinish:^(NSMutableArray *arr) {
        
        _array = arr;
        
    }];
    
    
}

- (void)creatTableWithSQLString:(NSString *)creatSql{
    

    
    creatSql = @"CREATE TABLE IF NOT EXISTS SearchCity (id NSInteger PRIMARY KEY AUTOINCREMENT,cityId int,cityCode int,pinYinName NSString,cityName NSString,cityNameAbbr NSString)";

    
    if ([self.dataBase executeUpdate:creatSql]) {
        
        
        NSLog(@"创建表%@成功",creatSql);
    }
   
    
}


- (void)insertDataToTableWithSQLString:(NSString *)insertSql{

    [self request];
    
    for (int i = 0; i < self.array.count; i ++) {
        
        HomepageCityListModel *model = self.array[i];
        insertSql =[NSString stringWithFormat:@"INSERT INTO SearchCity (cityId, cityCode, pinYinName, cityName, cityNameAbbr, isHot) VALUES (%ld,%@,%@,%@,%@)",model.cityId,model.cityCode,model.pinYinName,model.cityName,model.cityNameAbbr];
        
        [self.dataBase executeUpdate:insertSql];

    }
    
    
}


- (NSString *)selectDataFromTableWithSQLString:(NSString *)selectSql{
    
     HomepageCityListModel * model = [[HomepageCityListModel alloc] init];

    FMResultSet *result = [self.dataBase executeQuery:selectSql];
    while ([result next]) {
      

        
       
      //  model.cityName =cityName;
        
           // NSLog(@"%d %@ %d", ID, name, age);
        

     
        
        
    }
    return model.cityName;
}

@end
