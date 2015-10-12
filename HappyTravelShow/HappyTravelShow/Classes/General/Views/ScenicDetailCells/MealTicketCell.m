//
//  MealTicketCell.m
//  HappyTravelShow
//
//  Created by Amazing on 15/10/11.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "MealTicketCell.h"
#import "MealDetailCell.h"

@interface MealTicketCell ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *_backView;
}

@property (nonatomic,strong) UIScrollView * scrollView;
@property (nonatomic,strong) UITableView * mealTableView;
@property (nonatomic,strong) UITableView * ticketTableView;


@end



@implementation MealTicketCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 50)];
        [self addSubview:_backView];
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 50)];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.tag = 601;
        [_backView addSubview:_scrollView];
        _scrollView.contentSize = CGSizeMake(kScreenWidth * 2, kScreenHeight - 50);
        

        _mealTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 50) style:UITableViewStyleGrouped];
        _mealTableView.tag = 501;
//        _mealTableView.bounces = NO; //禁止反弹
        [_scrollView addSubview:_mealTableView];
        _mealTableView.delegate = self;
        _mealTableView.dataSource = self;
        
        _ticketTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight - 50) style:UITableViewStyleGrouped];
        _ticketTableView.tag = 502;
//        _ticketTableView.bounces = NO;
        [_scrollView addSubview:_ticketTableView];
        _ticketTableView.delegate = self;
        _ticketTableView.dataSource = self;

        
    
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 230;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 501) {
        if (self.mealTicketArr.count != 0) {
            return self.mealTicketArr.count;
        }
    }else{
        if (self.ticketArr.count != 0) {
            return self.ticketArr.count;
        }
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellIdentifier = @"baoCell";
    MealDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[MealDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (tableView.tag == 501) {
        [cell setViewWithModel:self.mealTicketArr[indexPath.row]];
    }else if(tableView.tag == 502){
        [cell setViewWithModel:self.ticketArr[indexPath.row]];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.tag == 601) {
        if (scrollView.contentOffset.x == 0) {
            self.block(@"left");
        }else{
            self.block(@"right");
        }
        
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.tag == 501) {
        //套餐tableview 滚动
        if (scrollView.contentOffset.y <= 0) {
            scrollView.scrollEnabled = NO;
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(openScrollEnable)]) {
                [self.delegate openScrollEnable];
            }
        }
    }else if (scrollView.tag == 502){
        //门票tableview 滚动
        if (scrollView.contentOffset.y <= 0) {
            scrollView.scrollEnabled = NO;
            if (self.delegate && [self.delegate respondsToSelector:@selector(openScrollEnable)]) {
                [self.delegate openScrollEnable];
            }

        }
    }
}






- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
