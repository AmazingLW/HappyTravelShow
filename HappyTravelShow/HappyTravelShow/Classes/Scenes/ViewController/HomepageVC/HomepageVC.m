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

@interface HomepageVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView*collection;
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
    
    [[HomepageHelper shareHelp] requestAllPackageWithFinish:^{
        [self.collection reloadData];
    }];
    
    [_collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [_collection registerNib:[UINib nibWithNibName:@"carouseIFingureCell" bundle:nil] forCellWithReuseIdentifier:@"carousel"];
    [_collection registerNib:[UINib nibWithNibName:@"CategoriesCell" bundle:nil] forCellWithReuseIdentifier:@"cate"];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    
}

-(void)drawview{
    
    UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize =CGSizeMake(80, 80);
    flowLayout.sectionInset =UIEdgeInsetsMake(0, 0, 0, 0);
    //flowLayout.headerReferenceSize =CGSizeMake(100, 100);
    
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
        return cell;
    }else if (indexPath.section==1){
        CategoriesCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"cate" forIndexPath:indexPath];
        return cell;
    }else{
        UICollectionViewCell*cell  =[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        return cell;}
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section ==0) {
        return CGSizeMake(375, 150);
    }else if (indexPath.section ==1) {
        return CGSizeMake(80, 80);
    }else if (indexPath.section ==2){
        return CGSizeMake(180, 75);
        
    }else if (indexPath.section ==3){
        return CGSizeMake(355, 80);
        
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
