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



//创建数据库
- (void)createDataBase{
    
    NSString *dbPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"FMDB.sqlite"];
    _dataBase = [FMDatabase databaseWithPath:dbPath];
    
    //    NSFileManager *manager = [NSFileManager defaultManager];
    //   if ([manager isExecutableFileAtPath:dbPath]) {
    //        NSLog(@"数据库已经创建了");
    //        return;
    //    }
    //
    //    if ([_dataBase open]) {
    //
    //        NSLog(@"数据库创建成功");
    //    }
    
}
//创建表
- (void)creatTableWithSQLString:(NSString *)creatSql{
    
    [_dataBase open];
    
    if ([_dataBase executeUpdate:creatSql]) {
        
        NSLog(@"创建表%@成功",creatSql);
    }
    [_dataBase close];
    
}
//插入数据

- (void)insertDataToTableWithSQLString:(NSString *)insertSql{
    
    [_dataBase open];
    if ([_dataBase executeUpdate:insertSql]) {
        
        NSLog(@"插入%@成功",insertSql);
        
    }
    [_dataBase close];
}

//删除数据

- (void)deleteDataFromTableWithSQLString:(NSString *)deleteSql{
    
    [_dataBase open];
    
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
