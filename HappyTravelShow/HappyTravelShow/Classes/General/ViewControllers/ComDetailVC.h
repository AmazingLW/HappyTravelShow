//
//  ComDetailVC.h
//  DetailpageDemo
//
//  Created by Amazing on 15/10/7.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComDetailVC : UIViewController

@property (nonatomic,strong) UITableView * detailTableView;

//判断是不是热门景区跳转来的
@property (nonatomic,assign) BOOL isSciencePage;
//预定 id
@property (nonatomic,assign) NSInteger bookID;

//详情 id
@property (nonatomic,assign) NSInteger detailID;

@end
