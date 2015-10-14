//
//  GenderBirthVC.m
//  HappyTravelShow
//
//  Created by Amazing on 15/10/14.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "GenderBirthVC.h"

@interface GenderBirthVC ()<UIPickerViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UIView * genderView;
@property (nonatomic,strong) UIView * birthView;
@property (nonatomic,strong) NSString * strDate; //设置的日期
@property (nonatomic,strong) UIImageView * selectedIcon;


@end

@implementation GenderBirthVC

- (void)viewDidLoad {
    [super viewDidLoad];

}


- (void) drawGenderView{
    _genderView = [[UIView alloc] initWithFrame:CGRectMake(50, 210, 250, 120)];
    self.view.backgroundColor = [UIColor clearColor];

    [self.view addSubview:_genderView];
    
    //加个tableview
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 250, 120) style:UITableViewStyleGrouped];

    tableView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [_genderView addSubview:tableView];
    
}

- (void) drawBirthView{
    _birthView = [[UIView alloc] initWithFrame:CGRectMake(5, 180, kScreenWidth - 10, 216)];
    _birthView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_birthView];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0,0.0,0,216)];
    [_birthView addSubview:datePicker];
    datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    [datePicker addTarget:self action:@selector(dateValueChange:) forControlEvents:UIControlEventValueChanged];

    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 1, 140, 37)];
    label.textColor = [UIColor orangeColor];
    label.font = [UIFont systemFontOfSize:19];
    label.text = @"请选择性别";
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 38, 250, 2)];
    lineView.backgroundColor = [UIColor orangeColor];
    
    
    [backView addSubview:lineView];
    [backView addSubview:label];
    return backView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    
    if (indexPath.row == 0) {
        cell.textLabel.textColor = [UIColor blackColor];
        if (_isFemale) {
            cell.textLabel.textColor = [UIColor orangeColor];
            [cell.contentView addSubview:self.selectedIcon];
        }
        cell.textLabel.text = @"女";
    }else{
        cell.textLabel.textColor = [UIColor blackColor];
        if (!_isFemale) {
            cell.textLabel.textColor = [UIColor orangeColor];
            [cell.contentView addSubview:self.selectedIcon];
        }
        cell.textLabel.text = @"男";
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        //女生
        self.strGender = @"女";
        _isFemale = YES;
    }else{
        self.strGender = @"男";
        _isFemale = NO;
    }

    [tableView reloadData];
}

- (UIImageView *)selectedIcon{
    if (_selectedIcon == nil) {
        _selectedIcon = [[UIImageView alloc] initWithFrame:CGRectMake(250 - 50, 2, 30, 30)];
        _selectedIcon.image = [UIImage imageNamed:@"22"];
    }
    return _selectedIcon;
}



- (void)dateValueChange:(id)sender{
    UIDatePicker *datepicker = (UIDatePicker *)sender;
    _strDate = [self stringFromDate:datepicker.date];
    
}


- (NSString *)stringFromDate:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    
    
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];

    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //回调
    
    if (_selectedIcon != nil) {
        //是性别
        self.birthandGenderBlock(self.strGender);
    }else{
        if (_strDate != nil) {
            self.birthandGenderBlock(_strDate);
        }
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
