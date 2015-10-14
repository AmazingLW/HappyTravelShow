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

#pragma mark -------------


// 创建数据库
- (void)createDataBase
{
    
    NSString *dbPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"city.sqlite"];
    _dataBase = [[FMDatabase alloc] initWithPath:dbPath];
    if([_dataBase open])
        NSLog(@"数据库创建成功");
    else
        NSLog(@"数据库创建失败");
    
}

// 创建表
- (void)createTable
{
    BOOL isSuc = NO;
    // 打开数据库
    [_dataBase open];
    isSuc =  [_dataBase executeUpdate:@"create table Shoucang(id integer primary key autoincrement,title text,content text,curprice text,oldprice text,sellcount text,imgurl text,bookID text,detail text)"];
    if (isSuc) {
        NSLog(@"创建表成功");
    }else{
        NSLog(@"创建表失败");
    }
    // 关闭数据库
    [_dataBase close];
}

// 插入数据
- (BOOL)insertPeople:(NSString *)sql
{
    BOOL isSuc = NO;
    [_dataBase open];
    isSuc = [_dataBase executeUpdate:sql];
    [_dataBase close];
    
    return isSuc;
}

// 修改数据
- (BOOL)updatePeople:(NSString *)sql
{
    BOOL isSuc = NO;
    [_dataBase open];
    isSuc = [_dataBase executeUpdate:sql];
    [_dataBase close];
    return isSuc;
}

// 删除数据
- (BOOL)deletePeople:(NSString *)sql
{
    BOOL isSuc = NO;
    [_dataBase open];
    isSuc = [_dataBase executeUpdate:sql];
    [_dataBase close];
    
    return isSuc;
}


@end
