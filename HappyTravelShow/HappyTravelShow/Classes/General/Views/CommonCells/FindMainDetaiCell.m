//
//  FindMainDetaiCell.m
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/8.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "FindMainDetaiCell.h"
#import "UIImageView+WebCache.h"
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHegiht [UIScreen mainScreen].bounds.size.height

@implementation FindMainDetaiCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self drawView];
        
    }
    return self;
    
}






//画图
- (void)drawView{
    
    self.imgView=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, kWidth-10, 180)];
    self.imgView.layer.cornerRadius=5;
    self.imgView.layer.masksToBounds=YES;
    
    self.lab4subTitle=[[UILabel alloc]initWithFrame:CGRectMake(5, 200, kWidth-10, 20)];
    self.lab4subTitle.font=[UIFont systemFontOfSize:17];
   
    self.lab4numdescription=[[UILabel alloc]initWithFrame:CGRectMake(5, 225, kWidth-10, 100)];
    self.lab4numdescription.font=[UIFont systemFontOfSize:14];
    self.lab4numdescription.numberOfLines=0;
    self.lab4numdescription.textColor=[UIColor darkGrayColor];
    
    self.locationView=[[UIImageView alloc]initWithFrame:CGRectMake(kWidth-80, 324.5, 20, 15)];
    
    self.lab4cityName=[[UILabel alloc]initWithFrame:CGRectMake(kWidth-55, 320, 50, 25)];
    self.lab4cityName.font=[UIFont systemFontOfSize:12];
    self.lab4cityName.textColor=[UIColor darkGrayColor];
    //self.contentView.backgroundColor=[UIColor lightGrayColor];

    [self addSubview:self.lab4numdescription];
    [self addSubview:self.imgView];
    [self addSubview:self.lab4subTitle];
    [self addSubview:self.locationView];
    [self addSubview:self.lab4cityName];
}
//重写setter方法

- (void)setMainModel:(FinderMainModel *)mainModel{
   // self.lab4numdescription.text=self.mainModel.numDescription;
    //self.locationView.image=[UIImage imageNamed:@"location.png"];
    
    
    
}








- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
