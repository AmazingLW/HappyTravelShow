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


#pragma mark -------------


// 创建数据库
- (void)createDataBase
{
    
    NSString *dbPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"city.sqlite"];
    _dataBase = [[FMDatabase alloc] initWithPath:dbPath];
    if([_dataBase open])
        NSLog(@"数据库打开成功");
    else
        NSLog(@"数据库打开失败");
    
}

// 创建表
- (void)createTable
{
    BOOL isSuc = NO;
    // 打开数据库
    [_dataBase open];
    
    if (![self isTableOK:@"Shoucang"]) {
        isSuc =  [_dataBase executeUpdate:@"create table Shoucang(id integer primary key autoincrement,title text,content text,curprice text,oldprice text,sellcount text,imgurl text,bookID text,detail text,userID text,cictyName text)"];
        if (isSuc) {
            NSLog(@"创建表成功");
        }else{
            NSLog(@"创建表失败");
        }

    }
    
        // 关闭数据库
    [_dataBase close];
}


// 删除表
- (BOOL) deleteTable:(NSString *)tableName
{
    [_dataBase open];
    NSString *sqlstr = [NSString stringWithFormat:@"DROP TABLE %@", tableName];
    if (![_dataBase executeUpdate:sqlstr])
    {
        NSLog(@"Delete table error!");
        [_dataBase close];
        return NO;
    }
    [_dataBase close];
    return YES;
}



// 判断是否存在表
- (BOOL) isTableOK:(NSString *)tableName
{
    [_dataBase open];
    FMResultSet *rs = [_dataBase executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", tableName];
    while ([rs next])
    {
        // just print out what we've got in a number of formats.
        NSInteger count = [rs intForColumn:@"count"];
        NSLog(@"isTableOK %ld", count);
        
        if (0 == count)
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }
    
    return NO;
}

// 插入数据
- (BOOL)insertDataIntoShoucang:(NSString *)sql
{
    BOOL isSuc = NO;
    [_dataBase open];
    isSuc = [_dataBase executeUpdate:sql];
    [_dataBase close];
    
    return isSuc;
}

// 修改数据
- (BOOL)updateDataInShoucang:(NSString *)sql
{
    BOOL isSuc = NO;
    [_dataBase open];
    isSuc = [_dataBase executeUpdate:sql];
    [_dataBase close];
    return isSuc;
}

// 删除数据
- (BOOL)deleteDataFromShoucang:(NSString *)sql
{
    BOOL isSuc = NO;
    [_dataBase open];
    isSuc = [_dataBase executeUpdate:sql];
    [_dataBase close];
    
    return isSuc;
}

- (BOOL)selectExistDataFromTable:(NSString *)sql{
    
    [_dataBase open];
    // 结果集接收查询结果
    FMResultSet *res = [_dataBase executeQuery:sql];
    // 无论有多少个结果都需要循环才可以遍历打印出来
    while ([res next])
    {
        int choucngID = [res intForColumnIndex:0];
        NSString *title = [res stringForColumn:@"title"];
        NSLog(@"%d - %@ ",choucngID,title);
        return YES;
    }
    [_dataBase close];
    return NO;
}

//查询所有数据
- (FMResultSet *)selectAllDataFromTable:(NSString *)sql{
    [_dataBase open];
    // 结果集接收查询结果
    FMResultSet *res = [_dataBase executeQuery:sql];
    // 无论有多少个结果都需要循环才可以遍历打印出来
    return res;
}

//增加数据库表字段
- (BOOL)insertFieldIntoTable:(NSString *)tableName fieldName:(NSString *)fieldName{
    BOOL isSuc = NO;
    [_dataBase open];
    NSString *sql = [NSString stringWithFormat:@"Alter table %@ add %@ text",tableName,fieldName];
    isSuc = [_dataBase executeUpdate:sql];
    [_dataBase close];
    return isSuc;
}

//删除表信息
- (BOOL)deleteAll:(NSString *)tableName{
    BOOL isSuc = NO;
    [_dataBase open];
    isSuc = [_dataBase executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@",tableName]];
    [_dataBase close];
    return isSuc;
}


@end
