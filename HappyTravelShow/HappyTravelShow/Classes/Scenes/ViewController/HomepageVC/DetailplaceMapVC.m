//
//  DetailplaceMapVC.m
//  HappyTravelShow
//
//  Created by Amazing on 15/10/12.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "DetailplaceMapVC.h"
#import <BaiduMapAPI/BMapKit.h>

@interface DetailplaceMapVC ()<BMKMapViewDelegate>

@property (nonatomic,strong) BMKMapView * mapView;

@end

@implementation DetailplaceMapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.vcTitle;
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    
    [self drawMapView];
}

- (void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
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
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
    [self.view addSubview:backView];
    backView.backgroundColor = [UIColor whiteColor];
    
    self.mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)];
    [backView addSubview:self.mapView];
    
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
