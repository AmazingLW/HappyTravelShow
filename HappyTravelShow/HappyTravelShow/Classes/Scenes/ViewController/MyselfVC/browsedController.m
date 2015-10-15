//
//  browsedController.m
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/10.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "browsedController.h"
#import "CommonCells.h"

@interface browsedController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *browsedTableView;


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
        
    }
    return self;
    
}

- (void)backAction{
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //注册
    [self.browsedTableView registerNib:[UINib nibWithNibName:@"CommonCells" bundle:nil] forCellReuseIdentifier:@"cell"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 10;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CommonCells *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 111;
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
