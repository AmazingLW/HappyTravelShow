//
//  DataBase.m
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/13.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "DataBase.h"

@interface DataBase ()



@end

@implementation DataBase

+ (instancetype)shareData{
    static DataBase *data = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        data = [[DataBase alloc] init];
 
    });
    
    return data;
}

//创建表
- (void)creatTableWithSQLString:(NSString *)creatSql{
    
    NSString *dbPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"city.sqlite"];
    _dataBase = [FMDatabase databaseWithPath:dbPath];
    
    if ([_dataBase open]) {
        
        BOOL result = [_dataBase executeUpdate:creatSql];
        
        if (result) {
            NSLog(@"创建%@表成功",creatSql);
        }else{
            NSLog(@"创建%@表失败",creatSql);

        }
        
    }

    
}
//插入数据

- (void)insertDataToTableWithSQLString:(NSString *)insertSql{
    
    
    if ([_dataBase executeUpdate:insertSql]) {
        
        NSLog(@"插入%@成功",insertSql);
        
    }
    
  
}

//删除数据

- (void)deleteDataFromTableWithSQLString:(NSString *)deleteSql{
    
   
    
    if ([_dataBase executeUpdate:deleteSql]) {
        
        NSLog(@"删除%@成功",deleteSql);
    }
  
}




//- (id)selectDataFromTableWithSQLString:(NSString *)selectSql{
//    [_dataBase open];
//    FMResultSet *result = [_dataBase executeQuery:selectSql];
//    while ([result next]) {
//        
//        
//        
//        
//    }
//    [_dataBase close];
//    return nil;
//}

@end
