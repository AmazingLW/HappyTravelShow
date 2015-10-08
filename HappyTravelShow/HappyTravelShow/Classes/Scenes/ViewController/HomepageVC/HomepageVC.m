//
//  HomepageVC.m
//  HappyTravelShow
//
//  Created by Amazing on 15/10/6.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "HomepageVC.h"
#import "HomepageHelper.h"
#import "carouseIFingureCell.h"
#import "CategoriesCell.h"
#import "PackageCell.h"
#import "IanScrollView.h"
#import "HomepageHeaderModel.h"
#import "UIImageView+WebCache.h"
#import "HotScenicCell.h"

@interface HomepageVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView*collection;

//轮播数组
@property(nonatomic,strong)NSMutableArray*CarouseArray;
@property(nonatomic,strong)NSMutableArray*ProductArr;
@property(nonatomic,strong)NSMutableArray*PackageArr;
@property(nonatomic,strong)NSMutableArray*ScrollArr;
@end

@implementation HomepageVC


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIImage *image = [UIImage imageNamed:@"homepage"];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:image tag:1001];
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawview];
    
    
    [[HomepageHelper new] requestAllPackage:@"bannerScroll" WithFinish:^(NSMutableArray *arr) {
        self.CarouseArray=[NSMutableArray array];
        self.CarouseArray = [arr mutableCopy];

        [self.collection reloadData];
    }];
    [[HomepageHelper new] requestAllPackage:@"bannerRound" WithFinish:^(NSMutableArray *arr) {
        self.ProductArr=[NSMutableArray array];
        self.ProductArr = [arr mutableCopy];
        [self.collection reloadData];
    }];
    [[HomepageHelper new] requestAllPackage:@"bannerSquare" WithFinish:^(NSMutableArray *arr) {
        self.PackageArr=[NSMutableArray array];
        self.PackageArr = [arr mutableCopy];
        [self.collection reloadData];
    }];
    
    
    [_collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [_collection registerNib:[UINib nibWithNibName:@"carouseIFingureCell" bundle:nil] forCellWithReuseIdentifier:@"carousel"];
    [_collection registerNib:[UINib nibWithNibName:@"CategoriesCell" bundle:nil] forCellWithReuseIdentifier:@"cate"];
    [_collection registerNib:[UINib nibWithNibName:@"PackageCell" bundle:nil] forCellWithReuseIdentifier:@"pack"];
    [_collection registerClass:[HotScenicCell class] forCellWithReuseIdentifier:@"hot"];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    
}

-(void)drawview{
    
    UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize =CGSizeMake(80, 80);
    flowLayout.sectionInset =UIEdgeInsetsMake(0, 0, 0, 0);
    //flowLayout.headerReferenceSize =CGSizeMake(100, 100);
    flowLayout.minimumLineSpacing =0;
    flowLayout.minimumInteritemSpacing =0;
    self.collection =[[UICollectionView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:flowLayout];
    _collection.backgroundColor =[UIColor whiteColor];
    _collection.dataSource =self;
    _collection.delegate =self;
    [self.view addSubview:_collection];
    
}


//------------------------------collection代理-----------------------------
//返回分区的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 5;
}

//返回Item的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
   
    if (section ==0) {
        return 1;
    }else if (section ==1){
        return 4;
        
    }else if (section ==2){
        return 4;
        
    }else if (section ==3){
        return 1;
        
    }else if (section ==4){
        return 3;
    }else{
        return 1;
    }
  
}

//返回item
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        
        carouseIFingureCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"carousel" forIndexPath:indexPath];
        if (_CarouseArray.count != 0) {
//            IanScrollView *scrollView = [[IanScrollView alloc] initWithFrame:CGRectMake(0,0,375,120)];
//            
//            self.ScrollArr = [NSMutableArray new];
//            for (NSDictionary*dic in _CarouseArray) {
//                NSString*url=dic[@"app_picpath"];
//                [_ScrollArr addObject:url];
//            }
//            
//            
//            scrollView.slideImagesArray = _ScrollArr;
//            [scrollView startLoading];
//            [cell.carousel4view addSubview:scrollView];
        }
   
        return cell;
    }else if (indexPath.section==1){
        CategoriesCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"cate" forIndexPath:indexPath];
//        HomepageHeaderModel*header =self.ProductArr[indexPath.row];
//        cell.cate4lable.text=header.title;
//        [cell.cate4image sd_setImageWithURL:[NSURL URLWithString:header.app_picpath]placeholderImage:[UIImage imageNamed:@"picholder"]];
        
        return cell;
    }else if (indexPath.section==2){
        PackageCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"pack" forIndexPath:indexPath];
//        HomepageHeaderModel*header =self.PackageArr[indexPath.row];
//        cell.adTitle4lable.text=header.adTitle;
//        cell.asSub4lable.text=header.adSubTitle;
//        [cell.path4image sd_setImageWithURL:[NSURL URLWithString:header.n_app_picpath]placeholderImage:[UIImage imageNamed:@"picholder"]];
        cell.layer.borderWidth = 0.3;
        cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
        return cell;
    }else if (indexPath.section==3){
        HotScenicCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"hot" forIndexPath:indexPath];
       
        return cell;
    }else{
        UICollectionViewCell*cell  =[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        return cell;}
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section ==0) {
        return CGSizeMake(375, 120);
    }else if (indexPath.section ==1) {
        return CGSizeMake(93.75, 60);
    }else if (indexPath.section ==2){
        return CGSizeMake(187.5, 60);
        
    }else if (indexPath.section ==3){
        return CGSizeMake(375, 150);
        
    }else if (indexPath.section ==4){
        return CGSizeMake(355, 80);
        
    }else if (indexPath.section ==5){
        return CGSizeMake(375, 30);
        
    }else{
        
        return CGSizeMake(80, 80);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    
}



@end
