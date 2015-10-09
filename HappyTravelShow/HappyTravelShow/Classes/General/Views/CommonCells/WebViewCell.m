//
//  WebViewCell.m
//  DetailpageDemo
//
//  Created by Amazing on 15/10/7.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "WebViewCell.h"

@interface WebViewCell ()<UITextViewDelegate>
{
    UIView *_backView;
}

@end

@implementation WebViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //背景视图初始化
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
        [self.contentView addSubview:_backView];
        
        
        self.textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
        
        NSString *str = @"<div class=\"t-content-taocan\"><div class=\"bottom-height\"><h5><strong>【使用方式】</strong></h5><ul class=\"des1 descolor\"><li>取票方式： 请凭电子码至圆明园正门（南门）售票处电子票窗口兑票游玩。</li></ul></div><div class=\"bottom-height\"><h5><strong>【使用时间】</strong></h5><ul class=\"des1 descolor\"><li>1-3月、11-12月：07:00-19:30（15:30停止验票）</li><li>4月、9-10月：07:00-20:30（16:30停止验票） </li><li>5-8月：07:00-21:00（17:00停止验票）</li></ul></div><div class=\"bottom-height\"><h5><strong>【额外服务提示】</strong></h5><ul class=\"des1 descolor\"><li>景区提供收费停车，具体收费标准以停车场公告为准。</li></ul></div><div class=\"bottom-height\"><h5><strong>【预订限制】</strong></h5><ul class=\"des1 descolor\"><li>请至少提前1小时预订，周末及节假日请尽量提前预订。</li></ul></div></div>";
        
        
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[str dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        self.textView.editable = NO;
        //self.textView.backgroundColor = [UIColor blueColor];
        self.textView.attributedText = attributedString;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapWebView:)];
        [self.textView addGestureRecognizer:tap];
        
        [_backView addSubview: self.textView];
        
    }
    
    return self;
}

static BOOL isopen ;

- (void)OnTapWebView:(id)sender{
    isopen = !isopen;
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickCell:height:)]) {
        NSLog(@"%@",[NSString stringWithFormat:@"%lf",self.textView.contentSize.height]);
        if (!isopen) {
            [self.textView setFrame:CGRectMake(0, 0, kScreenWidth, self.textView.contentSize.height)];
        }else{
            [self.textView setFrame:CGRectMake(0, 0, kScreenWidth, 72)];
            
        }
        
        //点击购买须知 cell indexpath.section = 4
        [self.delegate didClickCell:4 height:self.textView.contentSize.height];
    }
}






- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
