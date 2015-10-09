//
//  BookModel.h
//  DetailpageDemo
//
//  Created by Amazing on 15/10/7.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookModel : NSObject

//productPackageId
@property (nonatomic,strong) NSString * productPackageId;

//imageUrl
@property (nonatomic,strong) NSString * imageUrl;

//mainItemId
@property (nonatomic,strong) NSString * mainItemId;

//seriesCount
@property (nonatomic,strong) NSString * seriesCount;

//packageName
@property (nonatomic,strong) NSString * packageName;

//miniPrice
@property (nonatomic,strong) NSString * miniPrice;

//retailPrice
@property (nonatomic,strong) NSString * retailPrice;

//outerDescription
@property (nonatomic,strong) NSString * outerDescription;

//packageType
@property (nonatomic,strong) NSString * packageType;

//isCanBook
@property (nonatomic,assign) BOOL isCanBook;

//name
@property (nonatomic,strong) NSString * name;

//icon
@property (nonatomic,strong) NSString * icon;

//isShowInList
@property (nonatomic,assign) BOOL isShowInList;

//小图标数组
@property (nonatomic,strong) NSMutableArray * serviceFacilitiesArr;

















@end
