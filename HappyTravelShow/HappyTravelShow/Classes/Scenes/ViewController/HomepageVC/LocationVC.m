//
//  LocationVC.m
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/12.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "LocationVC.h"
#import "GPSCell.h"
#import "HomepageHelper.h"
#import "HomepageCityListModel.h"
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
@interface LocationVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)UICollectionView*collection;
@property(nonatomic,strong)NSMutableArray*array;
@end

@implementation LocationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatNavBar];
    [self steupView];
    self.view.backgroundColor =[UIColor lightGrayColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
     [self.tableView registerClass:[GPSCell class] forCellReuseIdentifier:@"cellc"];
    
    [[HomepageHelper new] requestallCityList:@"positionCity" WithFinish:^(NSMutableArray *arr) {
        self.array =[NSMutableArray array];
        self.array = [arr mutableCopy];
        [self.tableView reloadData];
    }];
    
}
-(void)steupView{
   
    self.navigationController.navigationBar.translucent =NO;
    UITextField*textFiled =[[UITextField alloc]initWithFrame:CGRectMake(10, 5, kWidth-20, 30)];
    textFiled.placeholder= @"广州/guangzhou/gz";
    textFiled.backgroundColor =[UIColor whiteColor];
    
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 40, kWidth, kHeight-40)];
    _tableView.dataSource =self;
    _tableView.delegate =self;
    
    
    [self.view addSubview:_tableView];
    [self.view addSubview:textFiled];
}
- (void)creatNavBar {
    
    self.title = @"选择城市";
    
    //    self.navigationItem.leftBarButtonItem = [ControlFactory creatBBIWithTarget:self image:[UIImage imageNamed:@"home_nav_bar_back_icon"] action:@selector(backBBIClicked:)];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
}

-(void)backAction{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



//-------------------------tableView代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    return _array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
       GPSCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellc" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }else{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text =@"cell";
    cell.backgroundColor =[UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    HomepageCityListModel*a =_array[indexPath.row];
    cell.textLabel.text =a.cityNameAbbr;
    return cell;

    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        return 170;
    }
    return 50;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    }



@end
