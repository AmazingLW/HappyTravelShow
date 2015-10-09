//
//  WebViewCell.h
//  DetailpageDemo
//
//  Created by Amazing on 15/10/7.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol webViewDelegate <NSObject>

@optional

//参数是 点的是哪个分区的row ，cell内容的实际高度
- (void)didClickCell:(NSInteger)index height:(CGFloat)height isopen:(bool)isopen;

@end



@interface WebViewCell : UITableViewCell

@property (nonatomic,strong) UIWebView * webView;

@property (nonatomic,strong) UITextView *textView;

@property (nonatomic,strong) UILabel *contentLabel;

@property (nonatomic,assign) id<webViewDelegate> delegate;


- (void)setWebViewWithContentStr:(NSString *)contentStr;



@end
