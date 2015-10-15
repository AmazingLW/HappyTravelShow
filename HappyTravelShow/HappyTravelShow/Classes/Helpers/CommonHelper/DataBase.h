//
//  DataBase.h
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/13.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface DataBase : NSObject

@property (nonatomic, strong)FMDatabase *dataBase;

+ (instancetype)shareData;

#pragma mark ============

// 创建数据库
- (void)createDataBase;
// 创建表
- (void)createTable;
// 插入数据
- (BOOL)insertDataIntoTable:(NSString *)sql;
// 修改数据
- (BOOL)updateDataInShoucang:(NSString *)sql;
// 删除数据
- (BOOL)deleteDataFromShoucang:(NSString *)sql;
// 查询 数据表是否有该数据
- (BOOL)selectExistDataFromTable:(NSString *)sql;
// 查询 所有数据
- (FMResultSet *)selectAllDataFromTable:(NSString *)sql;
//增加数据库表字段
- (BOOL)insertFieldIntoTable:(NSString *)tableName fieldName:(NSString *)fieldName;

// 删除表-彻底删除表
- (BOOL) deleteTable:(NSString *)tableName;

// 判断是否存在表
- (BOOL) isTableOK:(NSString *)tableName;

// 删除表信息
- (BOOL) deleteAll:(NSString *)tableName;

//获取表中有多少数据
- (NSInteger)selectDataCountWithTableName:(NSString *)tableName;

//删除id最小的
- (void)deleteMinIDInHistory;


@end
