//
//  HotScenicCell.m
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/7.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "HotScenicCell.h"

@implementation HotScenicCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addAllViews];
    }
    return self;
}

-(void)addAllViews
{
    UIButton*button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0,0,187.5, 40);
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    //普通状态下
    [button setTitle:@"热门景区" forState:UIControlStateNormal];
    //设置偏移量
    //[button setTitleShadowOffset:CGSizeMake(5, 5)];
    //高亮状态下
    //[button setTitle:@"热门景区" forState:UIControlStateHighlighted];
    [button setImage:[UIImage imageNamed:@"hot"] forState:UIControlStateNormal];
   
    
    
    UIButton*buttonCity = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonCity.frame = CGRectMake(187.5,0,187.5, 40);
    [buttonCity setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    buttonCity.titleLabel.font = [UIFont systemFontOfSize:15];
    //普通状态下
    [buttonCity setTitle:@"周边城市" forState:UIControlStateNormal];
    //设置偏移量
    //[button setTitleShadowOffset:CGSizeMake(5, 5)];
    //高亮状态下
    //[buttonCity setTitle:@"周边城市" forState:UIControlStateHighlighted];
    [buttonCity setImage:[UIImage imageNamed:@"city"] forState:UIControlStateNormal];
    [buttonCity addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    _view =[[UIView alloc]initWithFrame:CGRectMake(0, 40, 375*2, 80)];

    
    UIButton*b1=[UIButton buttonWithType:UIButtonTypeCustom];
    b1.frame = CGRectMake(0,0,93.75, 30);
    b1.titleLabel.font = [UIFont systemFontOfSize:15];
    [b1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [b1 setTitle:@"古井水镇" forState:UIControlStateNormal];
    
    UIButton*b2=[UIButton buttonWithType:UIButtonTypeCustom];
    b2.frame = CGRectMake(93.75,0,375/4, 30);
    b2.titleLabel.font = [UIFont systemFontOfSize:15];
    [b2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [b2 setTitle:@"古井水镇" forState:UIControlStateNormal];
    
    UIButton*b3=[UIButton buttonWithType:UIButtonTypeCustom];
    b3.frame = CGRectMake(375/2,0,375/4, 30);
    b3.titleLabel.font = [UIFont systemFontOfSize:15];
    [b3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [b3 setTitle:@"古井水镇" forState:UIControlStateNormal];
    
    UIButton*b4=[UIButton buttonWithType:UIButtonTypeCustom];
    b4.frame = CGRectMake(93.75*3-15,0,375/3, 30);
    b4.titleLabel.font = [UIFont systemFontOfSize:15];
    [b4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [b4 setTitle:@"古井水镇" forState:UIControlStateNormal];
    
    UIButton*b5=[UIButton buttonWithType:UIButtonTypeCustom];
    b5.frame = CGRectMake(0,30,375/4, 30);
    b5.titleLabel.font = [UIFont systemFontOfSize:15];
    [b5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [b5 setTitle:@"古井水镇" forState:UIControlStateNormal];
    
    UIButton*b6=[UIButton buttonWithType:UIButtonTypeCustom];
    b6.frame = CGRectMake(93.75,30,375/4, 30);
    b6.titleLabel.font = [UIFont systemFontOfSize:15];
    [b6 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [b6 setTitle:@"古井水镇" forState:UIControlStateNormal];
    
    UIButton*b7=[UIButton buttonWithType:UIButtonTypeCustom];
    b7.frame = CGRectMake(375/2,30,375/4, 30);
    b7.titleLabel.font = [UIFont systemFontOfSize:15];
    [b7 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [b7 setTitle:@"古井水镇" forState:UIControlStateNormal];
    
    UIButton*b8=[UIButton buttonWithType:UIButtonTypeCustom];
    b8.frame = CGRectMake(93.75*3-15,30,375/3, 30);
    b8.titleLabel.font = [UIFont systemFontOfSize:15];
    [b8 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [b8 setTitle:@"古井水镇" forState:UIControlStateNormal];
    
    UIButton*b9=[UIButton buttonWithType:UIButtonTypeCustom];
    b9.frame = CGRectMake(375,0,93.75, 30);
    b9.titleLabel.font = [UIFont systemFontOfSize:15];
    [b9 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [b9 setTitle:@"古井水镇" forState:UIControlStateNormal];
    
    UIButton*b10=[UIButton buttonWithType:UIButtonTypeCustom];
    b10.frame = CGRectMake(93.75+375,0,375/4, 30);
    b10.titleLabel.font = [UIFont systemFontOfSize:15];
    [b10 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [b10 setTitle:@"古井水镇" forState:UIControlStateNormal];
    
    UIButton*b11=[UIButton buttonWithType:UIButtonTypeCustom];
    b11.frame = CGRectMake(375/2+375,0,375/4, 30);
    b11.titleLabel.font = [UIFont systemFontOfSize:15];
    [b11 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [b11 setTitle:@"古井水镇" forState:UIControlStateNormal];
    
    UIButton*b12=[UIButton buttonWithType:UIButtonTypeCustom];
    b12.frame = CGRectMake(93.75*3-15+375,0,375/3, 30);
    b12.titleLabel.font = [UIFont systemFontOfSize:15];
    [b12 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [b12 setTitle:@"古井水镇" forState:UIControlStateNormal];
    
    UIButton*b13=[UIButton buttonWithType:UIButtonTypeCustom];
    b13.frame = CGRectMake(375,30,375/4, 30);
    b13.titleLabel.font = [UIFont systemFontOfSize:15];
    [b13 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [b13 setTitle:@"古井水镇" forState:UIControlStateNormal];
    
    UIButton*b14=[UIButton buttonWithType:UIButtonTypeCustom];
    b14.frame = CGRectMake(93.75+375,30,375/4, 30);
    b14.titleLabel.font = [UIFont systemFontOfSize:15];
    [b14 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [b14 setTitle:@"古井水镇" forState:UIControlStateNormal];
    
    UIButton*b15=[UIButton buttonWithType:UIButtonTypeCustom];
    b15.frame = CGRectMake(375/2+375,30,375/4, 30);
    b15.titleLabel.font = [UIFont systemFontOfSize:15];
    [b15 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [b15 setTitle:@"古井水镇" forState:UIControlStateNormal];
    
    UIButton*b16=[UIButton buttonWithType:UIButtonTypeCustom];
    b16.frame = CGRectMake(93.75*3-15+375,30,375/3, 30);
    b16.titleLabel.font = [UIFont systemFontOfSize:15];
    [b16 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [b16 setTitle:@"古井" forState:UIControlStateNormal];
   

    
    [_view addSubview:b1];
    [_view addSubview:b2];
    [_view addSubview:b3];
    [_view addSubview:b4];
    [_view addSubview:b5];
    [_view addSubview:b6];
    [_view addSubview:b7];
    [_view addSubview:b8];
    [_view addSubview:b9];
    [_view addSubview:b10];
    [_view addSubview:b11];
    [_view addSubview:b12];
    [_view addSubview:b13];
    [_view addSubview:b14];
    [_view addSubview:b15];
    [_view addSubview:b16];
    [self addSubview:_view];
    [self  addSubview:buttonCity];
    [self  addSubview:button];
   






}

-(void)test{
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:0.3f];
    
    _view.frame = CGRectMake(-375, 40, 375, 80);
     [UIView commitAnimations];
}

@end
