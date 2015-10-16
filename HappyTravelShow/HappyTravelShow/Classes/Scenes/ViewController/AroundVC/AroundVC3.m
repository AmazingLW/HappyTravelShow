
//
//  AroundVC2.m
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/10.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//



#import "XIOptionSelectorView.h"
#import "XIOptionView.h"
#import "XIOtherOptionsView.h"
#import "XIColorHelper.h"
#import "AroundHelper.h"
#import "AroundMainModel.h"
#import "FinderKindModel.h"
#import "CommonCells+SetModel.h"
#import "ComDetailVC.h"
#import "SearchVC.h"
#import "AroundVC3.h"
#import "AroundVC2.h"
#import "SearchVC.h"
#import "MJRefresh.h"
@interface AroundVC3 ()<XIDropdownlistViewProtocol,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate, PassWordDelegate>
{
    XIOptionSelectorView *ddltView;
}
//页面
@property (nonatomic, strong)UITableView *tableView;
//组装景点用到的字典
@property (nonatomic, strong)NSMutableDictionary *dic;
//全部景点
@property (nonatomic, strong)NSMutableArray *allScenic;
//景点名列表
@property (nonatomic, strong)NSMutableArray *scenicArray;
@property (nonatomic, strong) NSMutableArray *tmpArray1;
//目的城市数组
@property (nonatomic, strong)NSMutableArray *destinationCity;
@property (nonatomic, strong) NSMutableArray *tmpArray;
//请求数据需要的tagName
@property (nonatomic, strong)NSString *tagName;
//请求数据需要的scenicName
@property (nonatomic, strong)NSString *scenicName;
//请求数据需要的sortName
@property (nonatomic, strong)NSString *sortName;
//组装是用到的临时数组

@property (nonatomic, strong)NSMutableArray *tempArray;
@property (nonatomic, strong)NSMutableDictionary *type;
//字典 allkeys
@property (nonatomic, strong)NSMutableArray *keyArray;
//字典 allValues
@property (nonatomic, strong)NSMutableArray *ValueArray;

//计数sortName 点击了几次
@property (nonatomic, assign)NSUInteger sort;
//计数scenicName 点击了几次
@property (nonatomic, assign)NSUInteger scenic;

//计数tagName 点击了几次
@property (nonatomic, assign)NSUInteger tag;

@property (nonatomic, strong)SearchVC * sear;


@property (nonatomic, strong)NSString *tmpsort;

@property (nonatomic, strong)NSString *tmpscenic;

@property (nonatomic, strong)NSString *tmptag;

@property (nonatomic, strong)NSString *cityName;


@property (nonatomic, strong)NSString *CITYNAME;

//刷新修改用
@property (nonatomic, assign)NSInteger currentPage;
@property (nonatomic, assign)NSInteger current;
@property (nonatomic, assign)NSInteger page;


@end

@implementation AroundVC3

static NSString *const reuse = @"cell";

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIImage *image = [UIImage imageNamed:@"around"];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"周边" image:image tag:1002];
        
        
        
     //  _allScenic = [NSMutableArray array];

    }
    return self;
}

//返回 aroundvc2 的界面 pop 出去两个界面
- (void)back:(UIButton *)button{

    [self.navigationController popViewControllerAnimated:NO];

}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupDropdownList];
    [self request];
     [self requestData];
    [self.tableView reloadData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    _sear = [SearchVC new];
//    _sear.block = ^(NSString * str){
//        
//        _CITYNAME = str;
//        
//    };
    //刷新
   
    _currentPage = 1;
    _current = 1;
    _page = 1;
    
    
    if (self.NAME.length > 0) {
        _CITYNAME = self.NAME;
        
    }else{
        
        _CITYNAME = @"北京";
    }
    
    _sear = [SearchVC new];
    
    _sear.delegate = self;
    
    self.navigationItem.hidesBackButton = YES;
    
    UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(30, 0, self.view.frame.size.width - 50, 29)];
    textfield.enabled = NO;
    textfield.text = _CITYNAME;
    textfield.textAlignment =  NSTextAlignmentCenter;
    
    textfield.textColor = [UIColor redColor];
    textfield.clearsOnBeginEditing = YES;
    
    textfield.returnKeyType = UIReturnKeySearch;
    textfield.backgroundColor = [UIColor lightGrayColor];
    
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 30, 29);
    [button setBackgroundImage:[UIImage imageNamed:@"arrows"] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor whiteColor]];
    [button addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView *aview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 29)];
    
    [aview addSubview:button];
    [aview addSubview:textfield];
    
    self.navigationItem.titleView = aview;

    
   
//     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(aback:)];

    
    
  
    
    _sortName = @"默认排序";
    _scenicName = @"全部";
    _tagName = @"全部";
    
    _sort = 0;
    _scenic = 0;
    _tag = 0;
    
    
    
    //将排序和 连接中 的 代替符号 组成数组
    _type = [[NSMutableDictionary alloc] init];
    
    NSArray *array = @[@"默认排序", @"价格由低至高", @"价格由高至低",@"销量优先",@"新品优先",@"离我最近"];
    
    NSArray *typeArray = @[@"n",@"pa",@"pd",@"s",@"xp",@"d"];
    
    for (int i = 0 ; i < array.count; i ++) {
        
        [_type setObject:typeArray[i] forKey:array[i]];
    }
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 40)];
    label.text = @"搜索结果";
    label.backgroundColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    //tableview 创建
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 140, self.view.frame.size.width, self.view.frame.size.height - 40) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorColor = [UIColor clearColor];
    
    [self.view addSubview:_tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CommonCells" bundle:nil] forCellReuseIdentifier:reuse];
    //取不到
    // NSLog(@"%@",self.destinationCity);
    
   
    
    //刷新
//    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//         _currentPage = 1;
//        [[AroundHelper new] requsetAllScenicsWithPage:_currentPage CityName:_CITYNAME finish:^(NSArray *scenic) {
//            
//            _allScenic = [scenic mutableCopy];
//            
//            [self.tableView reloadData];
//        }];
//        
//        [[self.tableView header]endRefreshing];
//    }];
//    
//    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        _currentPage ++;
//        [[AroundHelper new] requsetAllScenicsWithPage:_currentPage CityName:_CITYNAME finish:^(NSArray *scenic) {
//            
//            [_allScenic  addObjectsFromArray:scenic];
//            [self.tableView reloadData];
//        }];
//        
//        
//        
//        [[self.tableView footer]endRefreshingWithNoMoreData];
//    }];
    
    
    
    
    
    
    
}
//-(void)aback:(UIBarButtonItem *)item{
//    AroundVC2 *vc2 = [AroundVC2 new];
//    
//  
//    [self.navigationController popToViewController:vc2 animated:YES];
//  
//    
//    
//}

- (void)passwordWithString:(NSString *)string{
    
    _CITYNAME = string;
}

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
            CGFloat Hight = 240;
//            if ((weakSelf.scenicArray.count + 1) <= 6) {
//                Hight = 40 * 6;
//            }else if ((weakSelf.scenicArray.count + 1) >= 13){
//                Hight = 515;
//            }else{
//                Hight = (weakSelf.scenicArray.count + 1) * 40;
//            }
            
            aView = [[XIOptionView alloc] initWithFrame:CGRectMake(0, py, dpW, Hight)];
            aView.backgroundColor = [UIColor whiteColor];
            aView.delegate = weakSelf;
            aView.viewIndex = index;
            
            NSMutableArray *array = [NSMutableArray arrayWithObjects:@"全部", nil];
            
            [array addObjectsFromArray:weakSelf.scenicArray];
            [aView setFetchDataSource:^NSArray *{
                return array;
            }];
            
        }else{
            aView = [[XIOptionView alloc] initWithFrame:CGRectMake(0, py, dpW, 240)];
            aView.backgroundColor = [UIColor whiteColor];
            aView.delegate = weakSelf;
            aView.viewIndex = index;
            
            [aView setFetchDataSource:^NSArray *{
                return @[@"全部",@"门票",@"仅酒店",@"酒店套餐"];
            }];
        }
        aView.hidden = YES;
        
        [weakSelf.view addSubview:aView];
        return aView;
    }];
}

#pragma XIDropdownlistViewProtocol method

//默认选中第一个但是 只有点击才会走 当全都不

- (void)didSelectItemAtIndex:(NSInteger)index inSegment:(NSInteger)segment
{
    
    
    NSArray *tmpArry;
    if(segment==0){
        tmpArry = @[@"默认排序", @"价格由低至高", @"价格由高至低",@"销量优先",@"新品优先",@"离我最近"];
        [ddltView setTitle:tmpArry[index] forItem:segment];
        //  _sortName = tmpArry[index];
        //        if (!_sort) {
        //
        //            _tmpsort = @"n";
        //
        //
        //        }else{
        //
        //            _tmpsort = _type[tmpArry[index]];
        //
        //
        //        }
        
        
        
        _tmpsort = _type[tmpArry[index]];
        
        _sort++;
        
    }
    else if(segment==1){
        
//        NSMutableArray *array = [NSMutableArray arrayWithObjects:@"全部", nil];
//        
//        [array addObjectsFromArray:self.scenicArray];
//        
//        [ddltView setTitle:array[index] forItem:segment];
//        
//        //_tmpscenic = array[index];
//        //如果景点是全部那么就是全部景点
//        //        if (!_scenic) {
//        //
//        //            [[AroundHelper new]requsetAllScenicsWithCityName:@"景德镇" finish:^(NSArray *scenic) {
//        //
//        //                NSArray *array = [NSArray arrayWithArray:scenic];
//        //                _allScenic = [array mutableCopy];
//        //                [self.tableView reloadData];
//        //            }];
//        //
//        //        }else
//        
//        
//        //{
//        //在次点击全部
//        if (index == 0) {
//            
//            [self request];
//            
//        }else{
//            
//            _tmpscenic = _scenicArray[index - 1];
//            
//            // NSString *sc = self.scenicName;
//            
//            for (NSString * cityName in self.dic) {
//                NSArray *array = self.dic[cityName];
//                for (NSString *scen in array) {
//                    if (scen == _tmpscenic) {
//                        
//                        self.cityName = cityName;
//                    }
//                    
//                }
//                
//            }
//            
//        }
//        
//        //}
//        
//        _scenic++;
        
        NSMutableArray *array = [NSMutableArray arrayWithObjects:@"全部", nil];
        
        [array addObjectsFromArray:self.scenicArray];
        
        [ddltView setTitle:array[index] forItem:segment];
        
        if (index == 0) {
            
            [self request];
            
        }else{
            
            _tmpscenic = _scenicArray[index - 1];
            
            for (NSString * cityName in self.dic) {
                NSArray *array = self.dic[cityName];
                for (NSString *scen in array) {
                    if (scen == _tmpscenic) {
                        
                        self.cityName = cityName;
                    }
                    
                }
                
            }
            
        }

        _scenic++;

    }
    else{
        
        tmpArry = @[@"全部",@"门票",@"仅酒店",@"酒店套餐"];
        [ddltView setTitle:tmpArry[index] forItem:segment];
        _tagName = tmpArry[index];
        
        //        if (!_tag) {
        //
        //            _tmptag = nil;
        //
        //        }else{
        //
        //         _tmptag = tmpArry[index];
        //
        //        }
        
        _tmptag = tmpArry[index];
        
        _tag++;
    }
    
    
    [self aaa];
    
    
}

- (void)aaa{
    
    
//    //如果第一次进入程序
//    if (_sort == 0 && _tag == 0 && _scenic == 0) {
//        
//        [self request];
//    }
//    
//    //如果 只点击了 景点 排序是默认 sort = n 筛选是全部
//    if ((_sort == 0 && _tag == 0 && _scenic != 0) || ([_tmpsort isEqualToString:@"默认排序"] && [_tmptag isEqualToString:@"全部"])) {
//        
//        [self requestDataWithScenicName:_tmpscenic sort:@"n" tagName:nil cityName:self.cityName];
//        
//        //如果 点击了 景点 和筛选  排序是默认 sort = n
//    }else if ((_sort == 0 && _tag != 0 && _scenic != 0)|| [_tmpsort isEqualToString:@"默认排序"]){
//        
//        if ([_tmptag isEqualToString:@"全部"]) {
//            
//            [self requestDataWithScenicName:_tmpscenic sort:_tmpsort tagName:nil cityName:self.cityName];
//        }
//        [self requestDataWithScenicName:_tmpscenic sort:@"n" tagName:_tmptag cityName:self.cityName];
//        
//        //如果三个都点击了 并且都不是第一个
//    }else if ((_sort != 0 && _tag != 0 && _scenic != 0) && ((![_tmpsort isEqualToString:@"默认排序"]) && (![_tmptag isEqualToString:@"全部"])&& (![_tmpscenic isEqualToString:@"全部"]))){
//        
//        [self requestDataWithScenicName:_tmpscenic sort:_tmpsort tagName:_tmptag cityName:self.cityName];
//        //如果只点击了 筛选  景点全部 排序是默认 sort = n
//    }else if ((_sort == 0 && _tag != 0 && _scenic == 0) || ([_tmpsort isEqualToString:@"默认排序"] &&[_tmpscenic isEqualToString:@"全部"])){
//        [self sortWithType:@"n" tagName:_tmptag];
//        
//        //如果只点击了 排序  景点全部 筛选是默认
//    }else if ((_sort != 0 && _tag == 0 && _scenic == 0) ||([_tmptag isEqualToString:@"全部"] && [_tmpscenic isEqualToString:@"全部"])){
//        
//        [self onlySortWithType:_tmpsort];
//        // 当点击了 排序 和 筛选  景点全部时
//    }else if ((_sort != 0 && _tag != 0 && _scenic == 0) || [_tmpscenic isEqualToString:@"全部"]){
//        
//        [self sortWithType:_tmpsort tagName:_tmptag];
//        
//        //当 点击 排序 和 景点 筛选是全部
//    }else if ((_sort != 0 && _tag == 0 && _scenic != 0) || ([_tmptag isEqualToString:@"全部"])){
//        
//        [self requestDataWithScenicName:_tmpscenic sort:_tmpsort tagName:nil cityName:self.cityName];
//        
//    }
    
    //如果第一次进入程序
    if (_sort == 0 && _tag == 0 && _scenic == 0) {
        
        [self request];
    }
    
    //如果 只点击了 景点 排序是默认 sort = n 筛选是全部
    if ((_sort == 0 && _tag == 0 && _scenic != 0) || ([_tmpsort isEqualToString:@"默认排序"] && [_tmptag isEqualToString:@"全部"])) {
        
        [self requestDataWithScenicName:_tmpscenic sort:@"n" tagName:nil cityName:self.cityName];
        
        
        
        //如果 点击了 景点 和筛选  排序是默认 sort = n
    }else if ((_sort == 0 && _tag != 0 && _scenic != 0)|| [_tmpsort isEqualToString:@"默认排序"]){
        
        if ([_tmptag isEqualToString:@"全部"]) {
            
            [self requestDataWithScenicName:_tmpscenic sort:_tmpsort tagName:nil cityName:self.cityName];
        }
        [self requestDataWithScenicName:_tmpscenic sort:@"n" tagName:_tmptag cityName:self.cityName];
        
        //如果三个都点击了 并且都不是第一个
    }else if ((_sort != 0 && _tag != 0 && _scenic != 0) && ((![_tmpsort isEqualToString:@"默认排序"]) && (![_tmptag isEqualToString:@"全部"])&& (![_tmpscenic isEqualToString:@"全部"]))){
        
        [self requestDataWithScenicName:_tmpscenic sort:_tmpsort tagName:_tmptag cityName:self.cityName];
        //如果只点击了 筛选  景点全部 排序是默认 sort = n
    }else if ((_sort == 0 && _tag != 0 && _scenic == 0) || ([_tmpsort isEqualToString:@"默认排序"] &&[_tmpscenic isEqualToString:@"全部"])){
        
        if ([_tmptag isEqualToString:@"全部"]) {
            [self request];
            //[self requestDataWithScenicName:_tmpscenic sort:_tmpsort tagName:nil cityName:self.cityName];
        }else{
            
            [self sortWithType:@"n" tagName:_tmptag];
        }
        //如果只点击了 排序  景点全部 筛选是默认
    }else if ((_sort != 0 && _tag == 0 && _scenic == 0) ||([_tmptag isEqualToString:@"全部"] && [_tmpscenic isEqualToString:@"全部"])){
        
        [self onlySortWithType:_tmpsort];
        // 当点击了 排序 和 筛选  景点全部时
    }else if ((_sort != 0 && _tag != 0 && _scenic == 0) || [_tmpscenic isEqualToString:@"全部"]){
        
        if ([_tmptag isEqualToString:@"全部"] && [_tmpsort isEqualToString:@"默认排序"]) {
            [self request];
            
        }else if ((![_tmptag isEqualToString:@"全部"]) && [_tmpsort isEqualToString:@"默认排序"]){
            
            [self sortWithType:@"n" tagName:_tmptag];
        }else if (([_tmptag isEqualToString:@"全部"]) && (![_tmpsort isEqualToString:@"默认排序"])){
            
            [self onlySortWithType:_tmpsort];
        }else{
            //初始
            [self sortWithType:_tmpsort tagName:_tmptag];
        }
        
        //当 点击 排序 和 景点 筛选是全部
    }else if ((_sort != 0 && _tag == 0 && _scenic != 0) || ([_tmptag isEqualToString:@"全部"])){
        
        [self requestDataWithScenicName:_tmpscenic sort:_tmpsort tagName:nil cityName:self.cityName];
        
    }

    
    
    
}

//点击景点 显示景点列表
- (void)requestDataWithScenicName:(NSString *)scenicName sort:(NSString *)sort tagName:(NSString *)tagName cityName:(NSString *)cityName{
    
    [[AroundHelper new] requestDataFromURLStringWithScenicName:scenicName sort:sort tagName:tagName cityName:cityName finish:^(NSArray *array) {
        
        _allScenic = [array mutableCopy];
        
        
        [self.tableView reloadData];
        
    }];
}


//只点击排序

- (void)onlySortWithType:(NSString *) type{
    
    [[AroundHelper new] sortDataWithType:type cityName:_CITYNAME finish:^(NSArray *array) {
        
        _allScenic = [NSMutableArray arrayWithArray:array];
        [self.tableView reloadData];
        
    }];
    
}

//筛选
//当 目的城市为全部 景点全部  排序方式改变   筛选方式改变
- (void)sortWithType:(NSString *)type tagName:(NSString *)tagName{
    
//    [[AroundHelper new] chooseScenicWithSortType:type TagName:tagName cityName:_CITYNAME finish:^(NSArray *array) {
//        
//        _allScenic = [array mutableCopy];
//        
//        [self.tableView reloadData];
//        
//    }];
    
    
    [[AroundHelper new] chooseScenicWithPage:_current SortType:type TagName:tagName cityName:_CITYNAME finish:^(NSArray *array) {
        
        //[_allScenic addObjectsFromArray:array];
        _allScenic = [array mutableCopy];
        [self.tableView reloadData];
        
    }];

    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ---tableview 代理事件
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  _allScenic.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CommonCells *cell = [tableView dequeueReusableCellWithIdentifier:reuse forIndexPath:indexPath];
    
    
    
    cell.Model = _allScenic[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 111;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AroundKindModel *model = _allScenic[indexPath.row];
    
    NSInteger productId = model.productId;
    //
    NSInteger packageID = model.channelLinkId;
    ComDetailVC *comDetail = [[ComDetailVC alloc] init];
    
    comDetail.bookID = packageID;
    comDetail.detailID = productId;
    
    UINavigationController *rootNC = [[UINavigationController alloc] initWithRootViewController:comDetail];
    [self presentViewController:rootNC animated:YES completion:nil];
    
    
    //    [self.navigationController pushViewController:comDetail animated:YES];
    
}


#pragma mark ---请求数据

- (void)requestData{
    
    
    _dic = [[NSMutableDictionary alloc] init];
    [[AroundHelper new] requestWithCityName:_CITYNAME finish:^(NSArray *array) {
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
        
        
        
        //组装字典
        for (int i = 0; i < _destinationCity.count; i ++) {
            NSArray *array = _tempArray[i];
            [_dic setObject:array forKey:_destinationCity[i]];
            
        }
        
        //调用方法
        [self setupDropdownList];
        // [_tableView reloadData];
    }];
    

 

    
}

#warning 修改过
//CityName 是请求到的目的城市
- (void)request{
//    [[AroundHelper new]requsetAllScenicsWithCityName:_CITYNAME finish:^(NSArray *scenic) {
//        
//        _allScenic = [NSMutableArray arrayWithArray:scenic];
//        [self.tableView reloadData];
//    }];
    
    [[AroundHelper new] requsetAllScenicsWithPage:_currentPage CityName:_CITYNAME finish:^(NSArray *scenic) {
        
        _allScenic =[scenic mutableCopy];
        
        [self.tableView reloadData];
    }];

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
