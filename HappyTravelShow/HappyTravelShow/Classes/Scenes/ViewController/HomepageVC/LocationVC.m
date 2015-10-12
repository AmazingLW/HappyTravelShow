//
//  LocationVC.m
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/12.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "LocationVC.h"
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
@interface LocationVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UICollectionView*collection;
@property(nonatomic,strong)UITableView*tableView;
@end

@implementation LocationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatNavBar];
    [self steupView];
    self.view.backgroundColor =[UIColor lightGrayColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellT"];
    [_collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
}
-(void)steupView{
    
//    self.navigationBar.translucent = NO;
    self.navigationController.navigationBar.translucent =NO;
    UITextField*textFiled =[[UITextField alloc]initWithFrame:CGRectMake(10, 5, kWidth-20, 30)];
    textFiled.placeholder= @"广州/guangzhou/gz";
    textFiled.backgroundColor =[UIColor whiteColor];
    
    UILabel*Lable =[[UILabel alloc]initWithFrame:CGRectMake(0, 40, kWidth, 40)];
    Lable.text=@"GPS定位: 北京";
    Lable.backgroundColor =[UIColor whiteColor];
    
    UILabel*HotCityLable =[[UILabel alloc]initWithFrame:CGRectMake(5, 85, 50, 20)];
    HotCityLable.text=@"热门城市";
    HotCityLable.backgroundColor =[UIColor lightGrayColor];
    HotCityLable.font =[UIFont systemFontOfSize:12];
    
    
    UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize =CGSizeMake((kWidth-20)/3, 30);
    flowLayout.sectionInset =UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.minimumLineSpacing =0;
    flowLayout.minimumInteritemSpacing =0;
    self.collection =[[UICollectionView alloc]initWithFrame:CGRectMake(10, 110, kWidth-20, 90) collectionViewLayout:flowLayout];
    _collection.backgroundColor =[UIColor whiteColor];
    _collection.dataSource =self;
    _collection.delegate =self;
    _collection.backgroundColor =[UIColor lightGrayColor];
    
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 210, kWidth, kHeight-210)];
    _tableView.dataSource =self;
    _tableView.delegate =self;
    
    
    [self.view addSubview:_tableView];
    [self.view addSubview:_collection];
    [self.view addSubview:HotCityLable];
    [self.view addSubview:Lable];
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

//-----------------------collection代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 9;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
     UICollectionViewCell*cell  =[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.layer.borderWidth = 0.3;
    cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cell.backgroundColor =[UIColor whiteColor];

    return cell;
    
}
//-------------------------tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellT" forIndexPath:indexPath];
    
    cell.textLabel.text =@"cell";
    cell.backgroundColor =[UIColor whiteColor];
    return cell;

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    }



@end
