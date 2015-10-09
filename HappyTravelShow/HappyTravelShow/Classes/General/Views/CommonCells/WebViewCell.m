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
    NSAttributedString *_attributedString;
}

@end

@implementation WebViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
        self.contentLabel.userInteractionEnabled = YES;

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapLabel:)];
        [self.contentLabel addGestureRecognizer:tap];
        self.contentLabel.numberOfLines = 0;
        [self addSubview: self.contentLabel];
        
    }
    
    return self;
}


- (void)setWebViewWithContentStr:(NSString *)contentStr{
    _attributedString = [[NSAttributedString alloc] initWithData:[contentStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    self.contentLabel.attributedText = _attributedString;
    if (isopen) {
        CGSize size = [_attributedString boundingRectWithSize:CGSizeMake(kScreenWidth, 999) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
        
        [self.contentLabel setFrame:CGRectMake(0, 0, kScreenWidth, size.height)];
    }else{
        [self.contentLabel setFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    }
}


static BOOL isopen = NO;

- (void)OnTapLabel:(id)sender{
    isopen = !isopen;
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickCell:height:isopen:)]) {
        if (isopen) {
            CGSize size = [_attributedString boundingRectWithSize:CGSizeMake(kScreenWidth, 999) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
            
            [self.contentLabel setFrame:CGRectMake(0, 0, kScreenWidth, size.height)];
//            NSLog(@"%lf------",self.contentLabel.frame.size.height);
        }else{
            [self.contentLabel setFrame:CGRectMake(0, 0, kScreenWidth, 80)];
//            NSLog(@"%lf======",self.contentLabel.frame.size.height);
        }
        
        //点击购买须知 cell indexpath.section = 4
        [self.delegate didClickCell:4 height:self.contentLabel.frame.size.height isopen:isopen];
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
