//
//  WeatherDetailController.m
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/10.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "WeatherDetailController.h"
#import "WeatherDetailCell.h"
#import "SkyModel.h"
#import "UIImageView+WebCache.h"

#define kWidth [UIScreen mainScreen].bounds.size.width



@interface WeatherDetailController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *weatherView;



@end

@implementation WeatherDetailController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    if (self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        self.weatherView=[[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        
        self.weatherView.delegate=self;
        self.weatherView.dataSource=self;
        self.weatherView.scrollEnabled=NO;
        [self.view addSubview:self.weatherView];
        
        //天气label
        UILabel *weatherLabel=[[UILabel alloc]initWithFrame:CGRectMake(kWidth/2-80, 385, kWidth-160, 20)];
        weatherLabel.text=@"以上天气由中国天气网提供";
        weatherLabel.font=[UIFont systemFontOfSize:13];
        weatherLabel.textColor=[UIColor lightGrayColor];
        [self.view addSubview:weatherLabel];
        
        
        
    }
    return self;
    
    
}






- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    //注册
    [self.weatherView registerClass:[WeatherDetailCell class] forCellReuseIdentifier:@"cell"];
    
    
}

- (void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WeatherDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (cell==nil) {
        cell=[[WeatherDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        

    }
    
    if (indexPath.row==0) {
        
        SkyModel *skyModel = self.skyArr[0];
        SkyModel *skySubModel = skyModel.skyArr[0];
        cell.locationView.image=[UIImage imageNamed:@"location.png"];
        cell.lab4weatherPlace.text= skyModel.currentCity;
        
        NSArray *dateArr = [skySubModel.date componentsSeparatedByString:@" "];
        cell.lab4todayData.text= [NSString stringWithFormat:@"今日%@",dateArr[1]];
        cell.lab4todayTemperature.text= skySubModel.temperature;
        [cell.weatherView sd_setImageWithURL:[NSURL URLWithString:skySubModel.dayPictureUrl]];
        cell.lab4weather.text= skySubModel.weather;

    }else{
        
        SkyModel *skyModel = self.skyArr[0];
        SkyModel *skySubModel1 = skyModel.skyArr[1];
        SkyModel *skySubModel2 = skyModel.skyArr[2];
        SkyModel *skySubModel3 = skyModel.skyArr[3];
        
        cell.tomorrowData.text= skySubModel1.date;
        cell.afterTomorrowData.text= skySubModel2.date;
        cell.threeDaysData.text= skySubModel3.date;
        
        cell.tomorrowWeather.text= skySubModel1.weather;
        cell.afterTomorrowWeather.text= skySubModel2.weather;
        cell.threeDaysWeather.text= skySubModel3.weather;
        
        
        cell.tomorrowTemperature.text= skySubModel1.temperature;
        cell.afterTomorrowTemperature.text= skySubModel2.temperature;
        cell.threeDaysTemperature.text= skySubModel3.temperature;

    }
    
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 1;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0) {
        return 170;
    }
    
    return 130;
   
   
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
