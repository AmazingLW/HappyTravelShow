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
#import "RecommendationCell.h"
#import "HomepagePackageModel.h"
#import "CarouselWebViewVC.h"
#import "CategoryVC.h"
#import "ComDetailVC.h"
#import "HomepageScenicModel.h"
#import "LocationVC.h"
#import "ScenicDetailVC.h"

#define kWidth [UIScreen mainScreen].bounds.size.width

@interface HomepageVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CityDelegate>
@property(nonatomic,strong)UICollectionView*collection;

//轮播数组
@property(nonatomic,strong)NSMutableArray*CarouseArray;
//5个分类
@property(nonatomic,strong)NSMutableArray*ProductArr;
//4个标题
@property(nonatomic,strong)NSMutableArray*PackageArr;
//轮播图数组(仅url)
@property(nonatomic,strong)NSMutableArray*ScrollArr;
//热门推荐
@property(nonatomic,strong)NSMutableArray*RecommendationArr;

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
       // self.ScrollArr =[NSMutableArray new];
        for (HomepageHeaderModel*header in _CarouseArray) {
            NSString*url = [header app_picpath];
            [self.ScrollArr addObject:url];
        }
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
    [[HomepageHelper new] requestAllRecommendation:^(NSMutableArray *arr) {
        self.RecommendationArr=[NSMutableArray array];
        self.RecommendationArr = [arr mutableCopy];
        [self.collection reloadData];
    }];
    [[HomepageHelper new] requestAllCity:@"scenicData" WithFinish:^(NSMutableArray *arr) {
        self.ScenicArr = [NSMutableArray new];
        self.ScenicArr = [arr mutableCopy];
        [self.collection reloadData];
        
    }];
    [[HomepageHelper new] requestAllCity:@"cityInfo" WithFinish:^(NSMutableArray *arr) {
        self.cityArr = [NSMutableArray new];
        self.cityArr = [arr mutableCopy];
        [self.collection reloadData];
    }];
    
 
    [self setupCollectionView];
    self.view.backgroundColor = [UIColor orangeColor];
    
    [self creatNavBar];
}

- (void)creatNavBar {

    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"北京∨" style:(UIBarButtonItemStylePlain) target:self action:@selector(locationBBIClicked)];
    self.navigationItem.leftBarButtonItem.tintColor=[UIColor blackColor];

}

- (void)locationBBIClicked {
    
    LocationVC *locationVC = [LocationVC new];
    locationVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:locationVC animated:YES];
    
}

//注册cell
-(void)setupCollectionView{
    
    [_collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [_collection registerNib:[UINib nibWithNibName:@"carouseIFingureCell" bundle:nil] forCellWithReuseIdentifier:@"carousel"];
    [_collection registerNib:[UINib nibWithNibName:@"CategoriesCell" bundle:nil] forCellWithReuseIdentifier:@"cate"];
    [_collection registerNib:[UINib nibWithNibName:@"PackageCell" bundle:nil] forCellWithReuseIdentifier:@"pack"];
    [_collection registerNib:[UINib nibWithNibName:@"RecommendationCell" bundle:nil] forCellWithReuseIdentifier:@"rec"];
    [_collection registerClass:[HotScenicCell class] forCellWithReuseIdentifier:@"hot"];
    
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
    _collection.backgroundColor =[UIColor lightGrayColor];
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
        return self.ProductArr.count;
        
    }else if (section ==2){
        return self.PackageArr.count;
        
    }else if (section ==3){
        return 1;
        
    }else if (section ==4){
        return self.RecommendationArr.count;
    }else{
        return 1;
    }
  
}

//返回item
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        
        carouseIFingureCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"carousel" forIndexPath:indexPath];
//        if (_CarouseArray.count != 0) {
            IanScrollView *scrollView = [[IanScrollView alloc] initWithFrame:CGRectMake(0,0,kWidth,120)];
        
            scrollView.slideImagesArray = _ScrollArr;
            scrollView.ianEcrollViewSelectAction = ^(NSInteger i){
                HomepageHeaderModel*header = self.CarouseArray[i-0];
                if ([header.app_url length] >11) {
                    CarouselWebViewVC*WebVC =[CarouselWebViewVC new];
                    WebVC.url = header.app_url;
                    [self.navigationController pushViewController:WebVC animated:YES];
                }else{
                    NSString *url = [self.CarouseArray[i-0] app_url];
                    NSString *productId = [url substringWithRange:NSMakeRange(0, 5)];
                    NSString *linkId = [url substringWithRange:NSMakeRange(6, 5)];
                    
                    ComDetailVC*detali =[ComDetailVC new];
                    detali.bookID = [linkId integerValue];
                    detali.detailID =[productId integerValue];
                    [self.navigationController pushViewController:detali animated:YES];
                }
            };
            scrollView.PageControlPageIndicatorTintColor = [UIColor whiteColor];
            scrollView.pageControlCurrentPageIndicatorTintColor = [UIColor orangeColor];
            [scrollView startLoading];
            [cell.carousel4view addSubview:scrollView];
//        }
   
        return cell;
    }else if (indexPath.section==1){
        CategoriesCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"cate" forIndexPath:indexPath];
        HomepageHeaderModel*header =self.ProductArr[indexPath.row];
        cell.cate4lable.text=header.title;
        [cell.cate4image sd_setImageWithURL:[NSURL URLWithString:header.app_picpath]placeholderImage:[UIImage imageNamed:@"picholder"]];
        
        return cell;
    }else if (indexPath.section==2){
        PackageCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"pack" forIndexPath:indexPath];
        HomepageHeaderModel*header =self.PackageArr[indexPath.row];
        cell.adTitle4lable.text=header.adTitle;
        cell.asSub4lable.text=header.adSubTitle;
        [cell.path4image sd_setImageWithURL:[NSURL URLWithString:header.n_app_picpath]placeholderImage:[UIImage imageNamed:@"picholder"]];
        cell.layer.borderWidth = 0.3;
        cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
        return cell;
    }else if (indexPath.section==3){
        HotScenicCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"hot" forIndexPath:indexPath];
        
        [cell.b1 setTitle:[self.ScenicArr[0] name] forState:UIControlStateNormal];
        [cell.b1 setTitle:@"" forState:UIControlStateHighlighted];
        [cell.b2 setTitle:[self.ScenicArr[1] name] forState:UIControlStateNormal];
        [cell.b3 setTitle:[self.ScenicArr[2] name] forState:UIControlStateNormal];
        [cell.b4 setTitle:[self.ScenicArr[3] name] forState:UIControlStateNormal];
        [cell.b5 setTitle:[self.ScenicArr[4] name] forState:UIControlStateNormal];
        [cell.b6 setTitle:[self.ScenicArr[5] name] forState:UIControlStateNormal];
        [cell.b7 setTitle:[self.ScenicArr[6] name] forState:UIControlStateNormal];
        [cell.b8 setTitle:[self.ScenicArr[7] name] forState:UIControlStateNormal];
        [cell.b9 setTitle:[self.cityArr[0] name] forState:UIControlStateNormal];
        [cell.b9 setTitle:@"" forState:UIControlStateHighlighted];
        [cell.b10 setTitle:[self.cityArr[1] name] forState:UIControlStateNormal];
        [cell.b11 setTitle:[self.cityArr[2] name] forState:UIControlStateNormal];
        [cell.b12 setTitle:[self.cityArr[3] name] forState:UIControlStateNormal];
        [cell.b13 setTitle:[self.cityArr[4] name] forState:UIControlStateNormal];
        [cell.b14 setTitle:[self.cityArr[5] name] forState:UIControlStateNormal];
        [cell.b15 setTitle:[self.cityArr[6] name] forState:UIControlStateNormal];
        [cell.b16 setTitle:@"更多"forState:UIControlStateNormal];
        cell.userInteractionEnabled = YES;

        cell.delegate =self;
        cell.view.userInteractionEnabled =YES;
        return cell;
    }else if (indexPath.section==4){
        RecommendationCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"rec" forIndexPath:indexPath];
        
        if (self.RecommendationArr.count > 0) {
        HomepagePackageModel*package =self.RecommendationArr[indexPath.row];
        cell.package = package;
        [cell.bigUrl4image sd_setImageWithURL:[NSURL URLWithString:package.bigImageUrl]placeholderImage:[UIImage imageNamed:@"picholder"]];
        }
        cell.layer.borderWidth = 0.3;
        cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
        return cell;
    }else{
        UICollectionViewCell*cell  =[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        return cell;}
    
}
//返回区的高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section ==0) {
        return CGSizeMake(kWidth, 120);
    }else if (indexPath.section ==1) {
        return CGSizeMake(kWidth/5, 65);
    }else if (indexPath.section ==2){
        return CGSizeMake(kWidth/2, 60);
        
    }else if (indexPath.section ==3){
        return CGSizeMake(kWidth, 100);
        
    }else if (indexPath.section ==4){
        return CGSizeMake(kWidth, 200);
        
    }else if (indexPath.section ==5){
        return CGSizeMake(kWidth, 30);
        
    }else{
        
        return CGSizeMake(80, 80);
    }
}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 5.0;
//}

- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section==2||section==3||section==1) {
        return UIEdgeInsetsMake(0, 0, 5, 0);
    }
    return UIEdgeInsetsMake(0, 0, 0, 0); // top, left, bottom, right
}
//点击cell
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==1) {
        if (indexPath.row<4) {
            CategoryVC*cateVC=[CategoryVC new];
            cateVC.urlNum = [self.ProductArr[indexPath.row] app_url];
         //   [self.navigationController pushViewController:cateVC animated:YES];
            UINavigationController *rootNC = [[UINavigationController alloc] initWithRootViewController:cateVC];
            [self presentViewController:rootNC animated:YES completion:nil];
        }else{
        
        CarouselWebViewVC*WebVC =[CarouselWebViewVC new];
        WebVC.url = [self.ProductArr[4] app_url];
            [self.navigationController pushViewController:WebVC animated:YES];}
        
    }else if (indexPath.section == 2){
        if ([[self.PackageArr[indexPath.row] app_url] length]>12) {
        CarouselWebViewVC*WebVC =[CarouselWebViewVC new];
        WebVC.url = [self.PackageArr[0] app_url];
        [self.navigationController pushViewController:WebVC animated:YES];
        }else{
            NSString *url = [self.PackageArr[indexPath.row] app_url];
            NSString *productId = [url substringWithRange:NSMakeRange(0, 5)];
            NSString *linkId = [url substringWithRange:NSMakeRange(6, 5)];
            
            ComDetailVC*detali =[ComDetailVC new];
            detali.bookID = [linkId integerValue];
            detali.detailID =[productId integerValue];
            [self.navigationController pushViewController:detali animated:YES];
            
        }
    }else if (indexPath.section==4){
        
        NSInteger productld=[self.RecommendationArr[indexPath.row] productId];
        NSInteger nlinkId=[self.RecommendationArr[indexPath.row] channelLinkId];
        
        ComDetailVC*detailVC =[ComDetailVC new];
        detailVC.bookID = nlinkId;
        detailVC.detailID = productld;
        //UINavigationController *rootNC = [[UINavigationController alloc] initWithRootViewController:detailVC];
        [self.navigationController showViewController:detailVC sender:nil];
        //[self presentViewController:rootNC animated:YES completion:nil];
        
        
    }
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    
}
- (void)getDetailControllerB9{
    
    CategoryVC*cateVC =[CategoryVC new];
    HomepageScenicModel*a = self.cityArr[0];
    cateVC.CityName =a.name;
    cateVC.CityCode =a.cityCode;
    UINavigationController *rootNC = [[UINavigationController alloc] initWithRootViewController:cateVC];
    [self presentViewController:rootNC animated:YES completion:nil];
    
}
- (void)getDetailControllerB10{
    
    CategoryVC*cateVC =[CategoryVC new];
    HomepageScenicModel*a = self.cityArr[1];
    cateVC.CityName =a.name;
    cateVC.CityCode =a.cityCode;
    UINavigationController *rootNC = [[UINavigationController alloc] initWithRootViewController:cateVC];
    [self presentViewController:rootNC animated:YES completion:nil];
}
- (void)getDetailControllerB11{
    
    CategoryVC*cateVC =[CategoryVC new];
    HomepageScenicModel*a = self.cityArr[2];
    cateVC.CityName =a.name;
    cateVC.CityCode =a.cityCode;
    UINavigationController *rootNC = [[UINavigationController alloc] initWithRootViewController:cateVC];
    [self presentViewController:rootNC animated:YES completion:nil];
}
- (void)getDetailControllerB12{
    
    CategoryVC*cateVC =[CategoryVC new];
    HomepageScenicModel*a = self.cityArr[3];
    cateVC.CityName =a.name;
    cateVC.CityCode =a.cityCode;
    UINavigationController *rootNC = [[UINavigationController alloc] initWithRootViewController:cateVC];
    [self presentViewController:rootNC animated:YES completion:nil];
}
- (void)getDetailControllerB13{
    CategoryVC*cateVC =[CategoryVC new];
    HomepageScenicModel*a = self.cityArr[4];
    cateVC.CityName =a.name;
    cateVC.CityCode =a.cityCode;
    UINavigationController *rootNC = [[UINavigationController alloc] initWithRootViewController:cateVC];
    [self presentViewController:rootNC animated:YES completion:nil];}
- (void)getDetailControllerB14{
    
    CategoryVC*cateVC =[CategoryVC new];
    HomepageScenicModel*a = self.cityArr[5];
    cateVC.CityName =a.name;
    cateVC.CityCode =a.cityCode;
    UINavigationController *rootNC = [[UINavigationController alloc] initWithRootViewController:cateVC];
    [self presentViewController:rootNC animated:YES completion:nil];
}
- (void)getDetailControllerB15{
    
    CategoryVC*cateVC =[CategoryVC new];
    HomepageScenicModel*a = self.cityArr[6];
    cateVC.CityName =a.name;
    cateVC.CityCode =a.cityCode;
    UINavigationController *rootNC = [[UINavigationController alloc] initWithRootViewController:cateVC];
    [self presentViewController:rootNC animated:YES completion:nil];
}
- (void)getDetailControllerB16{
    //更多为城市列表
    
}

- (void)getDetailControllerB1{
    
    ScenicDetailVC*dateailVC =[ScenicDetailVC new];
    HomepageScenicModel*scenic = self.ScenicArr[0];
    dateailVC.scenicID =[scenic.cityId integerValue];
   
    [self presentViewController:dateailVC animated:YES completion:nil];
}

- (void)getDetailControllerB2{
    
    ScenicDetailVC*dateailVC =[ScenicDetailVC new];
    HomepageScenicModel*scenic = self.ScenicArr[1];
    dateailVC.scenicID =[scenic.cityId integerValue];
    [self presentViewController:dateailVC animated:YES completion:nil];
}
- (void)getDetailControllerB3{
    
    ScenicDetailVC*dateailVC =[ScenicDetailVC new];
    HomepageScenicModel*scenic = self.ScenicArr[2];
    dateailVC.scenicID =[scenic.cityId integerValue];
    [self presentViewController:dateailVC animated:YES completion:nil];
}
- (void)getDetailControllerB4{
    
    ScenicDetailVC*dateailVC =[ScenicDetailVC new];
    HomepageScenicModel*scenic = self.ScenicArr[3];
    dateailVC.scenicID =[scenic.cityId integerValue];
    [self presentViewController:dateailVC animated:YES completion:nil];
}
- (void)getDetailControllerB5{
    
    ScenicDetailVC*dateailVC =[ScenicDetailVC new];
    HomepageScenicModel*scenic = self.ScenicArr[4];
    dateailVC.scenicID =[scenic.cityId integerValue];
    [self presentViewController:dateailVC animated:YES completion:nil];
}
- (void)getDetailControllerB6{
    
    ScenicDetailVC*dateailVC =[ScenicDetailVC new];
    HomepageScenicModel*scenic = self.ScenicArr[5];
    dateailVC.scenicID =[scenic.cityId integerValue];
    [self presentViewController:dateailVC animated:YES completion:nil];
}
- (void)getDetailControllerB7{
    
    ScenicDetailVC*dateailVC =[ScenicDetailVC new];
    HomepageScenicModel*scenic = self.ScenicArr[6];
    dateailVC.scenicID =[scenic.cityId integerValue];
    [self presentViewController:dateailVC animated:YES completion:nil];
}
- (void)getDetailControllerB8{
    
    ScenicDetailVC*dateailVC =[ScenicDetailVC new];
    HomepageScenicModel*scenic = self.ScenicArr[7];
    dateailVC.scenicID =[scenic.cityId integerValue];
    [self presentViewController:dateailVC animated:YES completion:nil];
}






-(NSMutableArray*)ScrollArr{
    
    if (_ScrollArr == nil) {
        _ScrollArr = [NSMutableArray new];
    }
    return _ScrollArr;
    
}


@end
