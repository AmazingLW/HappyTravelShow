//
//  AroundVC4.m
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/15.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//



#import "CommonCells+SetModel.h"
#import "AroundVC4.h"
#import "AroundHelper.h"
#import "ComDetailVC.h"
#import "HotSearchModel.h"
#import "MJRefresh.h"
@interface AroundVC4 ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *array;
@property (nonatomic, assign)NSInteger currentPage;

@end

@implementation AroundVC4

static NSString * reuse = @"dsgsdghe";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _array = [NSMutableArray array];
    _currentPage = 1;
    
    self.navigationItem.hidesBackButton = YES;
    
    UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(30, 0, self.view.frame.size.width - 50, 29)];
    textfield.enabled = NO;
    textfield.text = _NAME;
    textfield.textAlignment =  NSTextAlignmentCenter;
    
    textfield.textColor = [UIColor redColor];
    textfield.clearsOnBeginEditing = YES;
    
    textfield.returnKeyType = UIReturnKeySearch;
    textfield.backgroundColor = [UIColor lightGrayColor];
    
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 30, 29);
    [button setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor whiteColor]];
    [button addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView *aview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 29)];
    
    [aview addSubview:button];
    [aview addSubview:textfield];
    
    self.navigationItem.titleView = aview;
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 40)];
    label.text = @"热门城市搜索结果";
    label.backgroundColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 104, self.view.frame.size.width, self.view.frame.size.height - 40) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorColor = [UIColor clearColor];
    
    [self.view addSubview:_tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CommonCells" bundle:nil] forCellReuseIdentifier:reuse];
    [self request];
    
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [[AroundHelper new] requestHotCityListWithKeyWord:self.NAME p:_currentPage city:@"北京" result:^(NSArray *array) {
            
            [_array addObjectsFromArray:array];
            [self.tableView reloadData];
        }];
        [[self.tableView header] endRefreshing];
        
    }];
    
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _currentPage ++;
        [[AroundHelper new] requestHotCityListWithKeyWord:self.NAME p:_currentPage city:@"北京" result:^(NSArray *array) {
            
            [_array addObjectsFromArray:array];
            [self.tableView reloadData];
        }];
        [[self.tableView footer] endRefreshing];
        
    }];

    
    // Do any additional setup after loading the view.
}

//前面传过来的热门城市   以及 首页定位城市(通知中心)
- (void)request{
//    [[AroundHelper new]requestHotCityListWithKeyWord:self.NAME city:@"北京" result:^(NSArray *array) {
//        
//        _array = [NSMutableArray arrayWithArray:array];
//        
//        [self.tableView reloadData];
//    }];
    
    [[AroundHelper new] requestHotCityListWithKeyWord:self.NAME p:_currentPage city:@"北京" result:^(NSArray *array) {
        
        [_array addObjectsFromArray:array];
        [self.tableView reloadData];
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CommonCells *cell = [tableView dequeueReusableCellWithIdentifier:reuse forIndexPath:indexPath];
    
    cell.aamodel = _array[indexPath.row];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 111;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HotSearchModel *hot = _array[indexPath.row];
    
    ComDetailVC *comDetail = [[ComDetailVC alloc] init];
    
    comDetail.bookID = hot.channelLinkId;
    comDetail.detailID = hot.productId;
    
//    UINavigationController *rootNC = [[UINavigationController alloc] initWithRootViewController:comDetail];
    [self presentViewController:comDetail animated:YES completion:nil];
}

- (void)back:(UIButton *)button{
    
    [self.navigationController popViewControllerAnimated:NO];
    
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
