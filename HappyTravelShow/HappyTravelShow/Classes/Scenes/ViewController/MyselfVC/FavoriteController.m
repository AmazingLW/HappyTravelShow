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


@property (nonatomic,assign) BOOL isEditState;

@end

@implementation FavoriteController


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    if (self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        [self.view addSubview:self.favoriteTableView];
        
        //自定义leftBarButtonItem
        
        UIButton *leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
        leftButton.frame=CGRectMake(0, 0, 30, 30);
        [leftButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *leftButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton];
        self.navigationItem.leftBarButtonItem=leftButtonItem;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 35, 20)];
        label.text = @"编辑";
        //编辑手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editShoucangAction)];
        [label addGestureRecognizer:tap];
        label.userInteractionEnabled = YES;
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:label];
        
        self.navigationItem.rightBarButtonItem = rightItem;
        
    }
    
    return self;
    
}

- (UITableView *)favoriteTableView{
    if (_favoriteTableView == nil) {
        _favoriteTableView=[[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _favoriteTableView.delegate=self;
        _favoriteTableView.dataSource=self;
    }
    return _favoriteTableView;
}

- (void)editShoucangAction{
    NSLog(@"编辑");
    
    if (_shouCangArr.count == 0) {
        return;
    }
    
    if (_isEditState) {
        [self.favoriteTableView setEditing:NO animated:NO];
        _isEditState = NO;
    }else{
        [self.favoriteTableView setEditing:YES animated:NO];
        _isEditState = YES;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{ return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FinderKindModel *model =  _shouCangArr[indexPath.row];
    //从数据库删除数据
    NSString *sqlDelete = [NSString stringWithFormat:@"delete from Shoucang where userID = '%@' and detail = '%@'",[AVUser currentUser].objectId,model.productId];
    BOOL isSuc = [[DataBase shareData] deleteDataFromShoucang:sqlDelete];
    if (isSuc) {
        NSLog(@"suce");
    }else{
        NSLog(@"``");
    }
    
    [_shouCangArr removeObjectAtIndex:indexPath.row];
    //删除UI indexPath有section和row属性，能确定删除具体的cell
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

}


- (void)backAction{
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
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
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 111;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //获取model对象
    FinderKindModel *model =  _shouCangArr[indexPath.row];
    ComDetailVC *comVC = [ComDetailVC new];
    
    comVC.bookID = [model.channelLinkId intValue];
    comVC.detailID = [model.productId intValue];
    
    [self.navigationController pushViewController:comVC animated:YES];
    
}


- (void)viewWillAppear:(BOOL)animated{
    
    //先从数据库查询所有的数据
    NSString *selectSql = [NSString stringWithFormat:@"select *from Shoucang where userID = '%@'",[AVUser currentUser].objectId];
    FMResultSet *res = [[DataBase shareData] selectAllDataFromTable:selectSql];
    
    NSMutableArray *shoucangArr = [NSMutableArray array];
    //遍历结果集
    while ([res next])
    {
        FinderKindModel *model = [FinderKindModel new];
        //标题
        model.productName = [res stringForColumn:@"title"];
        //内容
        model.productTitleContent = [res stringForColumn:@"content"];
        //价格
        float flostPrice = [[res stringForColumn:@"curprice"] floatValue];
        model.price = [NSNumber numberWithFloat:flostPrice];
        NSLog(@"%@--%@",model.price,[res stringForColumn:@"curprice"]);
        //旧价格
        float oldPrice = [[res stringForColumn:@"oldprice"] floatValue];
        model.originalPrice = [NSNumber numberWithFloat:oldPrice];
        //销售
        float floatSellCount = [[res stringForColumn:@"sellcount"] floatValue];
        model.saledCount = [NSNumber numberWithFloat:floatSellCount];
        
        //预定 id
        model.channelLinkId = [res stringForColumn:@"bookID"];
        //详情id
        model.productId = [res stringForColumn:@"detail"];
        //图片url
        model.URL = [res stringForColumn:@"imgurl"];
        //城市name
        model.cityName = [res stringForColumn:@"cictyName"];
        
        [shoucangArr addObject:model];
    }
    [[DataBase shareData].dataBase close];
    
    
    _shouCangArr = [shoucangArr mutableCopy];
    [self.favoriteTableView reloadData];
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
