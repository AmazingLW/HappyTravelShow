//
//  CommentCell.m
//  DetailpageDemo
//
//  Created by Amazing on 15/10/8.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "CommentCell.h"



@implementation CommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //销售量
        self.sellLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 80, 30)];
        self.sellLabel.text = @"已售6550";
        self.sellLabel.textColor = [UIColor grayColor];
        [self addSubview:self.sellLabel];
        
        //评价
        self.commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 110, 5, 80, 30)];
        self.commentLabel.textColor = [UIColor grayColor];
        self.commentLabel.text = @"155人评价";
        [self addSubview:self.commentLabel];
        
    }
    return self;
}

- (void)setCommentCellWithSell:(NSString *)strSell strComment:(NSString *)strComment{
    self.sellLabel.text = [NSString stringWithFormat:@"已售%@",strSell];
    self.commentLabel.text = [NSString stringWithFormat:@"%@人评价",strComment];
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
