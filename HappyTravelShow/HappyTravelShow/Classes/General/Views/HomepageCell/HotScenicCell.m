//
//  HotScenicCell.m
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/7.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "HotScenicCell.h"
#import "HomepageHelper.h"

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
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    //普通状态下
    [button setTitle:@"热门景区" forState:UIControlStateNormal];
    //设置偏移量
    //[button setTitleShadowOffset:CGSizeMake(5, 5)];
    //高亮状态下
    //[button setTitle:@"热门景区" forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(jumpWithhot) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"hot"] forState:UIControlStateNormal];
   
    
    
    UIButton*buttonCity = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonCity.frame = CGRectMake(187.5,0,187.5, 40);
    [buttonCity setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [buttonCity setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    buttonCity.titleLabel.font = [UIFont systemFontOfSize:15];
    //普通状态下
    [buttonCity setTitle:@"周边城市" forState:UIControlStateNormal];
    //设置偏移量
    //[button setTitleShadowOffset:CGSizeMake(5, 5)];
    //高亮状态下
    //[buttonCity setTitle:@"周边城市" forState:UIControlStateHighlighted];
    [buttonCity setImage:[UIImage imageNamed:@"city"] forState:UIControlStateNormal];
    [buttonCity addTarget:self action:@selector(jumpWithCity) forControlEvents:UIControlEventTouchUpInside];
    _view =[[UIView alloc]initWithFrame:CGRectMake(0, 40, 375*2, 80)];

    
   _b1=[UIButton buttonWithType:UIButtonTypeCustom];
    _b1.frame = CGRectMake(0,0,93.75, 30);
    _b1.titleLabel.font = [UIFont systemFontOfSize:15];
    [_b1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_b1 setTitle:@"古井水镇" forState:UIControlStateNormal];
    
    _b2=[UIButton buttonWithType:UIButtonTypeCustom];
    _b2.frame = CGRectMake(93.75,0,375/4, 30);
    _b2.titleLabel.font = [UIFont systemFontOfSize:15];
    [_b2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_b2 setTitle:@"古井水镇" forState:UIControlStateNormal];
    
    _b3=[UIButton buttonWithType:UIButtonTypeCustom];
    _b3.frame = CGRectMake(375/2,0,375/4, 30);
    _b3.titleLabel.font = [UIFont systemFontOfSize:15];
    [_b3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_b3 setTitle:@"古井水镇" forState:UIControlStateNormal];
    
    _b4=[UIButton buttonWithType:UIButtonTypeCustom];
    _b4.frame = CGRectMake(93.75*3-15,0,375/3, 30);
    _b4.titleLabel.font = [UIFont systemFontOfSize:15];
    [_b4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_b4 setTitle:@"古井水镇" forState:UIControlStateNormal];
    
    _b5=[UIButton buttonWithType:UIButtonTypeCustom];
    _b5.frame = CGRectMake(0,30,375/4, 30);
    _b5.titleLabel.font = [UIFont systemFontOfSize:15];
    [_b5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_b5 setTitle:@"古井水镇" forState:UIControlStateNormal];
    
    _b6=[UIButton buttonWithType:UIButtonTypeCustom];
    _b6.frame = CGRectMake(93.75,30,375/4, 30);
    _b6.titleLabel.font = [UIFont systemFontOfSize:15];
    [_b6 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_b6 setTitle:@"古井水镇" forState:UIControlStateNormal];
    
   _b7=[UIButton buttonWithType:UIButtonTypeCustom];
    _b7.frame = CGRectMake(375/2,30,375/4, 30);
    _b7.titleLabel.font = [UIFont systemFontOfSize:15];
    [_b7 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_b7 setTitle:@"古井水镇" forState:UIControlStateNormal];
    
    _b8=[UIButton buttonWithType:UIButtonTypeCustom];
    _b8.frame = CGRectMake(93.75*3-15,30,375/3, 30);
    _b8.titleLabel.font = [UIFont systemFontOfSize:15];
    [_b8 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_b8 setTitle:@"古井水镇" forState:UIControlStateNormal];
    
   _b9=[UIButton buttonWithType:UIButtonTypeCustom];
    _b9.frame = CGRectMake(375,0,93.75, 30);
    _b9.titleLabel.font = [UIFont systemFontOfSize:15];
    [_b9 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_b9 setTitle:@"古井水镇" forState:UIControlStateNormal];
    
    _b10=[UIButton buttonWithType:UIButtonTypeCustom];
    _b10.frame = CGRectMake(93.75+375,0,375/4, 30);
    _b10.titleLabel.font = [UIFont systemFontOfSize:15];
    [_b10 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_b10 setTitle:@"古井水镇" forState:UIControlStateNormal];
    
    _b11=[UIButton buttonWithType:UIButtonTypeCustom];
    _b11.frame = CGRectMake(375/2+375,0,375/4, 30);
    _b11.titleLabel.font = [UIFont systemFontOfSize:15];
    [_b11 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_b11 setTitle:@"古井水镇" forState:UIControlStateNormal];
    
    _b12=[UIButton buttonWithType:UIButtonTypeCustom];
    _b12.frame = CGRectMake(93.75*3-15+375,0,375/3, 30);
    _b12.titleLabel.font = [UIFont systemFontOfSize:15];
    [_b12 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_b12 setTitle:@"古井水镇" forState:UIControlStateNormal];
    
    _b13=[UIButton buttonWithType:UIButtonTypeCustom];
    _b13.frame = CGRectMake(375,30,375/4, 30);
    _b13.titleLabel.font = [UIFont systemFontOfSize:15];
    [_b13 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_b13 setTitle:@"古井水镇" forState:UIControlStateNormal];
    
    _b14=[UIButton buttonWithType:UIButtonTypeCustom];
    _b14.frame = CGRectMake(93.75+375,30,375/4, 30);
    _b14.titleLabel.font = [UIFont systemFontOfSize:15];
    [_b14 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_b14 setTitle:@"古井水镇" forState:UIControlStateNormal];
    
    _b15=[UIButton buttonWithType:UIButtonTypeCustom];
    _b15.frame = CGRectMake(375/2+375,30,375/4, 30);
    _b15.titleLabel.font = [UIFont systemFontOfSize:15];
    [_b15 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_b15 setTitle:@"古井水镇" forState:UIControlStateNormal];
    
    _b16=[UIButton buttonWithType:UIButtonTypeCustom];
    _b16.frame = CGRectMake(93.75*3-15+375,30,375/3, 30);
    _b16.titleLabel.font = [UIFont systemFontOfSize:15];
    [_b16 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_b16 setTitle:@"古井" forState:UIControlStateNormal];
    
    [_view addSubview:_b1];
    [_view addSubview:_b2];
    [_view addSubview:_b3];
    [_view addSubview:_b4];
    [_view addSubview:_b5];
    [_view addSubview:_b6];
    [_view addSubview:_b7];
    [_view addSubview:_b8];
    [_view addSubview:_b9];
    [_view addSubview:_b10];
    [_view addSubview:_b11];
    [_view addSubview:_b12];
    [_view addSubview:_b13];
    [_view addSubview:_b14];
    [_view addSubview:_b15];
    [_view addSubview:_b16];
    [self addSubview:_view];
    [self  addSubview:buttonCity];
    [self  addSubview:button];
   






}

-(void)jumpWithCity{
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:0.3f];
    
    _view.frame = CGRectMake(-375, 40, 375, 80);
     [UIView commitAnimations];
}
-(void)jumpWithhot{
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:0.3f];
    
    _view.frame = CGRectMake(0, 40, 375, 80);
    [UIView commitAnimations];
}

@end
