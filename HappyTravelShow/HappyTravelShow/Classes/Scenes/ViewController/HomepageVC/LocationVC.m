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

@class HomepageVC;
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
@interface LocationVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)UICollectionView*collection;
@property(nonatomic,strong)NSMutableArray*array;
@property(nonatomic,strong)NSMutableArray*CityArray;
@property(nonatomic,strong)NSMutableArray*KeyArray;
@property(nonatomic,strong)NSMutableDictionary *cityDict;
//城市标题
@property(nonatomic,strong)NSString*string,*cityName,*cityCode;

@end

@implementation LocationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatNavBar];
    [self steupView];
    self.KeyArray =[@[@"",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"J",@"K",@"L",@"M",@"N",@"P",@"Q",@"R",@"S",@"T",@"W",@"X",@"Y",@"Z"]mutableCopy];
    self.view.backgroundColor =[UIColor lightGrayColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
     [self.tableView registerClass:[GPSCell class] forCellReuseIdentifier:@"cellc"];
    
    [[HomepageHelper new] requestallCityList:@"positionCity" WithFinish:^(NSMutableArray *arr) {
        self.array =[NSMutableArray array];
        self.array = [arr mutableCopy];
        [self getCityByGroup];
        [self.tableView reloadData];
    }];
    
    
    
}
-(void)steupView{
   
    self.navigationController.navigationBar.translucent =NO;
    UITextField*textFiled =[[UITextField alloc]initWithFrame:CGRectMake(10, 5, kWidth-20, 30)];
    textFiled.placeholder= @"🔍广州/guangzhou/gz";
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

//分区个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   
    return self.KeyArray.count;
}
//每个分区row的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else{
 
    NSString *str  = self.KeyArray[section];
    NSArray *a1 = self.cityDict[str];
    return a1.count;
    }
}
//每个item
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
       GPSCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellc" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
       // cell.selected = NO;
        cell.backgroundColor =[UIColor lightGrayColor];
        cell.block =^(NSString *string,NSString *cityName,NSString *cityCode){

            self.string = string;
            self.cityName = cityName;
            self.cityCode = cityCode;
            self.block(self.string,self.cityName,self.cityCode);
            [self.navigationController popViewControllerAnimated:YES];
        };

        return cell;
        
    }else{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    NSString *str  = _KeyArray[indexPath.section];
    NSArray *a1 = self.cityDict[str];
    HomepageCityListModel *h = a1[indexPath.row];
    cell.textLabel.text = h.cityNameAbbr;
    return cell;
    
   }
}
//row的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        return 170;
    }
    return 40;
}

//分区名设置为分组数组的对应元素
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return self.KeyArray[section];
    
}

//返回右边的数组
-(NSArray*)sectionIndexTitlesForTableView:(UITableView *)tableView{

    return self.KeyArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    }
-(void)getCityByGroup
{
    for (int i=0; i<self.KeyArray.count; i++) {
          NSMutableArray *a1 = [NSMutableArray new];
        NSString *str1 = self.KeyArray[i];
        for (int j=0; j<self.array.count; j++) {
            HomepageCityListModel *h = self.array[j];
            
            NSString*a = [h.pinYinName uppercaseString];
       
            NSString *str = [a substringToIndex:1];
            if ([str isEqualToString:str1]) {
                [a1 addObject:h];
            }
            [self.cityDict setObject:a1 forKey:str1];
        }
    }
    //NSLog(@"%@",self.cityDict);
}


//cell点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section!=0) {
        
    NSString *str  = _KeyArray[indexPath.section];
    NSArray *a1 = self.cityDict[str];
    HomepageCityListModel *h = a1[indexPath.row];
    self.block(h.cityNameAbbr,h.cityName,h.cityCode);
    [self.navigationController popViewControllerAnimated:YES];
       //[self dismissModalViewControllerAnimated:NO];
    }
}

-(NSMutableDictionary *)cityDict
{

    if (_cityDict==nil  ) {
        _cityDict = [NSMutableDictionary new];
    }
    return _cityDict;

}
@end
