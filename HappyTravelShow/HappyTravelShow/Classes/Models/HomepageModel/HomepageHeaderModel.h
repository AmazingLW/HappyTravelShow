//
//  HomepageHeaderModel.h
//  HappyTravelShow
//
//  Created by Amazing on 15/10/6.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomepageHeaderModel : NSObject

//轮播图and5个分类and4个标题
@property(nonatomic,strong)NSString *app_picpath,*app_url,*title,*adTitle,*adSubTitle,*n_app_picpath;
@property(nonatomic,assign) NSInteger adId;
@end
