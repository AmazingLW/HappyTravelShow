//
//  FinderVC.m
//  HappyTravelShow
//
//  Created by Amazing on 15/10/6.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "FinderVC.h"
#import "FinderHelper.h"
#import "FinderMainCell.h"
#import "FindKindOfSceneController.h"
#import "LocationVC.h"
#import "MJRefresh.h"

@interface FinderVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *uiTableView;
//当前页数
@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,assign) NSInteger   pageSize;

//block回来的数据
@property(nonatomic,strong) NSMutableArray  *dataArray;


//搜索框
@property(nonatomic,strong)UITextField *searchTextField;
//城市标题
@property(nonatomic,strong)NSString*string,*cityName,*cityCode;

@end

@implementation FinderVC


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIImage *image = [UIImage imageNamed:@"finder"];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"发现" image:image tag:1003];
        self.uiTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        [self.view addSubview:self.uiTableView];
        self.uiTableView.delegate=self;
        self.uiTableView.dataSource=self;
        //隐藏cell之间的线条
        self.uiTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        //城市按钮
        
        self.cityCode =@"110100";
        self.string =@"北京";
        self.cityName =@"北京";
        
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"北京v"style:(UIBarButtonItemStylePlain) target:self action:@selector(changeCity)];
        self.navigationItem.leftBarButtonItem.tintColor=[UIColor blackColor];
        
        _currentPage=1;
        _pageSize=10;
    }
    
    return self;
}

//点击切换城市 /

- (void)changeCity{
    
    
    LocationVC *locationVC=[LocationVC new];
    locationVC.block =^(NSString *string,NSString*cityName,NSString*cityCode){
        
        self.string = string;
        self.cityName = cityName;
        self.cityCode =cityCode;
        
        
        [[FinderHelper sharedHelper]getDataWithPageSize:self.pageSize CityCode:self.cityCode pageIndex:1 Finish:^(NSMutableArray *arr) {
           
            self.dataArray=[NSMutableArray array];
            self.dataArray=[arr mutableCopy];
            
            [self.uiTableView reloadData];
            
            
        }];
        
        
    };
    

    
    
    locationVC.hidesBottomBarWhenPushed = YES;

    [self.navigationController pushViewController:locationVC animated:YES];

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    if (self.string!=nil) {
        self.navigationItem.leftBarButtonItem.title = [NSString stringWithFormat:@"%@v",self.string];
        
    }
    

    
}







- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    //注册
    [self.uiTableView registerNib:[UINib nibWithNibName:@"FinderMainCell" bundle:nil] forCellReuseIdentifier:@"mainCell"];
    
    
    
    [[FinderHelper sharedHelper]getDataWithPageSize:self.pageSize CityCode:self.cityCode pageIndex:1 Finish:^(NSMutableArray *arr) {
       
       self.dataArray=[NSMutableArray array];
        self.dataArray=[arr mutableCopy];
        
        [self.uiTableView reloadData];

        
    }];
    
    //下拉刷新
    
     self.uiTableView.header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
         [[FinderHelper sharedHelper]getDataWithPageSize:self.pageSize*self.currentPage CityCode:self.cityCode pageIndex:1 Finish:^(NSMutableArray *arr) {
             self.dataArray=[NSMutableArray array];
             self.dataArray=[arr mutableCopy];
             [self.uiTableView reloadData];

              [self.uiTableView.header endRefreshing];

             
         }];
         
     }];
    
         

   // 上拉加载
    self.uiTableView.footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
       
        self.currentPage++;

        
        [[FinderHelper sharedHelper]getDataWithPageSize:self.pageSize CityCode:self.cityCode pageIndex:self.currentPage Finish:^(NSMutableArray *arr) {
            
            [self.dataArray addObjectsFromArray:arr];
            [self.uiTableView reloadData];
            [self.uiTableView.footer endRefreshingWithNoMoreData];
            

        }];

        
    }];
    
    
    




}











#pragma mark---tableView代理方法-------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
    
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FinderMainCell *cell=[self.uiTableView dequeueReusableCellWithIdentifier:@"mainCell" forIndexPath:indexPath];
    
    cell.mainModel=self.dataArray[indexPath.row];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 200;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FindKindOfSceneController *findVC=[FindKindOfSceneController new];
    FinderMainModel *mainModel=self.dataArray[indexPath.row];
    findVC.model=mainModel;
    findVC.titleString=mainModel.title;
    findVC.cityCode=self.cityCode;
    findVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:findVC animated:YES];
   findVC.hidesBottomBarWhenPushed = YES;
    
    
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
