//
//  CategoryDetailsVC.h
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/9.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryDetailsVC : UITableViewController
//重写初始化方法
- (instancetype)initWithStyle:(UITableViewStyle)style AndWithSort:(NSString*)sort AndWithCitySort:(NSInteger)Citysort;
@property(nonatomic,strong)NSString*URLNumber;
@property(nonatomic,strong)NSString*sort;
@property(nonatomic,assign)NSInteger CitySort;
@property(nonatomic,strong)NSMutableArray*CityArray;
@end
