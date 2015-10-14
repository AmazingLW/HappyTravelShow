//
//  ChangePersonInfoVC.m
//  HappyTravelShow
//
//  Created by Amazing on 15/10/13.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "ChangePersonInfoVC.h"
#import "NameEmailVC.h"


@interface ChangePersonInfoVC ()

@property (nonatomic,strong) UILabel * phoneLabel;
@property (nonatomic,strong) UILabel * nameLabel;
@property (nonatomic,strong) UILabel * emailLabel;

@property (nonatomic,strong) UILabel * genderLabel;
@property (nonatomic,strong) UILabel * birthLabel;
@property (nonatomic,strong) UILabel * addressLabel;

@end

@implementation ChangePersonInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    }else if (section == 1){
        return 3;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"changeCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"changeCell"];
    }
    
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.textLabel.text = @"手    机:";

        self.phoneLabel.text = self.tel;
        [cell.contentView addSubview:self.phoneLabel];
    }else if (indexPath.section == 0 && indexPath.row == 1){
        cell.textLabel.text = @"姓    名:";
        self.nameLabel.text = self.name;
        [cell.contentView addSubview:self.nameLabel];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if (indexPath.section == 0 && indexPath.row == 2){
        cell.textLabel.text = @"邮    箱:";
        
        if (self.email == nil) {
            self.emailLabel.text = @"请输入您的常用邮箱";
            self.emailLabel.textColor = [UIColor grayColor];
        }else{
            self.emailLabel.text = self.email;
            self.emailLabel.textColor = [UIColor blackColor];
        }
        
        [cell.contentView addSubview:self.emailLabel];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if (indexPath.section == 1 && indexPath.row == 0){
        cell.textLabel.text = @"性    别:";
        
        if (self.gender == nil) {
            self.genderLabel.text = @"请输入您的性别";
            self.genderLabel.textColor = [UIColor grayColor];
        }else{
            self.genderLabel.text = self.gender;
            self.genderLabel.textColor = [UIColor blackColor];
        }
        
        [cell.contentView addSubview:self.genderLabel];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if (indexPath.section == 1 && indexPath.row == 1){
        cell.textLabel.text = @"生    日:";
        
        if (self.birth == nil) {
            self.birthLabel.text = @"请输入您的性别";
            self.birthLabel.textColor = [UIColor grayColor];
        }else{
            self.birthLabel.text = self.birth;
            self.birthLabel.textColor = [UIColor blackColor];
        }
        
        [cell.contentView addSubview:self.birthLabel];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if (indexPath.section == 1 && indexPath.row == 2){
        cell.textLabel.text = @"常居地:";
        
        if (self.address == nil) {
            self.addressLabel.text = @"请输入您的常住地";
            self.addressLabel.textColor = [UIColor grayColor];
        }else{
            self.addressLabel.text = self.birth;
            self.addressLabel.textColor = [UIColor blackColor];
        }

        [cell.contentView addSubview:self.addressLabel];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if (indexPath.section == 2 && indexPath.row == 0){
//        cell.textLabel.text = @"邮      箱:";
//        [cell.contentView addSubview:self.emailLabel];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}


#pragma mark ----点击事件-----
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 1) {
        //修改姓名
        NameEmailVC *nameVC = [NameEmailVC new];
        nameVC.isChangeName = YES;
        nameVC.name = self.nameLabel.text;
        
        
        nameVC.changeBlock = ^(NSString *changeContent){
            self.nameLabel.text = changeContent;
        };
        
        nameVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nameVC animated:YES];
        nameVC.hidesBottomBarWhenPushed = YES;
    }else if (indexPath.section == 0 && indexPath.row == 2){
        //修改邮箱
        NameEmailVC *nameVC = [NameEmailVC new];
        nameVC.isChangeName = NO;
        nameVC.email = self.emailLabel.text;
        
        nameVC.changeBlock = ^(NSString *changeContent){
            self.emailLabel.text = changeContent;
        };

        nameVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nameVC animated:YES];
        nameVC.hidesBottomBarWhenPushed = YES;
    }else if (indexPath.section == 1 && indexPath.row == 0){
        //修改性别
        
    }
}




#pragma mark ------lazy load-------
- (UILabel *)phoneLabel{
    if (_phoneLabel == nil) {
        _phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 0, kScreenWidth - 90, 50)];
    }
    return _phoneLabel;
}

- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 0, kScreenWidth - 90, 50)];
    }
    return _nameLabel;
}

- (UILabel *)emailLabel{
    if (_emailLabel == nil) {
        _emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 0, kScreenWidth - 90, 50)];
    }
    return _emailLabel;
}

- (UILabel *)genderLabel{
    if (_genderLabel == nil) {
        _genderLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 0, kScreenWidth - 90, 50)];
    }
    return _genderLabel;
}

- (UILabel *)birthLabel{
    if (_birthLabel == nil) {
        _birthLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 0, kScreenWidth - 90, 50)];
    }
    return _birthLabel;
}

- (UILabel *)addressLabel{
    if (_addressLabel == nil) {
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 0, kScreenWidth - 90, 50)];
    }
    return _addressLabel;
}







/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
