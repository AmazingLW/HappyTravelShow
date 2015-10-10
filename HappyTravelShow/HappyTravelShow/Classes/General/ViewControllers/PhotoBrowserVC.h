//
//  PhotoBrowserVC.h
//  HappyTravelShow
//
//  Created by Amazing on 15/10/10.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoBrowserVC : UIViewController

//图片轮播图
@property (nonatomic,strong) UIScrollView * photoScrollView;

//主标题
@property (nonatomic,strong) UILabel * mainLabel;

//副标题
@property (nonatomic,strong) UILabel * subLabel;

//浏览位置
@property (nonatomic,strong) UILabel *locationLabel;

//图片信息数组 ----主要利用副标题
@property (nonatomic,strong) NSMutableArray * photoInfoArr;

//保存图片imgview的数组，添加到scrollView
@property (nonatomic,strong) NSMutableArray * imgArr;

//主标题字符串
@property (nonatomic,strong) NSString * strMain;

//图片索引
@property (nonatomic,assign) NSInteger pageIndex;

@end
