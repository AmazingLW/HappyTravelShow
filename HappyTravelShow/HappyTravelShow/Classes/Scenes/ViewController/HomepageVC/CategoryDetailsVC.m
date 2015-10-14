      //
//  CategoryDetailsVC.m
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/9.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "CategoryDetailsVC.h"
#import "CommonCells.h"
#import "HomepageHelper.h"
#import "AroundKindModel.h"
#import "CommonCells+SetModel.h"
#import "HomepageVC.h"
#import "ComDetailVC.h"
#import "HomepageScenicModel.h"
#import "HomepageCityModel.h"
#import "UIImageView+WebCache.h"
@interface CategoryDetailsVC ()

@property(nonatomic,strong)NSMutableArray*array;
@property(nonatomic,strong)NSMutableArray*FamilyArray;
@property(nonatomic,strong)NSMutableArray*CityArr;
@end

@implementation CategoryDetailsVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
       self.CName =@"北京";
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[HomepageHelper new] requestAllTicket:self.URLNumber withSort:self.sort cityName:self.CName WithFinish:^(NSMutableArray *arr) {
        self.array=[NSMutableArray array];
        self.array = [arr mutableCopy];
        [self.tableView  reloadData];       
    }];
//    [[HomepageHelper new] requestAllFamily:self.URLNumber withSort:self.sort WithFinish:^(NSMutableArray *arr) {
//        self.FamilyArray =[NSMutableArray array];
//        self.FamilyArray= [arr mutableCopy];
//        [self.tableView reloadData];
//    }];
    [[HomepageHelper new] requestAllFamily:self.URLNumber withSort:self.sort cityName:self.CName WithFinish:^(NSMutableArray *arr) {
        self.FamilyArray =[NSMutableArray array];
        self.FamilyArray= [arr mutableCopy];
        [self.tableView reloadData];
    }];
    
    [[HomepageHelper new] requestAllCityDetail:self.CityName cityName:self.CityCode withSort:self.CitySort WithFinish:^(NSMutableArray *arr) {
        self.CityArr =[NSMutableArray array];
        self.CityArr = [arr mutableCopy];
        [self.tableView reloadData];
        
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CommonCells" bundle:nil] forCellReuseIdentifier:@"cell"];
    
  

  
}


//重写初始化方法
- (instancetype)initWithStyle:(UITableViewStyle)style AndWithSort:(NSString*)sort AndWithCitySort:(NSInteger)Citysort{
    if (self = [super initWithStyle:style]) {
        self.sort = sort;
        self.CitySort = Citysort;
    }
    return self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

 
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if ([self.URLNumber length]==2) {
        return self.array.count;
    }else if([self.URLNumber length]==3){
        return self.FamilyArray.count;
    }else{
        return self.CityArr.count;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   CommonCells *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if ([self.URLNumber length]==2) {
    AroundKindModel*kind =self.array[indexPath.row];
    cell.Model = kind;
    }else if([self.URLNumber length]==3){
    AroundKindModel*kind =self.FamilyArray[indexPath.row];
    cell.Model = kind;
    }else{
      HomepageCityModel*city  =self.CityArr[indexPath.row];

        if ([city.homeImageUrl length]<80 ) {
            NSString*url = [NSString stringWithFormat:@"http://cdn5.jinxidao.com/%@",city.homeImageUrl];
         [cell.image4scenes sd_setImageWithURL:[NSURL URLWithString:url ]placeholderImage:[UIImage imageNamed:@"picholder"]];
        }else{
        [cell.image4scenes sd_setImageWithURL:[NSURL URLWithString:city.homeImageUrl ]placeholderImage:[UIImage imageNamed:@"picholder"]];
        }
   
        cell.lab4productName.text = city.productName;
        cell.lab4productTitleContent.text =[NSString stringWithFormat:@"[%@]%@",city.city,city.productTitleContent];
        cell.lab4productTitleContent.numberOfLines = 2;
        cell.lab4originalPrice.text = [NSString stringWithFormat:@"￥%ld",city.retailPrice];
        cell.lab4originalPrice.frame = CGRectMake(236, 80, 50, 21);
        cell.lab4price.text = [NSString stringWithFormat:@"%ld",city.price];
        cell.lab4saledCount.text = [NSString stringWithFormat:@"已售%ld",city.saledCount];

    }
  
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 111;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.URLNumber length]==2) {
 
        AroundKindModel *model = _array[indexPath.row];
        
        NSInteger productId = model.productId;
        NSInteger packageID = model.channelLinkId;
        ComDetailVC *comDetail = [[ComDetailVC alloc] init];
        
        comDetail.bookID = packageID;
        comDetail.detailID = productId;
        
        [self.navigationController pushViewController:comDetail animated:YES];
    }else if([self.URLNumber length]==3){
        AroundKindModel *model = _FamilyArray[indexPath.row];
        NSInteger productId = model.productId;
        NSInteger packageID = model.channelLinkId;
        ComDetailVC *comDetail = [[ComDetailVC alloc] init];
        comDetail.bookID = packageID;
        comDetail.detailID = productId;
        
        [self.navigationController pushViewController:comDetail animated:YES];
    }else{
        
        AroundKindModel *model = _CityArr[indexPath.row];
        NSInteger productId = model.productId;
        NSInteger packageID = model.channelLinkId;
        ComDetailVC *comDetail = [[ComDetailVC alloc] init];
        comDetail.bookID = packageID;
        comDetail.detailID = productId;

        [self.navigationController pushViewController:comDetail animated:YES];
    }

    
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
