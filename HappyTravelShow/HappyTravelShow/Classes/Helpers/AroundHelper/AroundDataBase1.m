//
//  AroundDataBase1.m
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/14.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "AroundDataBase1.h"
#import "HomepageHelper.h"
#import "FMDatabase.h"
#import "HomepageCityListModel.h"
@interface AroundDataBase1 ()
@property (nonatomic,strong)NSMutableArray *array;
@property (nonatomic, strong)FMDatabase *dataBase;
@end

@implementation AroundDataBase1

+ (instancetype)shareData{
    static AroundDataBase1 *data = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        data = [[AroundDataBase1 alloc] init];
        
        
    });
    
    return data;
}

- (void)request{
    
    
    
}


- (NSArray *)selectDataFromTable{
    
   // [self request];

    NSString *dbPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"city.sqlite"];
    _dataBase = [FMDatabase databaseWithPath:dbPath];
    
     NSString * creatSql = @"CREATE TABLE IF NOT EXISTS SearchCity (id integer PRIMARY KEY AUTOINCREMENT,cityId int,cityCode int,pinYinName NSString,cityName NSString,cityNameAbbr NSString)";
    if ([_dataBase open]) {
        
        BOOL result = [_dataBase executeUpdate:creatSql];
        
        if (result) {
            NSLog(@"创建%@表成功",creatSql);
        }else{
            NSLog(@"创建%@表失败",creatSql);
            
        }
        
    }

    HomepageHelper *helper = [HomepageHelper new];
    
    [helper requestallCityList:@"positionCity" WithFinish:^(NSMutableArray *arr) {
        _array = [NSMutableArray arrayWithArray:[arr mutableCopy]];
    for (int i = 0; i < self.array.count; i ++) {
        
        HomepageCityListModel *model = self.array[i];
      NSString * insertSql =[NSString stringWithFormat:@"INSERT INTO SearchCity (cityId, cityCode, pinYinName, cityName, cityNameAbbr) VALUES (%ld,%@,%@,%@,%@)",model.cityId,model.cityCode,model.pinYinName,model.cityName,model.cityNameAbbr];
        
      BOOL result = [self.dataBase executeUpdate:insertSql];
        if (result) {
            NSLog(@"插入成功");
        }else{
            NSLog(@"插入失败");
        }
    }
    }];
        
    _array = [NSMutableArray array];
    HomepageCityListModel * model = [[HomepageCityListModel alloc] init];
    
    NSString *selectSql = @"SELECT * FROM SearchCity";
    
    FMResultSet *result = [self.dataBase executeQuery:selectSql];
    while ([result next]) {
        
    //    int ID = [result intForColumn:@"id"];
      //  int cityId = [result intForColumn:@"cityId"];
     //   NSString *cityCode = [result stringForColumn:@"cityCode"];
     //   NSString *pinYinName = [result stringForColumn:@"pinYinName"];
        NSString *cityName = [result stringForColumn:@"cityName"];
        
     //   NSString *cityNameAbbr = [result stringForColumn:@"cityNameAbbr"];
        
        // bool *isHot = (bool *)[result boolForColumn:@"isHot"];
        
        
        model.cityName =cityName;
        
        // NSLog(@"%d %@ %d", ID, name, age);
        
        [_array addObject:model.cityName];
        
        
        
    }
    return _array;
    
    
    
    
    
}


@end
