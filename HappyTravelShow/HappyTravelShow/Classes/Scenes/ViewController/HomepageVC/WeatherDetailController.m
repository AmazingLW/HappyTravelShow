//
//  WeatherDetailController.m
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/10.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "WeatherDetailController.h"
#import "WeatherDetailCell.h"
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
    //注册
    [self.weatherView registerClass:[WeatherDetailCell class] forCellReuseIdentifier:@"cell"];
    
    
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
        cell.locationView.image=[UIImage imageNamed:@"location.png"];
        cell.lab4weatherPlace.text=@"北京";
        cell.lab4todayData.text=@"今日10月10日";
        cell.lab4todayTemperature.text=@"16/10℃";
        cell.weatherView.image=[UIImage imageNamed:@"w.png"];
        cell.lab4weather.text=@"多云";

    }else{
        cell.tomorrowData.text=@"10月11日";
        cell.afterTomorrowData.text=@"10月12日";
        cell.threeDaysData.text=@"10月13日";
        
        cell.tomorrowWeather.text=@"晴";
        cell.afterTomorrowWeather.text=@"晴";
        cell.threeDaysWeather.text=@"晴转多云";
        
        
        cell.tomorrowTemperature.text=@"22/9℃";
        cell.afterTomorrowTemperature.text=@"23/10℃";
        cell.threeDaysTemperature.text=@"25/11℃";

        
        
        
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
