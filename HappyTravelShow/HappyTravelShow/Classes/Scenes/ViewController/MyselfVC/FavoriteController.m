//
//  FavoriteController.m
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/10.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "FavoriteController.h"
#import "CommonCells.h"
#import "ComDetailVC.h"

@interface FavoriteController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *favoriteTableView;

@end

@implementation FavoriteController


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    if (self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        self.favoriteTableView=[[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        self.favoriteTableView.delegate=self;
        self.favoriteTableView.dataSource=self;
        
        [self.view addSubview:self.favoriteTableView];
    }
    return self;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
   //注册
    [self.favoriteTableView registerNib:[UINib nibWithNibName:@"CommonCells" bundle:nil] forCellReuseIdentifier:@"cell"];
    

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return _shouCangArr.count;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CommonCells *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.kindModel = _shouCangArr[indexPath.row];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 111;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //获取model对象
    FinderKindModel *model =  _shouCangArr[indexPath.row];
    ComDetailVC *comVC = [ComDetailVC new];
    
    comVC.bookID = [model.channelLinkId intValue];
    comVC.detailID = [model.productId intValue];
    
    [self.navigationController pushViewController:comVC animated:YES];
    
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
