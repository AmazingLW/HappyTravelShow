//
//  FinderMainModel.h
//  HappyTravelShow
//
//  Created by Amazing on 15/10/6.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FinderMainModel : NSObject
//标题
@property(nonatomic,strong) NSString  *title;
//子标题
@property(nonatomic,strong) NSString  *subTitle;
//区域
@property(nonatomic,strong) NSString  *districtName;
//图片链接
@property(nonatomic,strong) NSString  *imageUrl;
//描述
@property(nonatomic,strong) NSString  *numDescription;
//id
@property(nonatomic,strong) NSString  *themeId;


@end
