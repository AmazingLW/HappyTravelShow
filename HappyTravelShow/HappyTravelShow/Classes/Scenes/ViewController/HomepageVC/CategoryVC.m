//
//  CategoryVC.m
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/9.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "CategoryVC.h"
#import "CategoryDetailsVC.h"
#import "SCNavTabBarController.h"
@interface CategoryVC ()

@end

@implementation CategoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawNavControllers];
    
    UIButton *leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame=CGRectMake(0, 0, 30, 30);
    [leftButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
    
    self.navigationItem.leftBarButtonItem=leftButtonItem;
}
-(void)drawNavControllers{

    
    CategoryDetailsVC*RecommendVC =[[CategoryDetailsVC alloc]initWithStyle:UITableViewStylePlain AndWithSort:@"n" AndWithCitySort:2];
    
    RecommendVC.title =@"     推荐       ";
    RecommendVC.URLNumber =self.urlNum;
    RecommendVC.CName =self.CName;
    RecommendVC.CityArray = [self.CityArray mutableCopy];
    RecommendVC.CityCode = self.CityCode;
    RecommendVC.CityName =self.CityName;

    CategoryDetailsVC*NewVC  =[[CategoryDetailsVC alloc]initWithStyle:UITableViewStylePlain AndWithSort:@"xp" AndWithCitySort:5];
    NewVC.title=@"     最新       ";
    NewVC.URLNumber =self.urlNum;
    NewVC.CName =self.CName;
    NewVC.CityArray = [self.CityArray mutableCopy];
    NewVC.CityName =self.CityName;
    NewVC.CityCode =self.CityCode;

    CategoryDetailsVC*DistanceVC =[[CategoryDetailsVC alloc]initWithStyle:UITableViewStylePlain AndWithSort:@"d" AndWithCitySort:6];
    DistanceVC.title=@"    距离       ";
    DistanceVC.URLNumber =self.urlNum;
    DistanceVC.CName =self.CName;
    DistanceVC.CityArray = [self.CityArray mutableCopy];
    DistanceVC.CityCode =self.CityCode;
    DistanceVC.CityName =self.CityName;
    SCNavTabBarController *navTabBarController = [[SCNavTabBarController alloc] initWithShowArrowButton:YES];
    navTabBarController.subViewControllers = @[RecommendVC,NewVC,DistanceVC];
    //    箭头
    navTabBarController.showArrowButton = NO;
    navTabBarController.scrollAnimation = YES;
    navTabBarController.navTabBarColor = [UIColor whiteColor];
    navTabBarController.navTabBarArrowImage = [UIImage imageNamed:@"arrow"];
    
    [navTabBarController addParentController:self];

}

- (void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
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
