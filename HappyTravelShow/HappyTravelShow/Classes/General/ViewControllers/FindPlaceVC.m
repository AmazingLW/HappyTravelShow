//
//  FindPlaceVC.m
//  HappyTravelShow
//
//  Created by Amazing on 15/10/9.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "FindPlaceVC.h"
#import <BaiduMapAPI/BMapKit.h>
#import "CurrentPlaceSkyCell.h"
#import "DetailModel.h"
#import "SpecificWeatherCell.h"



@interface FindPlaceVC ()<UITableViewDelegate,UITableViewDataSource,BMKMapViewDelegate>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) BMKMapView * mapView;
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UILabel * placeLabel;

@end

@implementation FindPlaceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 350, kScreenWidth, kScreenHeight - 280 - 64) style:UITableViewStyleGrouped];
    self.title = @"查看地址";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;
    
    [self drawMapView];
    self.view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.tableView];
}

- (void) viewDidAppear:(BOOL)animated {
    // 添加一个PointAnnotation
    BMKPointAnnotation * annotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude = self.latitude ;
    coor.longitude = self.longitude;
    annotation.coordinate = coor;
    annotation.title = self.placeTitle;

    
    BMKCoordinateRegion viewRegion = BMKCoordinateRegionMake(coor, BMKCoordinateSpanMake(0.01f,0.01f));
    BMKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
    [_mapView setRegion:adjustedRegion animated:YES];
    
    [_mapView addAnnotation:annotation];
    [_mapView selectAnnotation:annotation animated:YES];
}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView * newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
}

- (void)drawMapView{

    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 280)];
    [self.view addSubview:backView];
    backView.backgroundColor = [UIColor whiteColor];
    
    self.mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 160)];
    [backView addSubview:self.mapView];
    
    //标题
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 175, 200, 30)];
    self.titleLabel.text = self.placeTitle;
    [backView addSubview:self.titleLabel];
    
    //地址
    self.placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 205, 250, 60)];
    self.placeLabel.numberOfLines = 0;
    self.placeLabel.text = [NSString stringWithFormat:@"地址:%@",self.address];
    self.placeLabel.textColor = [UIColor grayColor];
    [backView addSubview:self.placeLabel];
  
}



// 分区为天气
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isHaveWeatherInfo) {
        return 105;
    }else{
        if (indexPath.row == 0) {
            return 0;
        }else{
            return 50;
        }
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 13, 20, 20)];
    imgView.image = [UIImage imageNamed:@"tianqi"];
    [backView addSubview:imgView];
    
    backView.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 13, 75, 20)];
    titleLabel.text = @"当地天气";
    [backView addSubview:titleLabel];
    
    UILabel *fromLabel = [[UILabel alloc] initWithFrame:CGRectMake(175, 13, 180, 20)];
    fromLabel.text = @"以下天气由中国天气网提供";
    fromLabel.font = [UIFont systemFontOfSize:14];
    fromLabel.textColor = [UIColor grayColor];
    [backView addSubview:fromLabel];
    
    return backView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        static NSString * cellIdentifier = @"tempCell";
        CurrentPlaceSkyCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[CurrentPlaceSkyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        if (_isHaveWeatherInfo) {
            DetailModel *model = self.weatherArr[0];
            [cell setCurrentDayWithCityName:self.cityName temperature:model.temperature date:model.date typeImg:model.dayPictureUrl type:model.weather];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        static NSString * cellIdentifier = @"dateCell";
        SpecificWeatherCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[SpecificWeatherCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        if (_isHaveWeatherInfo) {
            [cell setSpecificeViewWithArr:self.weatherArr];
        }else{
            cell.textLabel.text = @"     暂无天气预报信息";
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }

}



- (void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
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
