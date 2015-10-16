//
//  CarouselWebViewVC.m
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/8.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "CarouselWebViewVC.h"

@interface CarouselWebViewVC ()<UIWebViewDelegate>
@property(nonatomic, strong) UIWebView *webView;
@end

@implementation CarouselWebViewVC


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    if (self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        
        UIButton *leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
        leftButton.frame=CGRectMake(0, 0, 30, 30);
        [leftButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *leftButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton];
        
        
        self.navigationItem.leftBarButtonItem=leftButtonItem;

        
        
    }
    return self;
    
    
}

- (void)backAction{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    
}





- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self webView];
    
    self.title = self.titleW;
    
}

- (UIWebView *)webView
{
    if (!_webView) {
        
        NSString *urlStr = _url;
        
        self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        self.webView.delegate = self;
        self.webView.backgroundColor = [UIColor redColor];
        [self.view addSubview:_webView];
        
        NSURL *url=[NSURL URLWithString:urlStr];
        NSURLRequest *request=[[NSURLRequest alloc] initWithURL:url];
        [self.webView loadRequest:request];
    }
    return _webView;
    
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
