//
//  AroundVC2.m
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/10.
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
#import "SearchVC.h"
#import "AroundVC2.h"


@interface AroundVC2 ()<XIDropdownlistViewProtocol,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
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


@property (nonatomic, strong)NSString *tmpsort;

@property (nonatomic, strong)NSString *tmpscenic;

@property (nonatomic, strong)NSString *tmptag;

@property (nonatomic, strong)NSString *cityName;
@end

@implementation AroundVC2

static NSString *const reuse = @"cell";

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIImage *image = [UIImage imageNamed:@"around"];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"周边" image:image tag:1002];
       UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 20, 29)];
         textfield.enabled = NO;
        textfield.placeholder = @"搜索目的地/景点/酒店";
        textfield.backgroundColor = [UIColor lightGrayColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        
        label.text = @"🔍";
        // label.backgroundColor = [UIColor redColor];
        textfield.rightView = label;
        textfield.rightViewMode = UITextFieldViewModeAlways;
        self.navigationItem.titleView = textfield;
        
        
        UIView *a = [[UIView alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width - 20, 29)];
        a.backgroundColor = [UIColor redColor];
        [a addSubview:textfield];
        self.navigationItem.titleView = a;
        
        
        
        //textfield添加手势 跳转
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(skip:)];
      //  tap.numberOfTapsRequired = 1;
        
    
        [a addGestureRecognizer:tap];
        
    }
    return self;
}


- (void)skip:(UITapGestureRecognizer *)tap{
    NSLog(@"---");
    SearchVC *seVC = [SearchVC new];
    [self.navigationController showViewController:seVC sender:nil];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
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
    
    //tableview 创建
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height - 40) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorColor = [UIColor clearColor];
    
    [self.view addSubview:_tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CommonCells" bundle:nil] forCellReuseIdentifier:reuse];
    //取不到
   // NSLog(@"%@",self.destinationCity);
    
    [self setupDropdownList];
    [self requestData];
    

    
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
            CGFloat Hight = 0;
            if ((weakSelf.scenicArray.count + 1) <= 6) {
                Hight = 40 * 6;
            }else if ((weakSelf.scenicArray.count + 1) >= 13){
                Hight = 515;
            }else{
                Hight = (weakSelf.scenicArray.count + 1) * 40;
            }

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
        
        NSMutableArray *array = [NSMutableArray arrayWithObjects:@"全部", nil];
        
        [array addObjectsFromArray:self.scenicArray];
        
        [ddltView setTitle:array[index] forItem:segment];
        
        //_tmpscenic = array[index];
        //如果景点是全部那么就是全部景点
//        if (!_scenic) {
//            
//            [[AroundHelper new]requsetAllScenicsWithCityName:@"景德镇" finish:^(NSArray *scenic) {
//                
//                NSArray *array = [NSArray arrayWithArray:scenic];
//                _allScenic = [array mutableCopy];
//                [self.tableView reloadData];
//            }];
//  
//        }else
        
        
             //{
            //在次点击全部
            if (index == 0) {
                
                [self request];
                
            }else{
            
            _tmpscenic = _scenicArray[index - 1];
            
           // NSString *sc = self.scenicName;
            
            for (NSString * cityName in self.dic) {
                NSArray *array = self.dic[cityName];
                for (NSString *scen in array) {
                    if (scen == _tmpscenic) {
                        
                        self.cityName = cityName;
                    }
                    
                }
 
            }
        
            }
 
        //}
        
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
    
    
    [self fuck];
 
    
}

- (void)fuck{
    
    
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
        [self sortWithType:@"n" tagName:_tmptag];
        
       //如果只点击了 排序  景点全部 筛选是默认
    }else if ((_sort != 0 && _tag == 0 && _scenic == 0) ||([_tmptag isEqualToString:@"全部"] && [_tmpscenic isEqualToString:@"全部"])){
        
        [self onlySortWithType:_tmpsort];
        // 当点击了 排序 和 筛选  景点全部时
    }else if ((_sort != 0 && _tag != 0 && _scenic == 0) || [_tmpscenic isEqualToString:@"全部"]){
        
        [self sortWithType:_tmpsort tagName:_tmptag];
        
        //当 点击 排序 和 景点 筛选是全部
    }else if ((_sort != 0 && _tag == 0 && _scenic != 0) || ([_tmptag isEqualToString:@"全部"])){
        
        [self requestDataWithScenicName:_tmpscenic sort:_tmpsort tagName:nil cityName:self.cityName];
        
    }

    
    
    
    
}

//点击景点 显示景点列表
- (void)requestDataWithScenicName:(NSString *)scenicName sort:(NSString *)sort tagName:(NSString *)tagName cityName:(NSString *)cityName{
    
    [[AroundHelper new] requestDataFromURLStringWithScenicName:scenicName sort:sort tagName:tagName cityName:cityName finish:^(NSArray *array) {
        
        _allScenic = [array mutableCopy];
        
//        UIView *aview = [[UIView alloc] initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height - 40)];
//        
//        aview.backgroundColor = [UIColor whiteColor];
//        
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2, 200, 30)];
//        label.text = @"对不起我们正在努力开拓产品.....";
//        [aview addSubview:label];
//        
//        
//        if (_allScenic == nil){
//            
//            [self.view insertSubview:aview aboveSubview:self.tableView];
//        
//        }else{
//            [aview removeFromSuperview];
            
        
        [self.tableView reloadData];
      
    }];
}


//只点击排序

- (void)onlySortWithType:(NSString *) type{
    
    [[AroundHelper new] sortDataWithType:type cityName:@"苏州" finish:^(NSArray *array) {
        
        _allScenic = [NSMutableArray arrayWithArray:array];
        [self.tableView reloadData];
        
    }];
    
}

//筛选
//当 目的城市为全部 景点全部  排序方式改变   筛选方式改变
- (void)sortWithType:(NSString *)type tagName:(NSString *)tagName{
    
    [[AroundHelper new] chooseScenicWithSortType:type TagName:tagName cityName:@"苏州" finish:^(NSArray *array) {
        
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
    
    return 135;
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
    [[AroundHelper new] requestWithCityName:@"苏州" finish:^(NSArray *array) {
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
    
    //CityName 是请求到的目的城市
    
    [[AroundHelper new]requsetAllScenicsWithCityName:@"苏州" finish:^(NSArray *scenic) {
        
        _allScenic = [NSMutableArray arrayWithArray:scenic];
        [self.tableView reloadData];
    }];
    
}

- (void)request{
    [[AroundHelper new]requsetAllScenicsWithCityName:@"苏州" finish:^(NSArray *scenic) {
        
        _allScenic = [NSMutableArray arrayWithArray:scenic];
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
