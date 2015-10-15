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

@interface FinderVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *uiTableView;
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
        

        
    }
    
    return self;
}

//点击切换城市 /

- (void)changeCity{
    
  //  NSLog(@"===");
    
    LocationVC *locationVC=[LocationVC new];
    locationVC.block =^(NSString *string,NSString*cityName,NSString*cityCode){
        
        self.string = string;
        self.cityName = cityName;
        self.cityCode =cityCode;
    };
    
    locationVC.hidesBottomBarWhenPushed = YES;

    [self.navigationController pushViewController:locationVC animated:YES];

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    if (self.string!=nil) {
        self.navigationItem.leftBarButtonItem.title = [NSString stringWithFormat:@"%@v",self.string];
        
    }
    
    
    [[FinderHelper sharedHelper]getDataWithCityCode:self.cityCode pageIndex:1 Finish:^{
        
        [self.uiTableView reloadData];
    }];

    
    
    
}





- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    //注册
    [self.uiTableView registerNib:[UINib nibWithNibName:@"FinderMainCell" bundle:nil] forCellReuseIdentifier:@"mainCell"];
   

    
}


#pragma mark---tableView代理方法-------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [FinderHelper sharedHelper].dataArray.count;
    
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FinderMainCell *cell=[self.uiTableView dequeueReusableCellWithIdentifier:@"mainCell" forIndexPath:indexPath];
    
    cell.mainModel=[FinderHelper sharedHelper].dataArray[indexPath.row];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 200;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FindKindOfSceneController *findVC=[FindKindOfSceneController new];
    FinderMainModel *mainModel=[FinderHelper sharedHelper].dataArray[indexPath.row];
    findVC.model=mainModel;
    findVC.titleString=mainModel.title;
    
    UINavigationController *rootNC = [[UINavigationController alloc] initWithRootViewController:findVC];
//    self.navigationController 
    [self presentViewController:rootNC animated:YES completion:nil];
   
    
    
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
