//
//  DetailIntroduceController.m
//  DetailpageDemo
//
//  Created by Amazing on 15/10/8.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "DetailIntroduceController.h"


@interface DetailIntroduceController ()<UIWebViewDelegate>

@property (nonatomic,strong) UIWebView * webView;

@end

@implementation DetailIntroduceController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"推荐行程";
    self.navigationItem.hidesBackButton = YES;
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    

    
    //创建webview
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:_webView];
    _webView.scalesPageToFit = YES;
    [_webView loadHTMLString:self.htmlData baseURL:nil];

    
    self.view.backgroundColor = [UIColor redColor];
    
}


- (void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
    // 禁用用户选择
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    
    // 禁用长按弹出框
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
