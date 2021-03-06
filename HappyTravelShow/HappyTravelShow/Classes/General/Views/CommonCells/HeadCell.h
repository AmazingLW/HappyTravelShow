//
//  HeadCell.h
//  DetailpageDemo
//
//  Created by Amazing on 15/10/8.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HeadCellprotocal <NSObject>

- (void)jumpPhotoVCWithPhotoArr:(NSArray *)imgviewArr index:(NSInteger)photoIndex;

@end



@interface HeadCell : UITableViewCell

//图片 scrollView
@property (nonatomic,strong) UIScrollView * imgScrollView;

//标题 label
@property (nonatomic,strong) UILabel * titleLabel;

//内容 label
@property (nonatomic,strong) UILabel * contentLabel;

//代理
@property (nonatomic,assign) id<HeadCellprotocal> delegate;

- (void)setHeadViewValue:(NSMutableArray *)imgArr title:(NSString *)title strContent:(NSString *)strContent;

@end
