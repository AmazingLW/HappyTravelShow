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
#import "ComDetailVC.h"
#import "UMSocial.h"
#import "FinderURL.h"
#import "UIImage+WebP.h"
#import "UIImageView+WebCache.h"

@interface FindKindOfSceneController ()<UITableViewDataSource,UITableViewDelegate,UMSocialUIDelegate>
@property(nonatomic,strong)UITableView *uiTableView;


@end


@implementation FindKindOfSceneController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        self.uiTableView=[[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        
        [self.view addSubview:self.uiTableView];
        self.uiTableView.delegate=self;
        self.uiTableView.dataSource=self;
        

       /// self.navigationItem.hidesBackButton=YES;
        //self.cityCode = self.model.themeId ;

       //自定义rightBarButtonItem
        UIButton *rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
        rightButton.frame=CGRectMake(0, 0, 30, 30);
        [rightButton setImage:[UIImage imageNamed:@"share.png"] forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *rightButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightButton];
        
        self.navigationItem.rightBarButtonItem=rightButtonItem;
        
        
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
//分享
- (void)shareAction:(UIButton *)sender{
    
 
    NSString *url=[NSString stringWithFormat:@"http://m.yaochufa.com/discovery/d_%@",self.model.themeId];
    
    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:self.model.imageUrl];
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"561dd14067e58e135400590f"
                                      shareText:[NSString stringWithFormat:@"<%@>%@,     %@",self.model.title,self.model.subTitle,url]
                                     shareImage:nil
                                shareToSnsNames:[NSArray arrayWithObjects:  UMShareToSina,UMShareToWechatTimeline,UMShareToWechatSession,UMShareToQzone,UMShareToQQ,UMShareToTencent,UMShareToRenren,UMShareToSms,UMShareToDouban,UMShareToEmail, nil ]
                                       delegate:self];
 
    
}
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
       
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"分享成功" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alertView show];
    }else{
    
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"分享失败" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    
    [alertView show];
    }
    
}






- (void)viewDidAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[FinderHelper sharedHelper]requestDataWithThemeId:self.model.themeId cityCode:@"110100" pageIndex:@"1" Finish:^{
        [self.uiTableView reloadData];
        
    }];
    
    
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    //自定义title颜色
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    //[customLab setTextColor:[UIColor cyanColor]];
    customLab.text=self.model.title;
    customLab.font = [UIFont boldSystemFontOfSize:20];
    self.navigationItem.titleView = customLab;
  
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    //注册
    [self.uiTableView registerNib:[UINib nibWithNibName:@"CommonCells" bundle:nil] forCellReuseIdentifier:@"commonCell"];
 
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



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ComDetailVC *comVC = [ComDetailVC new];
    if (indexPath.section==1) {
        
    //获取model对象
    FinderKindModel *model = [FinderHelper sharedHelper].kindArray[indexPath.row];
    comVC.bookID = [model.channelLinkId intValue];
    comVC.detailID = [model.productId intValue];
    [self.navigationController pushViewController:comVC animated:YES];

    }
    
    
}


- (void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
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
