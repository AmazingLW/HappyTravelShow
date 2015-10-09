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

@interface CategoryDetailsVC ()

@property(nonatomic,strong)NSMutableArray*array;
@property(nonatomic,strong)NSMutableArray*FamilyArray;
@end

@implementation CategoryDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CommonCells" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [[HomepageHelper new] requestAllTicket:self.URLNumber withSort:self.sort WithFinish:^(NSMutableArray *arr) {
        self.array=[NSMutableArray array];
        self.array = [arr mutableCopy];
        [self.tableView  reloadData];
    }];
    [[HomepageHelper new] requestAllFamily:self.URLNumber withSort:self.sort WithFinish:^(NSMutableArray *arr) {
        self.FamilyArray =[NSMutableArray array];
        self.FamilyArray= [arr mutableCopy];
        [self.tableView reloadData];
    }];
  
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
    }else{
        return self.FamilyArray.count;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   CommonCells *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if ([self.URLNumber length]==2) {
    AroundKindModel*kind =self.array[indexPath.row];
    cell.Model = kind;
    }else{
    AroundKindModel*kind =self.FamilyArray[indexPath.row];
    cell.Model = kind;
    }
  
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 111;
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
