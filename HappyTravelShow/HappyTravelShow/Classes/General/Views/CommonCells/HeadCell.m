//
//  HeadCell.m
//  DetailpageDemo
//
//  Created by Amazing on 15/10/8.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "HeadCell.h"
#import "UIImageView+WebCache.h"
#import "DetailModel.h"


@interface HeadCell (){
    UIView *backView;
    UIView *backImgView; //保存图片的轮播图背景
}

@end


@implementation HeadCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 210)];
        [self addSubview:backView];
        
        //图片
        backImgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 120)];
        [backView addSubview:backImgView];
        
        //标题
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 130, 200, 20)];
        //self.titleLabel.text = @"中行博悦酒店背景自由行";
        [backView addSubview:self.titleLabel];
        
        //内容
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 160, kScreenWidth, 40)];
        self.contentLabel.numberOfLines = 3;
        self.contentLabel.font = [UIFont systemFontOfSize:15];
        //self.contentLabel.text = @"【国庆回原价】住宿2晚 +双早/天 + 国家大剧院/水立方水电费水电费";
        [backView addSubview:self.contentLabel];
        
    }
    return self;
}


- (void)setHeadViewValue:(NSMutableArray *)imgArr title:(NSString *)title strContent:(NSString *)strContent{
    
    //初始化 scrollview
    
    _imgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 120)];
    [backImgView addSubview:_imgScrollView];
    
    //设置contantSize
    _imgScrollView.contentSize = CGSizeMake(imgArr.count * kScreenWidth, 120);
    //是否反弹
    _imgScrollView.bounces = NO;
    //控制滚动条是否显示z
    _imgScrollView.showsVerticalScrollIndicator = NO;
    //控制滚动条是否显示
    _imgScrollView.showsHorizontalScrollIndicator = NO;
    //是否整页滑动
    _imgScrollView.pagingEnabled = YES;
    
    for (int i = 0; i < imgArr.count; i++) {
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth*(i), 0, kScreenWidth, 120)];
        DetailModel *model = imgArr[i];
        [imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://cdn1.jinxidao.com/%@",model.url]]];
        [_imgScrollView addSubview:imgView];
    }
    
    //title
    self.titleLabel.text = title;
    //内容
    self.contentLabel.text = strContent;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
