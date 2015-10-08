//
//  AroundVC.m
//  HappyTravelShow
//
//  Created by Amazing on 15/10/6.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "AroundVC.h"
#import "XIOptionSelectorView.h"
#import "XIOptionView.h"
#import "XIOtherOptionsView.h"
#import "XIColorHelper.h"
#import "AroundHelper.h"
#import "AroundMainModel.h"
#import "FinderKindModel.h"
@interface AroundVC ()<XIDropdownlistViewProtocol,UITableViewDelegate,UITableViewDataSource>
{
     XIOptionSelectorView *ddltView;
    
}
@property (nonatomic, strong)UITableView *tableView;
//目的城市数组
@property (nonatomic, strong)NSMutableArray *destinationCity;
@property (nonatomic, strong) NSMutableArray *tmpArray;

//景点名列表
@property (nonatomic, strong)NSMutableArray *scenicArray;
@property (nonatomic, strong) NSMutableArray *tmpArray1;

//全部景点
@property (nonatomic, strong)NSMutableArray *allScenic;

//请求数据需要的cityName

@property (nonatomic, strong)NSString *cityName;

//请求数据需要的scenicName

@property (nonatomic, strong)NSString *scenicName;

@end

@implementation AroundVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIImage *image = [UIImage imageNamed:@"around"];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"周边" image:image tag:1002];
    }
    
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
 //tableview 创建
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    


 
    
    [self setupDropdownList];
     [self requestData];
    
}

//数据请求
- (void)requestData{
    // CityName 应该是定位的
    [[AroundHelper new] requestWithCityName:@"北京" finish:^(NSArray *array) {
        NSMutableArray *arr = [NSMutableArray arrayWithArray:array];
        _destinationCity = [NSMutableArray array];
        _scenicArray = [NSMutableArray array];
        for (AroundMainModel *model in arr) {
            //目的城市
            [_destinationCity addObject:model.city];
            //scenics 数组 取出里面的小字典的值
            NSArray * array = model.scenics;
            for (NSDictionary *scenics in array) {
                NSString *scenicName = scenics[@"scenic"];
            [_scenicArray addObject:scenicName];
            }
            }
        
        //调用方法
        [self setupDropdownList];
       // [_tableView reloadData];
    }];
    //CityName 是请求到的目的城市
    [[AroundHelper new]requsetAllScenicsWithCityName:@"北京" finish:^(NSArray *scenic) {
        
        _allScenic = [NSMutableArray arrayWithArray:scenic];
        
        
        [self.tableView reloadData];
        
    }];
    
    

    
}

#pragma mark ---tableview 代理事件
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return _allScenic.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *const reuse = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    }
    cell.textLabel.text = @"sdgswh";
    return cell;
}

#pragma mark --顶部4个按钮的创建
- (void)setupDropdownList
{
    
    
    ddltView = [[XIOptionSelectorView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 40)];
    ddltView.parentView = self.view;
    ddltView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:ddltView];
    
    __weak typeof(self) weakSelf = self;
    [ddltView setViewAtIndex:^UIView<XIDropdownlistViewProtocol> *(NSInteger index, XIOptionSelectorView*opView) {
        
        XIOptionSelectorView *strongOpSelectorRef = opView;
        UIView<XIDropdownlistViewProtocol> *aView;
        CGFloat py = strongOpSelectorRef.frame.size.height+strongOpSelectorRef.frame.origin.y;
        CGFloat dpW = weakSelf.view.frame.size.width;
        
        if(index == 0){
            
            aView = [[XIOptionView alloc] initWithFrame:CGRectMake(0, py, dpW, 240)];
            aView.backgroundColor = [UIColor whiteColor];
            aView.delegate = weakSelf;
            aView.viewIndex = index;
           
            NSArray *tmpArray = @[@"默认排序", @"价格由低至高", @"价格由高至低",@"销量优先",@"新品优先",@"离我最近"];
            [aView setFetchDataSource:^NSArray *{
                return tmpArray;
            }];
        }else if (index == 1){
            //Hight 根据数组的个数 * 40
            //可以添加判断如果数组个数少于6个 返回高度240
            aView = [[XIOptionView alloc] initWithFrame:CGRectMake(0, py, dpW, (weakSelf.destinationCity.count + 1 )* 40)];
            aView.backgroundColor = [UIColor whiteColor];
            aView.delegate = weakSelf;
            aView.viewIndex = index;
            //第二个数组的个数是根据数据请求来得
          weakSelf.tmpArray = [NSMutableArray arrayWithObjects:@"全部", nil];
            
            [weakSelf.tmpArray addObjectsFromArray:weakSelf.destinationCity];
            
            [aView setFetchDataSource:^NSArray *{
                return weakSelf.tmpArray;
            }];

        }else if (index == 3){
            aView = [[XIOptionView alloc] initWithFrame:CGRectMake(0, py, dpW, 240)];
            aView.backgroundColor = [UIColor whiteColor];
            aView.delegate = weakSelf;
            aView.viewIndex = index;
            NSArray *tmpArray = @[@"全部",@"门票",@"仅酒店",@"酒店套餐"];
            [aView setFetchDataSource:^NSArray *{
                return tmpArray;
            }];
            
        }else{
            ////长度根据数组的个数 * 40
            aView = [[XIOptionView alloc] initWithFrame:CGRectMake(0, py, dpW, (weakSelf.scenicArray.count + 1) * 40)];
            aView.backgroundColor = [UIColor whiteColor];
            aView.delegate = weakSelf;
            aView.viewIndex = index;
            
            weakSelf.tmpArray1 = [NSMutableArray arrayWithObjects:@"全部", nil];
            
            [weakSelf.tmpArray1 addObjectsFromArray:weakSelf.scenicArray];

            [aView setFetchDataSource:^NSArray *{
                //根据数据请求的数组
                return weakSelf.tmpArray1;
            }];
        }
        //aView.hidden = YES;
        [weakSelf.view addSubview:aView];
        return aView;
    }];
}

#pragma XIDropdownlistViewProtocol method  点击方法

- (void)didSelectItemAtIndex:(NSInteger)index inSegment:(NSInteger)segment
{
    NSArray *tmpArry;
    if(segment==0){
        tmpArry = @[@"默认排序", @"价格变高", @"价格变低",@"销量优先",@"新品优先",@"离我最近"];
        [ddltView setTitle:tmpArry[index] forItem:segment];
    }
    else if(segment==1){
        //根据请求数组
        //tmpArry = @[@"全部", @"北京"];
        [ddltView setTitle:self.tmpArray[index] forItem:segment];
        //本页面传值
        self.cityName = self.tmpArray[index];
    }
    else if(segment == 2){
        //请求数组
        //NSLog(@"%s, %ld", __FUNCTION__, (long)index);
       // tmpArry = @[@"全部", @"bbb",@"cvvv"];
        [ddltView setTitle:self.tmpArray1[index] forItem:segment];
        //可以取到点击的景点名
       // NSLog(@"%@",self.tmpArray1[index]);
       
        self.scenicName = self.tmpArray1[index];
    }else{
        
        tmpArry = @[@"全部",@"门票",@"仅酒店",@"酒店套餐"];
        //测试点击事件
        //        if (index == 1) {
        //            ViewController *viewc = [ViewController new];
        //            [self.navigationController pushViewController:viewc animated:YES];
        //        }else{
        //
        //        }
        
    }
    
    
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
