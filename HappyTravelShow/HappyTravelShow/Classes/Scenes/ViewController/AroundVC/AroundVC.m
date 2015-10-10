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
#import "CommonCells+SetModel.h"
#import "ComDetailVC.h"
@interface AroundVC ()<XIDropdownlistViewProtocol,UITableViewDelegate,UITableViewDataSource>
{
     XIOptionSelectorView *ddltView;
    //判断目的城市是否是全部
    BOOL isAll;
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

//组装景点用到的字典
@property (nonatomic, strong)NSMutableDictionary *dic;

//组装是用到的临时数组

@property (nonatomic, strong)NSMutableArray *tempArray;

//字典 allkeys

@property (nonatomic, strong)NSMutableArray *keyArray;

//字典 allValues

@property (nonatomic, strong)NSMutableArray *ValueArray;

//价格升高
@property (nonatomic, strong)NSMutableArray *sortDataUp;
//价格降低
@property (nonatomic, strong)NSMutableArray *sortDataDown;
//销量优先
@property (nonatomic, strong)NSMutableArray *sales;
//新品优先
@property (nonatomic, strong)NSMutableArray *news;
//距离我最近
@property (nonatomic, strong)NSMutableArray *distance;



@end

@implementation AroundVC
static NSString *const reuse = @"cell";

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIImage *image = [UIImage imageNamed:@"around"];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"周边" image:image tag:1002];
        isAll = YES;
    }
    
    return self;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
  
  
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
 //tableview 创建
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorColor = [UIColor clearColor];
    
    [self.view addSubview:_tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CommonCells" bundle:nil] forCellReuseIdentifier:reuse];
    
    [self setupDropdownList];
    [self requestData];
}

//数据请求
- (void)requestData{
    // CityName 应该是定位的
    _dic = [[NSMutableDictionary alloc] init];
    [[AroundHelper new] requestWithCityName:@"景德镇" finish:^(NSArray *array) {
        NSMutableArray *arr = [NSMutableArray arrayWithArray:array];
          _tempArray = [[NSMutableArray alloc] init];
        _destinationCity = [NSMutableArray array];
        _scenicArray = [NSMutableArray array];
        for (AroundMainModel *model in arr) {
            //目的城市
            [_destinationCity addObject:model.city];
            //scenics 数组 取出里面的小字典的值
            NSArray * array = model.scenics;
             NSMutableArray *arr = [[NSMutableArray alloc] init];
            for (NSDictionary *scenics in array) {
                NSString *scenicName = scenics[@"scenic"];
            [_scenicArray addObject:scenicName];
                //从新组装数组
                //存放每个小city中scenics的数组
                [arr addObject:scenicName];
            }
            [_tempArray addObject:arr];
        }
        //调用方法
        [self setupDropdownList];
       // [_tableView reloadData];
    }];
    //CityName 是请求到的目的城市
    [[AroundHelper new]requsetAllScenicsWithCityName:@"景德镇" finish:^(NSArray *scenic) {
        
        _allScenic = [NSMutableArray arrayWithArray:scenic];
        [self.tableView reloadData];
    }];
    //当目的城市选定 景点全部时 列表
    // pa 价格变高 pd 价格变低  s 销量优先  xp新品优先  d 离我最近
    //目的城市全部 景点全部 价格变高
    [[AroundHelper new] sortDataWithType:@"pa" cityName:@"景德镇" finish:^(NSArray *array) {
       
        _sortDataUp = [NSMutableArray arrayWithArray:array];
    }];
    //目的城市全部 景点全部 价格变低
    [[AroundHelper new] sortDataWithType:@"pd" cityName:@"景德镇" finish:^(NSArray *array) {
        
        _sortDataDown = [NSMutableArray arrayWithArray:array];
    }];
    //目的城市全部 景点全部 s 销量优先
    [[AroundHelper new] sortDataWithType:@"s" cityName:@"景德镇" finish:^(NSArray *array) {

        _sales = [NSMutableArray arrayWithArray:array];
    }];
    //目的城市全部 景点全部 xp新品优先
    [[AroundHelper new] sortDataWithType:@"xp" cityName:@"景德镇" finish:^(NSArray *array) {
        
        _news = [NSMutableArray arrayWithArray:array];
    }];
    //目的城市全部 景点全部 d 离我最近
    [[AroundHelper new] sortDataWithType:@"xp" cityName:@"景德镇" finish:^(NSArray *array) {
        
        _distance = [NSMutableArray arrayWithArray:array];
 
    }];
}

#pragma mark ---tableview 代理事件
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
    return _allScenic.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    CommonCells *cell = [tableView dequeueReusableCellWithIdentifier:reuse forIndexPath:indexPath];
    
    //NSLog(@"====%@",_allScenic[indexPath.row]);
    
    cell.Model = _allScenic[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 135;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AroundKindModel *model = _allScenic[indexPath.row];
    
    NSInteger productId = model.productId;
    NSString *packageID = model.channelLinkId;
    ComDetailVC *comDetail = [[ComDetailVC alloc] init];
    
    comDetail.bookID = [packageID integerValue];
    comDetail.detailID = productId;
    
    [self.navigationController pushViewController:comDetail animated:YES];
    
}

#pragma mark --顶部4个按钮的创建
- (void)setupDropdownList
{
    //组装字典
    for (int i = 0; i < _destinationCity.count; i ++) {
        NSArray *array = _tempArray[i];
        [_dic setObject:array forKey:_destinationCity[i]];
        
    }
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
            CGFloat Hight = 0;
            if ((weakSelf.destinationCity.count + 1) <= 6) {
                Hight = 40 * 6;
            }else if ((weakSelf.destinationCity.count + 1) >= 13){
                Hight = 515;
            }else{
                Hight = (weakSelf.destinationCity.count + 1) * 40;
            }
            //可以添加判断如果数组个数少于6个 返回高度240 如果大于整个屏幕就返回屏幕- 104
            aView = [[XIOptionView alloc] initWithFrame:CGRectMake(0, py, dpW, Hight)];
            aView.backgroundColor = [UIColor whiteColor];
            aView.delegate = weakSelf;
            aView.viewIndex = index;
            //第二个数组的个数是根据数据请求来得
            
           weakSelf.keyArray = [NSMutableArray arrayWithObjects:@"全部", nil];
           
            [weakSelf.keyArray addObjectsFromArray:[weakSelf.dic allKeys]];
            
            [aView setFetchDataSource:^NSArray *{
                return weakSelf.keyArray;
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
            
            CGFloat Hight = 0;
            if ((weakSelf.scenicArray.count + 1) <= 6) {
                Hight = 40 * 6;
            }else if ((weakSelf.scenicArray.count + 1) >= 13){
                Hight = 515;
            }else{
                Hight = (weakSelf.scenicArray.count + 1) * 40;
            }
            //NSLog(@"%ld",weakSelf.tmpArray1.count);

            ////长度根据数组的个数 * 40
          //  if (isAll == YES) {
                aView = [[XIOptionView alloc] initWithFrame:CGRectMake(0, py, dpW, Hight)];
                aView.backgroundColor = [UIColor whiteColor];
                aView.delegate = weakSelf;
                aView.viewIndex = index;
                
                weakSelf.ValueArray = [NSMutableArray arrayWithObjects:@"全部", nil];
                
                [weakSelf.ValueArray addObjectsFromArray:weakSelf.scenicArray];
                
                [aView setFetchDataSource:^NSArray *{
                    //根据数据请求的数组
                    return weakSelf.ValueArray;
                }];
//            }else{
//                
//            aView = [[XIOptionView alloc] initWithFrame:CGRectMake(0, py, dpW, Hight)];
//            aView.backgroundColor = [UIColor whiteColor];
//            aView.delegate = weakSelf;
//            aView.viewIndex = index;
//            
//            weakSelf.ValueArray = [NSMutableArray array];
//            
//            [weakSelf.ValueArray addObjectsFromArray:weakSelf.tmpArray1];
//
//            [aView setFetchDataSource:^NSArray *{
//                //根据数据请求的数组
//                return weakSelf.ValueArray;
//            }];
//            }
            
        }
        aView.hidden = YES;
        [weakSelf.view addSubview:aView];
      
        return aView;
    }];
}

#pragma XIDropdownlistViewProtocol method  点击方法

//点击显示的内容 数量必须与上面的相等

- (void)didSelectItemAtIndex:(NSInteger)index inSegment:(NSInteger)segment
{
    
    NSArray *tmpArry;
    if(segment==0){
        tmpArry = @[@"默认排序", @"价格变高", @"价格变低",@"销量优先",@"新品优先",@"离我最近"];
        [ddltView setTitle:tmpArry[index] forItem:segment];
        
        if (index == 1) {
            _allScenic = _sortDataUp;
            [self.tableView reloadData];
           // 如果 两个其中有一个有值 那么点击过 在排序 走不通的排序方法
            if (self.cityName || self.scenicName) {
                
                [self sort];
            }
            
            
        }else if(index == 2){
            _allScenic = _sortDataDown;
            [self.tableView reloadData];
            
        }else if (index == 3){
            _allScenic = _sales;
            [self.tableView reloadData];
        }else if (index == 4){
            _allScenic = _news;
            [self.tableView reloadData];
        }else{
            _allScenic = _distance;
            [self.tableView reloadData];
        }
        
    }
    else if(segment==1){
        _tmpArray1 = [NSMutableArray arrayWithObjects:@"全部", nil];
        
      //  if (index == 0) {
        
        //根据请求数组
        
        [self.tmpArray1 addObjectsFromArray:[self.dic allKeys]];
        [ddltView setTitle:self.tmpArray1[index] forItem:segment];
        //本页面传值
        self.cityName = self.tmpArray1[index];
        
        [self request];
        
        NSLog(@"%@",self.cityName);
      //如果不是全部的目的城市 点击 景点会跟随改变
      //  NSLog(@"%@",self.keyArray[index]);
//            isAll = YES;
//        
//            [_tmpArray1 addObjectsFromArray:[self.dic allValues]];
//        }else{
//            isAll = NO;
//            [ddltView setTitle:self.keyArray[index] forItem:segment];
//            //本页面传值
//            self.cityName = self.keyArray[index];
//            
//        [_tmpArray1 addObjectsFromArray:self.dic[self.keyArray[index]]];
//        
//        }
    }
    else if(segment == 2){
        _tmpArray = [NSMutableArray arrayWithObjects:@"全部", nil];
        [_tmpArray addObjectsFromArray:self.scenicArray];
        //请求数组
        //NSLog(@"%s, %ld", __FUNCTION__, (long)index);
        
        [ddltView setTitle:self.tmpArray[index] forItem:segment];
        //可以取到点击的景点名
        NSLog(@"%@",self.tmpArray[index]);
        self.scenicName = self.tmpArray[index];
        
        [self litleRequest];
        
    }else{
        tmpArry = @[@"全部",@"门票",@"仅酒店",@"酒店套餐"];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)request{
    //当目的城市选定 景点全部时 列表
    [[AroundHelper new] requsetAllScenicsWithScenicName:self.cityName finish:^(NSArray *scenic) {
       
        _allScenic = [scenic mutableCopy];
        
        [self.tableView reloadData];
    }];
}


#warning  必须 根据目的城市 选出 景点名

#warning  只能以上饶 和 上饶景点为例

- (void)litleRequest{
    
    //如果目的城市是全部 也就是没有点击目的城市  根据 dic 取得
    if (self.cityName == NULL) {
        
        NSString *sc = self.scenicName;
        
        for (NSString * cityName in self.dic) {
            NSArray *array = self.dic[cityName];
            for (NSString *scen in array) {
                if (scen == sc) {
                    
                    self.cityName = cityName;
                }
                
            }
            
        }
        
    [[AroundHelper new] requestLittleScenicWithCithName:self.cityName scenicName:self.scenicName finish:^(NSArray *array) {
        
        _allScenic = [array mutableCopy];
        [self.tableView reloadData];
        
    }];
    }else{
        
        [[AroundHelper new] requestLittleScenicWithCithName:self.scenicName scenicName:self.cityName finish:^(NSArray *array) {
            
            _allScenic = [array mutableCopy];
            [self.tableView reloadData];
        }];
    }
    
    
    
    
    
}

- (void)sort{
    
    
    
    
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
