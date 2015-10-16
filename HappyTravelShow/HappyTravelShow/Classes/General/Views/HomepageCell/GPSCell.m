//
//  GPSCell.m
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/12.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "GPSCell.h"
#import "HomepageHelper.h"
#import "HotCityCell.h"
#import "HomepageCityListModel.h"
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

@interface GPSCell ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)NSMutableArray*array;
@end

@implementation GPSCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
      [self setupcell];
    
//        [self.collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [self.collection registerClass:[HotCityCell class] forCellWithReuseIdentifier:@"cell"];
        
        [[HomepageHelper new] requestallCityList:@"hotCity" WithFinish:^(NSMutableArray *arr) {
            self.array =[NSMutableArray array];
            self.array = [arr mutableCopy];
            [self.collection reloadData];
        }];
        
    }
    return self;
}

-(void)setupcell{
    
    UILabel*Lable =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kWidth, 40)];
    //Lable.text=@"GPS定位: 北京";
    Lable.text =@"请选择城市";
    Lable.backgroundColor =[UIColor whiteColor];
    
    UILabel*HotCityLable =[[UILabel alloc]initWithFrame:CGRectMake(5, 45, 50, 20)];
    HotCityLable.text=@"热门城市";
    HotCityLable.backgroundColor =[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];

    HotCityLable.font =[UIFont systemFontOfSize:12];
    
    
    UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize =CGSizeMake((kWidth-20)/3, 30);
    flowLayout.sectionInset =UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.minimumLineSpacing =0;
    flowLayout.minimumInteritemSpacing =0;
    self.collection =[[UICollectionView alloc]initWithFrame:CGRectMake(10, 70, kWidth-20, 90) collectionViewLayout:flowLayout];
    _collection.backgroundColor =[UIColor cyanColor];
    _collection.backgroundColor =[UIColor whiteColor];
    self.collection.delegate = self;
    self.collection.dataSource = self;
    self.contentView.backgroundColor =[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    [self addSubview:Lable];
    [self.contentView addSubview:HotCityLable];
    [self.contentView addSubview:self.collection];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 9;

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
     HotCityCell*cell  =[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.layer.borderWidth = 0.3;
    cell.layer.borderColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1].CGColor;
    cell.backgroundColor =[UIColor whiteColor];
    if (_array.count>0) {
      HomepageCityListModel*city  =_array[indexPath.row];
        cell.lable.text =city.cityNameAbbr;
    }
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
   
    HomepageCityListModel *h = _array[indexPath.row];
   self.block(h.cityNameAbbr,h.cityName,h.cityCode);
    //[self.navigationController popViewControllerAnimated:YES];
      // [self dismissModalViewControllerAnimated:NO];
    
   // UIWindow *window = [[UIApplication sharedApplication].delegate window];
   // window.rootViewController = mainVC;
    
    
}
- (void)awakeFromNib {
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}

@end
