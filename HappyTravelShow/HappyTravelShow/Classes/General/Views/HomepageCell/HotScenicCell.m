//
//  HotScenicCell.m
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/7.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "HotScenicCell.h"
#import "HomepageHelper.h"
#import "CategoryVC.h"
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kButtonWidth [UIScreen mainScreen].bounds.size.width/4
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
    self.contentView.backgroundColor =[UIColor whiteColor];
    self.backgroundColor =[UIColor whiteColor];
    self.Button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.Button.frame = CGRectMake(0,0,kWidth/2, 40);
    [self.Button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.Button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    self.Button.titleLabel.font = [UIFont systemFontOfSize:15];
    //普通状态下
    [self.Button setTitle:@"热门景区" forState:UIControlStateNormal];
    //设置偏移量
    //[button setTitleShadowOffset:CGSizeMake(5, 5)];
    //高亮状态下
    //[button setTitle:@"热门景区" forState:UIControlStateHighlighted];
    [self.Button addTarget:self action:@selector(jumpWithhot) forControlEvents:UIControlEventTouchUpInside];
    [self.Button setImage:[UIImage imageNamed:@"hot"] forState:UIControlStateNormal];
   
    
    
    self.buttonCity = [UIButton buttonWithType:UIButtonTypeCustom];
    self.buttonCity.frame = CGRectMake(kWidth/2,0,kWidth/2, 40);
    [self.buttonCity setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.buttonCity setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    self.buttonCity.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.buttonCity setTitle:@"周边城市" forState:UIControlStateNormal];
    [self.buttonCity setImage:[UIImage imageNamed:@"city"] forState:UIControlStateNormal];
    [self.buttonCity addTarget:self action:@selector(jumpWithCity) forControlEvents:UIControlEventTouchUpInside];
    
    _view =[[UIView alloc]initWithFrame:CGRectMake(0, 40, kWidth*2, 60)];
    self.view.userInteractionEnabled = YES;
    
   _b1=[UIButton buttonWithType:UIButtonTypeCustom];            
    _b1.frame = CGRectMake(0,0,kButtonWidth, 30);
    _b1.titleLabel.font = [UIFont systemFontOfSize:15];
    [_b1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //[_b1 setTitle:@"古井水镇" forState:UIControlStateNormal];
    
    _b2=[UIButton buttonWithType:UIButtonTypeCustom];
    _b2.frame = CGRectMake(kButtonWidth,0,kButtonWidth, 30);
    _b2.titleLabel.font = [UIFont systemFontOfSize:15];
    [_b2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
   // [_b2 setTitle:@"古井水镇" forState:UIControlStateNormal];
    
    _b3=[UIButton buttonWithType:UIButtonTypeCustom];
    _b3.frame = CGRectMake(kWidth/2,0,kButtonWidth, 30);
    _b3.titleLabel.font = [UIFont systemFontOfSize:15];
    [_b3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //[_b3 setTitle:@"古井水镇" forState:UIControlStateNormal];
    
    _b4=[UIButton buttonWithType:UIButtonTypeCustom];
    _b4.frame = CGRectMake(kButtonWidth*3,0,kButtonWidth, 30);
    _b4.titleLabel.font = [UIFont systemFontOfSize:15];
    [_b4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //[_b4 setTitle:@"古井水镇" forState:UIControlStateNormal];
    
    _b5=[UIButton buttonWithType:UIButtonTypeCustom];
    _b5.frame = CGRectMake(0,30,kButtonWidth, 30);
    _b5.titleLabel.font = [UIFont systemFontOfSize:15];
    [_b5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //[_b5 setTitle:@"古井水镇" forState:UIControlStateNormal];
    
    _b6=[UIButton buttonWithType:UIButtonTypeCustom];
    _b6.frame = CGRectMake(kButtonWidth,30,kButtonWidth, 30);
    _b6.titleLabel.font = [UIFont systemFontOfSize:15];
    [_b6 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //[_b6 setTitle:@"古井水镇" forState:UIControlStateNormal];
    
   _b7=[UIButton buttonWithType:UIButtonTypeCustom];
    _b7.frame = CGRectMake(kWidth/2,30,kButtonWidth, 30);
    _b7.titleLabel.font = [UIFont systemFontOfSize:15];
    [_b7 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //[_b7 setTitle:@"古井水镇" forState:UIControlStateNormal];
    
    _b8=[UIButton buttonWithType:UIButtonTypeCustom];
    _b8.frame = CGRectMake(kButtonWidth*3,30,kButtonWidth, 30);
    _b8.titleLabel.font = [UIFont systemFontOfSize:15];
    [_b8 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //[_b8 setTitle:@"古井水镇" forState:UIControlStateNormal];
    
   _b9=[UIButton buttonWithType:UIButtonTypeCustom];
    _b9.frame = CGRectMake(kWidth,0,kButtonWidth, 30);
    _b9.titleLabel.font = [UIFont systemFontOfSize:15];
    [_b9 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //[_b9 setTitle:@"古井水镇" forState:UIControlStateNormal];
    [_b9 setTitle:@"" forState:UIControlStateHighlighted];
    
    _b10=[UIButton buttonWithType:UIButtonTypeCustom];
    _b10.frame = CGRectMake(kButtonWidth+kWidth,0,kButtonWidth, 30);
    _b10.titleLabel.font = [UIFont systemFontOfSize:15];
    [_b10 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //[_b10 setTitle:@"古井水镇" forState:UIControlStateNormal];
    
    _b11=[UIButton buttonWithType:UIButtonTypeCustom];
    _b11.frame = CGRectMake(kWidth/2+kWidth,0,kButtonWidth, 30);
    _b11.titleLabel.font = [UIFont systemFontOfSize:15];
    [_b11 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //[_b11 setTitle:@"古井水镇" forState:UIControlStateNormal];
    
    _b12=[UIButton buttonWithType:UIButtonTypeCustom];
    _b12.frame = CGRectMake(kButtonWidth*3+kWidth,0,kButtonWidth, 30);
    _b12.titleLabel.font = [UIFont systemFontOfSize:15];
    [_b12 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //[_b12 setTitle:@"古井水镇" forState:UIControlStateNormal];
    
    _b13=[UIButton buttonWithType:UIButtonTypeCustom];
    _b13.frame = CGRectMake(kWidth,30,kButtonWidth, 30);
    _b13.titleLabel.font = [UIFont systemFontOfSize:15];
    [_b13 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //[_b13 setTitle:@"古井水镇" forState:UIControlStateNormal];
    
    _b14=[UIButton buttonWithType:UIButtonTypeCustom];
    _b14.frame = CGRectMake(kButtonWidth+kWidth,30,kButtonWidth, 30);
    _b14.titleLabel.font = [UIFont systemFontOfSize:15];
    [_b14 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //[_b14 setTitle:@"古井水镇" forState:UIControlStateNormal];
    
    _b15=[UIButton buttonWithType:UIButtonTypeCustom];
    _b15.frame = CGRectMake(kWidth/2+kWidth,30,kButtonWidth, 30);
    _b15.titleLabel.font = [UIFont systemFontOfSize:15];
    [_b15 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //[_b15 setTitle:@"古井水镇" forState:UIControlStateNormal];
    
    _b16=[UIButton buttonWithType:UIButtonTypeCustom];
    _b16.frame = CGRectMake(kButtonWidth*3+kWidth,30,kButtonWidth, 30);
    _b16.titleLabel.font = [UIFont systemFontOfSize:15];
    [_b16 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //[_b16 setTitle:@"古井" forState:UIControlStateNormal];
    

    [_b9 addTarget:self action:@selector(jumpWithDetailsB9) forControlEvents:UIControlEventTouchUpInside];
    [_b10 addTarget:self action:@selector(jumpWithDetailsB10) forControlEvents:UIControlEventTouchUpInside];
    [_b11 addTarget:self action:@selector(jumpWithDetailsB11) forControlEvents:UIControlEventTouchUpInside];
    [_b12 addTarget:self action:@selector(jumpWithDetailsB12) forControlEvents:UIControlEventTouchUpInside];
    [_b13 addTarget:self action:@selector(jumpWithDetailsB13) forControlEvents:UIControlEventTouchUpInside];
    [_b14 addTarget:self action:@selector(jumpWithDetailsB14) forControlEvents:UIControlEventTouchUpInside];
    [_b15 addTarget:self action:@selector(jumpWithDetailsB15) forControlEvents:UIControlEventTouchUpInside];
    [_b16 addTarget:self action:@selector(jumpWithDetailsB16) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_b1 addTarget:self action:@selector(jumpWithDetailsB1) forControlEvents:UIControlEventTouchUpInside];
    [_b2 addTarget:self action:@selector(jumpWithDetailsB2) forControlEvents:UIControlEventTouchUpInside];
    [_b3 addTarget:self action:@selector(jumpWithDetailsB3) forControlEvents:UIControlEventTouchUpInside];
    [_b4 addTarget:self action:@selector(jumpWithDetailsB4) forControlEvents:UIControlEventTouchUpInside];
    [_b5 addTarget:self action:@selector(jumpWithDetailsB5) forControlEvents:UIControlEventTouchUpInside];
    [_b6 addTarget:self action:@selector(jumpWithDetailsB6) forControlEvents:UIControlEventTouchUpInside];
    [_b8 addTarget:self action:@selector(jumpWithDetailsB7) forControlEvents:UIControlEventTouchUpInside];
    [_b7 addTarget:self action:@selector(jumpWithDetailsB8) forControlEvents:UIControlEventTouchUpInside];
    
//    cell.layer.borderWidth = 0.3;
//    cell.layer.borderColor = [UIColor lightGrayColor].CGColor;

    [_b1.layer setBorderWidth:0.3f];
    [_b1.layer setBorderColor:[[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1] CGColor]];
    [_b2.layer setBorderWidth:0.3f];
    [_b2.layer setBorderColor:[[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1] CGColor]];
    [_b3.layer setBorderWidth:0.3f];
    [_b3.layer setBorderColor:[[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1] CGColor]];
    [_b4.layer setBorderWidth:0.3f];
    [_b4.layer setBorderColor:[[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1] CGColor]];
    [_b5.layer setBorderWidth:0.3f];
    [_b5.layer setBorderColor:[[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1] CGColor]];
    [_b6.layer setBorderWidth:0.3f];
    [_b6.layer setBorderColor:[[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1] CGColor]];
    [_b7.layer setBorderWidth:0.3f];
    [_b7.layer setBorderColor:[[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1] CGColor]];
    [_b8.layer setBorderWidth:0.3f];
    [_b8.layer setBorderColor:[[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1] CGColor]];
    [_b9.layer setBorderWidth:0.3f];
    [_b9.layer setBorderColor:[[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1] CGColor]];
    [_b11.layer setBorderWidth:0.3f];
    [_b11.layer setBorderColor:[[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1] CGColor]];
    [_b12.layer setBorderWidth:0.3f];
    [_b12.layer setBorderColor:[[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1] CGColor]];
    [_b13.layer setBorderWidth:0.3f];
    [_b13.layer setBorderColor:[[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1] CGColor]];
    [_b14.layer setBorderWidth:0.3f];
    [_b14.layer setBorderColor:[[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1] CGColor]];
    [_b15.layer setBorderWidth:0.3f];
    [_b15.layer setBorderColor:[[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1] CGColor]];
    [_b16.layer setBorderWidth:0.3f];
    [_b16.layer setBorderColor:[[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1] CGColor]];
    [_b10.layer setBorderWidth:0.3f];
    [_b10.layer setBorderColor:[[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1] CGColor]];
    
    
    self.OrangView = [[UIView alloc]initWithFrame:CGRectMake(kWidth/8, 39,kWidth/4, 2)];
    self.OrangView.backgroundColor =[UIColor orangeColor];

    [self.Button addSubview:_OrangView];
    UIView*LView =[[UIView alloc]initWithFrame:CGRectMake( kWidth/2,10, 0.3, 20)];
    LView.backgroundColor =[UIColor grayColor];
    [self.contentView addSubview:LView];
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
    
    [self.contentView addSubview:_view];
 
    [self.contentView  addSubview:self.buttonCity];
    [self.contentView  addSubview:self.Button];
    self.contentView.userInteractionEnabled = YES;



}

-(void)jumpWithCity{
    
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:0.3f];
    
    _OrangView.frame = CGRectMake(kWidth/2+kWidth/8, 39,kWidth/4, 2);
    _view.frame = CGRectMake(-kWidth, 40, kWidth * 2, 60);
    self.view.userInteractionEnabled = YES;
    
     [UIView commitAnimations];
    [self.Button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.buttonCity setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
}
-(void)jumpWithhot{
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:0.3f];
       self.view.userInteractionEnabled = YES;
    _view.frame = CGRectMake(0, 40, kWidth * 2, 60);
    _OrangView.frame = CGRectMake(kWidth/8, 39,kWidth/4, 2);
    [UIView commitAnimations];
    [self.buttonCity setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.Button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
}


-(void)jumpWithDetailsB9{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(getDetailControllerB9)]) {
        [self.delegate getDetailControllerB9];
    }
  
    
}
-(void)jumpWithDetailsB10{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(getDetailControllerB10)]) {
        [self.delegate getDetailControllerB10];
    }

}
-(void)jumpWithDetailsB11{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(getDetailControllerB11)]) {
        [self.delegate getDetailControllerB11];
    }
}
-(void)jumpWithDetailsB12{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(getDetailControllerB12)]) {
        [self.delegate getDetailControllerB12];
    }
}
-(void)jumpWithDetailsB13{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(getDetailControllerB13)]) {
        [self.delegate getDetailControllerB13];
    }
}
-(void)jumpWithDetailsB14{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(getDetailControllerB14)]) {
        [self.delegate getDetailControllerB14];
    }
}
-(void)jumpWithDetailsB15{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(getDetailControllerB15)]) {
        [self.delegate getDetailControllerB15];
    }
}
-(void)jumpWithDetailsB16{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(getDetailControllerB16)]) {
        [self.delegate getDetailControllerB16];
    }
}

-(void)jumpWithDetailsB1{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(getDetailControllerB1)]) {
        [self.delegate getDetailControllerB1];
    }
    
}
-(void)jumpWithDetailsB2{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(getDetailControllerB2)]) {
        [self.delegate getDetailControllerB2];
    }
    
}-(void)jumpWithDetailsB3{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(getDetailControllerB3)]) {
        [self.delegate getDetailControllerB3];
    }
    
}-(void)jumpWithDetailsB4{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(getDetailControllerB4)]) {
        [self.delegate getDetailControllerB4];
    }
    
}-(void)jumpWithDetailsB5{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(getDetailControllerB5)]) {
        [self.delegate getDetailControllerB5];
    }
    
}-(void)jumpWithDetailsB6{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(getDetailControllerB6)]) {
        [self.delegate getDetailControllerB6];
    }
    
}-(void)jumpWithDetailsB7{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(getDetailControllerB7)]) {
        [self.delegate getDetailControllerB7];
    }
    
}-(void)jumpWithDetailsB8{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(getDetailControllerB8)]) {
        [self.delegate getDetailControllerB8];
    }
    
}
@end
