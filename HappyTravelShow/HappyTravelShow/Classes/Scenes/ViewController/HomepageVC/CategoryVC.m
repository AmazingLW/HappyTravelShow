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
}
-(void)drawNavControllers{
//    CategoryDetailsVC*RecommendVC =[[CategoryDetailsVC alloc]initWithStyle:UITableViewStylePlain AndWithSort:@"n"];
    CategoryDetailsVC*RecommendVC =[[CategoryDetailsVC alloc]initWithStyle:UITableViewStylePlain AndWithSort:@"n" AndWithCitySort:2];
    
    RecommendVC.title =@"     推荐       ";
    //RecommendVC.view.backgroundColor =[UIColor greenColor];
    RecommendVC.URLNumber =self.urlNum;
    RecommendVC.CityArray = [self.CityArray mutableCopy];
//    CategoryDetailsVC*NewVC =[[CategoryDetailsVC alloc]initWithStyle:UITableViewStylePlain AndWithSort:@"xp"];
    CategoryDetailsVC*NewVC  =[[CategoryDetailsVC alloc]initWithStyle:UITableViewStylePlain AndWithSort:@"xp" AndWithCitySort:5];
    NewVC.title=@"     最新       ";
    //NewVC.view.backgroundColor =[UIColor cyanColor];
    NewVC.URLNumber =self.urlNum;
    NewVC.CityArray = [self.CityArray mutableCopy];
//    CategoryDetailsVC*DistanceVC =[[CategoryDetailsVC alloc]initWithStyle:UITableViewStylePlain AndWithSort:@"d"];
    CategoryDetailsVC*DistanceVC =[[CategoryDetailsVC alloc]initWithStyle:UITableViewStylePlain AndWithSort:@"d" AndWithCitySort:6];
    DistanceVC.title=@"    距离       ";
    //DistanceVC.view.backgroundColor =[UIColor yellowColor];
    DistanceVC.URLNumber =self.urlNum;
    DistanceVC.CityArray = [self.CityArray mutableCopy];
    SCNavTabBarController *navTabBarController = [[SCNavTabBarController alloc] initWithShowArrowButton:YES];
    navTabBarController.subViewControllers = @[RecommendVC,NewVC,DistanceVC];
    //    箭头
    navTabBarController.showArrowButton = NO;
    navTabBarController.scrollAnimation = YES;
    navTabBarController.navTabBarColor = [UIColor whiteColor];
    navTabBarController.navTabBarArrowImage = [UIImage imageNamed:@"arrow"];
    
    [navTabBarController addParentController:self];

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
