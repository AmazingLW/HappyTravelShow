//
//  FindMainDetaiCell.m
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/8.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "FindMainDetaiCell.h"
#import "UIImageView+WebCache.h"

@implementation FindMainDetaiCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self drawView];
        
    }
    return self;
    
}







- (void)drawView{
    

    self.imgView.frame=CGRectMake(5, 5, 360, 140);
    self.lab4subTitle.frame=CGRectMake(5, 150, 360, 20);
    self.lab4subTitle.font=[UIFont systemFontOfSize:17];
    
    self.lab4cityName.frame=CGRectMake(345, 280, 30, 15);
    self.locationView.frame=CGRectMake(330, 280, 20, 15);
    self.lab4numdescription=[[UILabel alloc]initWithFrame:CGRectMake(5, 175, 360, 100)];
    self.lab4numdescription.backgroundColor=[UIColor redColor];
    [self addSubview:self.lab4numdescription];

    

}
//重写setter方法

- (void)setMainModel:(FinderMainModel *)mainModel{
    self.lab4numdescription.text=self.mainModel.description;
    
    
    
    
}








- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
