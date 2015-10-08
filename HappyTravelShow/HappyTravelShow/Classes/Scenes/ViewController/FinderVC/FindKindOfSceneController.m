//
//  FindKindOfSceneController.m
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/8.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "FindKindOfSceneController.h"
#import "FinderKindModel.h"
#include "FinderHelper.h"
#import "CommonCells.h"
#import "FindMainDetaiCell.h"
#import "UIImageView+WebCache.h"

@interface FindKindOfSceneController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *uiTableView;


@end


@implementation FindKindOfSceneController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    if (self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        self.uiTableView=[[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        
        [self.view addSubview:self.uiTableView];
        self.uiTableView.delegate=self;
        self.uiTableView.dataSource=self;
              
    }
    return self;
    
    
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[FinderHelper sharedHelper]requestDataWithThemeId:self.model.themeId cityCode:@"110100" pageIndex:1 Finish:^{
        [self.uiTableView reloadData];
        
    }];
    
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    //注册
    [self.uiTableView registerNib:[UINib nibWithNibName:@"CommonCells" bundle:nil] forCellReuseIdentifier:@"commonCell"];
    //[self.uiTableView registerClass:[FindMainDetaiCell class] forCellReuseIdentifier:@"FindMainDetaiCell"];
}




//设两个分区

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section==0) {
        return 1;
    }
    return [FinderHelper sharedHelper].kindArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        static NSString * const cellIdentifier = @"FindMainDetaiCell" ;
        FindMainDetaiCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        cell.mainModel=self.model;
        cell.lab4numdescription.text=self.model.numDescription;
        cell.lab4subTitle.text=self.model.subTitle;
       [cell.imgView sd_setImageWithURL:[NSURL URLWithString:self.model.imageUrl]];
        cell.locationView.image=[UIImage imageNamed:@"location.png"];
        cell.lab4cityName.text=self.model.districtName;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;

        if (cell == nil) {
            cell = [[FindMainDetaiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
       
        
        return cell;
    }
    
    
    
    CommonCells *cell=[self.uiTableView dequeueReusableCellWithIdentifier:@"commonCell" forIndexPath:indexPath];
    
   cell.kindModel=[FinderHelper sharedHelper].kindArray[indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    return cell;
    
   
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 350;
    }
    return 100;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 20;
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
