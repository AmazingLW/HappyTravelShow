//
//  CommentCell.h
//  DetailpageDemo
//
//  Created by Amazing on 15/10/8.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentCell : UITableViewCell

//销售量 label
@property (nonatomic,strong) UILabel * sellLabel;

//评价 label
@property (nonatomic,strong) UILabel * commentLabel;

- (void)setCommentCellWithSell:(NSString *)strSell strComment:(NSString *)strComment;


@end
