//
//  AlterVC.m
//  HappyTravelShow
//
//  Created by Amazing on 15/10/14.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "AlterVC.h"
#import "HZAreaPickerView.h"

@interface AlterVC ()<HZAreaPickerDelegate>

@property (strong, nonatomic) HZAreaPickerView *locatePicker;
@property (nonatomic,strong) UIView *subView;
@property (nonatomic,strong) NSString * strLocation;


@end

@implementation AlterVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)drawView{
    _subView = [[UIView alloc] initWithFrame:CGRectMake(50, 250, 250, 200)];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    _subView.center = self.view.center;
    [self.view addSubview:_subView];
    
}

- (void)touchCell{
    [self drawView];
    [self cancelLocatePicker];
    self.locatePicker = [[HZAreaPickerView alloc] initWithStyle:HZAreaPickerWithStateAndCityAndDistrict delegate:self];
    [self.locatePicker showInView:_subView];
}

-(void)cancelLocatePicker
{
    [self.locatePicker cancelPicker];
    self.locatePicker.delegate = nil;
    self.locatePicker = nil;
}


- (void)pickerDidChaneStatus:(HZAreaPickerView *)picker{
    self.strLocation = [NSString stringWithFormat:@"%@ %@ %@", picker.locate.state, picker.locate.city, picker.locate.district];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //回调
    if (self.strLocation != nil) {
        self.areaBlock(self.strLocation);
    }
    [self removeFromParentViewController];
    [self.view removeFromSuperview];
    
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
