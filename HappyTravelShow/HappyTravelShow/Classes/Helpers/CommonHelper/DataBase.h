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

//创建表
- (void)creatTableWithSQLString:(NSString *)creatSql;

//插入数据
#warning 插入的数据的表要与创建的表的名字相同
- (void)insertDataToTableWithSQLString:(NSString *)insertSql;
//删除数据
- (void)deleteDataFromTableWithSQLString:(NSString *)deleteSql;

#pragma mark -- 本工具不支持搜索请自行解决
//- (id)selectDataFromTableWithSQLString:(NSString *)selectSql;



#pragma mark ============

// 创建数据库
- (void)createDataBase;
// 创建表
- (void)createTable;
// 插入数据
- (BOOL)insertPeople:(NSString *)sql;
// 修改数据
- (BOOL)updatePeople:(NSString *)sql;
// 删除数据
- (BOOL)deletePeople:(NSString *)sql;





@end
