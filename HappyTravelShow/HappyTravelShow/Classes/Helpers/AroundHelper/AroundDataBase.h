//
//  AroundDataBase.h
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/13.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "DataBase.h"
#import "HomepageCityListModel.h"

@interface AroundDataBase : DataBase

- (HomepageCityListModel *)selectDataFromTableWithSQLString:(NSString *)selectSql;



@end
