//
//  MyselfVC.m
//  HappyTravelShow
//
//  Created by Amazing on 15/10/6.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "MyselfVC.h"
#import <BaiduMapAPI/BMapKit.h>

@interface MyselfVC ()<BMKMapViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)BMKMapView * mapView;

@end

@implementation MyselfVC


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIImage *image = [UIImage imageNamed:@"myself"];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:image tag:1004];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    
//    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 80, 320, 200)];
//    [self.view addSubview:_mapView];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    
}



//设置4个分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else if (section==1){
        
        return 1;
    }else if (section==2){
        return 2;
    }else{
        return 2;
    }

}
//设置分区距离
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 20;
}





//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    
//    
//    
//    
//    
//}





//-( void)viewWillAppear:(BOOL)animated
//{
//    [_mapView viewWillAppear];
//    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
//}
//-(void)viewWillDisappear:(BOOL)animated
//{
//    [_mapView viewWillDisappear];
//    _mapView.delegate = nil; // 不用时，置nil
//}

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
