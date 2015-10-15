//
//  browsedController.m
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/10.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "browsedController.h"
#import "CommonCells.h"
#import "ComDetailVC.h"

@interface browsedController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)UITableView *browsedTableView;

@property (nonatomic,strong) NSMutableArray * hisDataArr;

@end

@implementation browsedController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    if (self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        self.browsedTableView=[[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        self.browsedTableView.delegate=self;
        self.browsedTableView.dataSource=self;
        
        [self.view addSubview:self.browsedTableView];
        
        //自定义leftBarButtonItem
        
        UIButton *leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
        leftButton.frame=CGRectMake(0, 0, 30, 30);
        [leftButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *leftButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
        self.navigationItem.leftBarButtonItem=leftButtonItem;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 72, 20)];
        label.text = @"清空记录";
        label.textColor = [UIColor orangeColor];
        //编辑手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteHisDataAction)];
        [label addGestureRecognizer:tap];
        label.userInteractionEnabled = YES;
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:label];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
    return self;
    
}

- (void)backAction{

    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (void)deleteHisDataAction{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"是否清空所有浏览记录?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alertView show];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"历史记录";
    //注册
    [self.browsedTableView registerNib:[UINib nibWithNibName:@"CommonCells" bundle:nil] forCellReuseIdentifier:@"cell"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _hisDataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CommonCells *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.kindModel = _hisDataArr[indexPath.row];
    
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
    FinderKindModel *model =  _hisDataArr[indexPath.row];
    ComDetailVC *comVC = [ComDetailVC new];
    
    comVC.bookID = [model.channelLinkId intValue];
    comVC.detailID = [model.productId intValue];
    
    [self.navigationController pushViewController:comVC animated:YES];
}


//从数据库获取历史信息 倒序排
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //先从数据库查询所有的数据
    NSString *selectSql = @"select *from History order by id desc";
    FMResultSet *res = [[DataBase shareData] selectAllDataFromTable:selectSql];
    
    NSMutableArray *lishiArr = [NSMutableArray array];
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
        
        [lishiArr addObject:model];
    }
    [[DataBase shareData].dataBase close];
    
    _hisDataArr = [lishiArr mutableCopy];
    [self.browsedTableView reloadData];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        //清空历史记录
        [[DataBase shareData] deleteAll:@"History"];
        [_hisDataArr removeAllObjects];
        [self.browsedTableView reloadData];
    }
}






- (NSMutableArray *)hisDataArr{
    if (_hisDataArr == nil) {
        _hisDataArr = [NSMutableArray array];
    }
    return _hisDataArr;
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
