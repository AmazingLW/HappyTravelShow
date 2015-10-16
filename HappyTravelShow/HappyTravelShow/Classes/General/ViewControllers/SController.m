//
//  SController.m
//  popopo
//
//  Created by lanou3g on 15/10/16.
//  Copyright (c) 2015年 蓝欧科技. All rights reserved.
//

#import "SController.h"
#import "AppDelegate.h"
#import "TabBarVC.h"

@interface SController ()<UIScrollViewDelegate>

@end

@implementation SController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //存储用户的偏好设置,存储在本地,比如:程序是否是第一次加载
    [self setupFirstLanchView];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"aa"];
    //立即同步
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)setupFirstLanchView{
    [self setupScrollView];
    [self setupPageControl];
}


- (void)setupScrollView

{
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    scrollView.delegate =self;
    
    [self.view addSubview:scrollView];
    
    //关闭水平方向上的滚动条
    
    scrollView.showsHorizontalScrollIndicator =NO;
    
    //是否可以整屏滑动
    
    scrollView.pagingEnabled =YES;
    
    scrollView.tag =200;
    
    scrollView.contentSize =CGSizeMake([UIScreen mainScreen].bounds.size.width *4, [UIScreen mainScreen].bounds.size.height);
    
    for (int i = 0; i < 4; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width * i,0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        UIButton  * abutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [abutton setTitle:@"立即体验" forState:UIControlStateNormal];
        abutton.frame =CGRectMake([UIScreen mainScreen].bounds.size.width/2.0-60, self.view.bounds.size.height-120, 120, 40);
        //添加触发方法
        [abutton  addTarget:self action:@selector(abuttonTouch:) forControlEvents:UIControlEventTouchUpInside];
        //        [imageView  addSubview:abutton];
        imageView.image =[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i+1]];
        imageView.userInteractionEnabled = YES;//一定要打开交互,默认是关闭的
        if (i == 3) {
            [imageView  addSubview:abutton];
        }
        [scrollView addSubview:imageView];
        
    }
    [self.view addSubview:scrollView];
}

- (void)setupPageControl

{
    /**
     
     *  UIPageControl
     
     1.表示页数
     
     2.表示当前正处于第几页
     
     3.点击切换页数
     
     */
    
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2.0 - 150, [UIScreen mainScreen].bounds.size.height -40, 300, 20)];
    
    pageControl.tag =100;
    
    //设置表示的页数
    
    pageControl.numberOfPages =4;
    
    //设置选中的页数
    
    pageControl.currentPage =0;
    
    //设置未选中点的颜色
    
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    
    //设置选中点的颜色
    
    pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    
    //添加响应事件
    
    [pageControl addTarget:self action:@selector(handlePageControl:)forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:pageControl];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView

{
    UIPageControl *pagControl = (UIPageControl *)[self.view viewWithTag:100];
    if (scrollView.contentOffset.x == 0) {
        pagControl.currentPage = 0;
    }else{
        pagControl.currentPage = scrollView.contentOffset.x / ([UIScreen mainScreen].bounds.size.width) ;
    }
}

- (void)handlePageControl:(UIPageControl *)pageControl

{
    
    //切换pageControl .对应切换scrollView不同的界面
    
    UIScrollView *scrollView = (UIScrollView *)[self.view viewWithTag:200];
    
    //
    [scrollView setContentOffset:CGPointMake(375 * pageControl.currentPage,0)animated:YES];
    
}
-(void)abuttonTouch:(UIButton *)abutton
{
  //self.view.window.rootViewController=[rootViewController new];
    
    self.view.window.rootViewController=[TabBarVC new];
    
}

@end
