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
#import "FindKindOfSceneController.h"
#import "MJRefresh.h"
#import "ScrollVC.h"
#import "SearchVC.h"
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
//城市标题
@property(nonatomic,strong)NSString*string,*cityName,*cityCode;
@end

@implementation HomepageVC


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIImage *image = [UIImage imageNamed:@"homepage"];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:image tag:1001];
        self.cityCode =@"110100";
        self.string =@"北京";
        self.cityName =@"北京";
        
        UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 70, 29)];
        textfield.enabled = NO;
        textfield.placeholder = @"搜索目的地/景点/酒店";
        textfield.backgroundColor = [UIColor lightGrayColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        
        label.text = @"🔍";
        // label.backgroundColor = [UIColor redColor];
        textfield.rightView = label;
        textfield.rightViewMode = UITextFieldViewModeAlways;
        self.navigationItem.titleView = textfield;
        
        
        UIView *a = [[UIView alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width - 70, 29)];
        a.backgroundColor = [UIColor redColor];
        [a addSubview:textfield];
        self.navigationItem.titleView = a;
    
        //textfield添加手势 跳转
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(skip:)];
        //  tap.numberOfTapsRequired = 1;
        
        
        [a addGestureRecognizer:tap];

    }
    
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.string!=nil) {
        self.navigationItem.leftBarButtonItem.title = [NSString stringWithFormat:@"%@v",self.string];

    }

    [[HomepageHelper new] requestAllPackage:@"bannerScroll" withCityCode:self.cityCode WithFinish:^(NSMutableArray *arr) {
        //self.CarouseArray=[NSMutableArray array];
        self.CarouseArray = [arr mutableCopy];
        
         self.ScrollArr =[NSMutableArray array];
        for (HomepageHeaderModel*header in _CarouseArray) {
            NSString*url = [header app_picpath];
            [self.ScrollArr addObject:url];
        }
        [self.collection reloadData];
    }];
    [[HomepageHelper new] requestAllPackage:@"bannerRound"withCityCode:self.cityCode WithFinish:^(NSMutableArray *arr) {
        //self.ProductArr=[NSMutableArray array];
        self.ProductArr = [arr mutableCopy];
        [self.collection reloadData];
    }];
    [[HomepageHelper new] requestAllPackage:@"bannerSquare"withCityCode:self.cityCode WithFinish:^(NSMutableArray *arr) {
       // self.PackageArr=[NSMutableArray array];
        self.PackageArr = [arr mutableCopy];
        [self.collection reloadData];
    }];

    
    [[HomepageHelper new]requestAllRecommendation:self.cityCode WithFinish:^(NSMutableArray *arr) {
        //self.RecommendationArr=[NSMutableArray array];
        self.RecommendationArr = [arr mutableCopy];
        [self.collection reloadData];
    }];
    
    [[HomepageHelper new] requestAllCity:@"scenicData" withCityCode:self.cityCode WithFinish:^(NSMutableArray *arr) {
       // self.ScenicArr = [NSMutableArray new];
        self.ScenicArr = [arr mutableCopy];
        [self.collection reloadData];
    }];
    
    [[HomepageHelper new] requestAllCity:@"cityInfo" withCityCode:self.cityCode WithFinish:^(NSMutableArray *arr) {
        //self.cityArr = [NSMutableArray new];
        self.cityArr = [arr mutableCopy];
        [self.collection reloadData];
    }];
    
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"change"object:nil userInfo:@{@"cityName":self.string,@"citycode":self.cityCode}];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawview];
    
    
    //初始化数据库并创建表
    [[DataBase shareData] createDataBase];
    [[DataBase shareData] createTable];
    
    
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setupCollectionView];
    self.view.backgroundColor = [UIColor orangeColor];
    [self creatNavBar];
    
  __weak typeof(self) weakself = self;
    
  self.collection.header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
      
      [[HomepageHelper new] requestAllPackage:@"bannerScroll" withCityCode:self.cityCode WithFinish:^(NSMutableArray *arr) {
          //self.CarouseArray=[NSMutableArray array];
          self.CarouseArray = [arr mutableCopy];
       
          [weakself.collection reloadData];
          [[weakself.collection header] endRefreshing];
      }];
      
      [[HomepageHelper new]requestAllRecommendation:self.cityCode WithFinish:^(NSMutableArray *arr) {
          //self.RecommendationArr=[NSMutableArray array];
          self.RecommendationArr = [arr mutableCopy];
          [self.collection reloadData];
          [[self.collection header] endRefreshing];
      }];
      
      
      
  }];
    
    
}

- (void)skip:(UITapGestureRecognizer *)tap{
    NSLog(@"---");
    SearchVC *seVC = [SearchVC new];
    [self.navigationController showViewController:seVC sender:nil];
    
    
}

- (void)creatNavBar {

    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"北京v"style:(UIBarButtonItemStylePlain) target:self action:@selector(locationBBIClicked)];
    self.navigationItem.leftBarButtonItem.tintColor=[UIColor blackColor];

}

- (void)locationBBIClicked {
    
    LocationVC *locationVC = [LocationVC new];
    
    locationVC.block =^(NSString *string,NSString*cityName,NSString*cityCode){
        
        self.string = string;
        self.cityName = cityName;
        self.cityCode =cityCode;
    };
    
    locationVC.block2=^(NSString *string,NSString*cityName,NSString*cityCode){
        
        self.string = string;
        self.cityName = cityName;
        self.cityCode =cityCode;
    };

    locationVC.hidesBottomBarWhenPushed = YES;
    // UINavigationController *rootNC = [[UINavigationController alloc] initWithRootViewController:locationVC];
    [self.navigationController pushViewController:locationVC animated:YES];
   // [self presentViewController:rootNC animated:NO completion:nil];
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
        if (self.ScrollArr.count) {
            return 1;
        }
        return 0;
    }else if (section ==1){
        if (self.ProductArr.count>1) {
             return self.ProductArr.count;
        }
        return 0;
    }else if (section ==2){
        if (self.ProductArr.count) {
            return self.PackageArr.count;
        }
        return 0;
        
    }else if (section ==3){
        if (self.ScenicArr.count) {
            return 1;
        }
        return 0;
        
    }else if (section ==4){
        if (self.RecommendationArr.count) {
             return self.RecommendationArr.count;
        }
        return 0;
    }else{
        return 1;
    }
  
}

//返回item
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        
        carouseIFingureCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"carousel" forIndexPath:indexPath];
        if ([self.CarouseArray isKindOfClass:[NSArray class]]) {
            if (self.CarouseArray.count > 0) {

            IanScrollView *scrollView = [[IanScrollView alloc] initWithFrame:CGRectMake(0,0,kWidth,120)];
            scrollView.slideImagesArray = _ScrollArr;
            scrollView.ianEcrollViewSelectAction = ^(NSInteger i){
                HomepageHeaderModel*header = self.CarouseArray[i-0];
                if ([header.app_url length] >12) {
                    CarouselWebViewVC*WebVC =[CarouselWebViewVC new];
                    WebVC.url = header.app_url;
                    WebVC.titleW = header.title;
                     WebVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:WebVC animated:YES];
                }else if ([header.app_url length] ==3){
                    NSString *url = [self.CarouseArray[i-0] app_url];
                    //FindKindOfSceneController*detali = [FindKindOfSceneController new];
                    ScrollVC*detali =[ScrollVC new];
                    detali.cityCode =url;
                    detali.cityNum = self.cityCode;
                    UINavigationController*rootVC =[[UINavigationController alloc]initWithRootViewController:detali];
                    [self presentViewController:rootVC animated:YES completion:nil];
                    
                }else if ([header.app_url length] <= 12 && [header.app_url length] >= 9){
                    
                    NSString *str1= [self.CarouseArray[i-0] app_url];
                    //NSString * str1 = @"19431&111157";
                    NSString * str2 = @"&";
                    NSRange range = [str1 rangeOfString:str2];
                    NSInteger length =  str1.length;
                    NSString *productId = [str1 substringWithRange:NSMakeRange(0, range.location)];
                    NSString *linkId = [str1 substringWithRange:NSMakeRange(range.location+1, length-range.location-1)];
                    
                    ComDetailVC*detali =[ComDetailVC new];
                    detali.bookID = [linkId integerValue];
                    detali.detailID =[productId integerValue];
                    detali.hidesBottomBarWhenPushed =YES;
                    [self.navigationController pushViewController:detali animated:YES];

                }
            };
            scrollView.PageControlPageIndicatorTintColor = [UIColor whiteColor];
            scrollView.pageControlCurrentPageIndicatorTintColor = [UIColor orangeColor];
            [scrollView startLoading];
            [cell addSubview:scrollView];
            }}

        return cell;
    }else if (indexPath.section==1){
        CategoriesCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"cate" forIndexPath:indexPath];
        if ([self.ProductArr isKindOfClass:[NSArray class]]) {
            if (self.ProductArr.count>0) {
        HomepageHeaderModel*header =self.ProductArr[indexPath.row];
        cell.cate4lable.text=header.title;
        [cell.cate4image sd_setImageWithURL:[NSURL URLWithString:header.app_picpath]placeholderImage:[UIImage imageNamed:@"picholder"]];
            }}
        return cell;
    }else if (indexPath.section==2){
        PackageCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"pack" forIndexPath:indexPath];
        if ([self.PackageArr isKindOfClass:[NSArray class]]) {
            if (self.PackageArr.count > 0) {
        HomepageHeaderModel*header =self.PackageArr[indexPath.row];
        cell.adTitle4lable.text=header.adTitle;
        cell.asSub4lable.text=header.adSubTitle;
        [cell.path4image sd_setImageWithURL:[NSURL URLWithString:header.n_app_picpath]placeholderImage:[UIImage imageNamed:@"picholder"]];
            }}
        cell.layer.borderWidth = 0.3;
        cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
        return cell;
    }else if (indexPath.section==3){
        HotScenicCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"hot" forIndexPath:indexPath];
        if ([self.ScenicArr isKindOfClass:[NSArray class]]&&[self.cityArr isKindOfClass:[NSArray class]]) {
            if (self.ScenicArr.count > 0 && self.cityArr.count > 0) {
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
           
            }}
        cell.userInteractionEnabled = YES;
        cell.delegate =self;
        cell.view.userInteractionEnabled =YES;
        return cell;
    }else if (indexPath.section==4){
        RecommendationCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"rec" forIndexPath:indexPath];
        
        if ([self.RecommendationArr isKindOfClass:[NSArray class]]) {
        if (self.RecommendationArr.count > 0) {
        HomepagePackageModel*package = self.RecommendationArr[indexPath.row];
        cell.package = package;
        [cell.bigUrl4image sd_setImageWithURL:[NSURL URLWithString:package.bigImageUrl]placeholderImage:[UIImage imageNamed:@"picholder"]];
        }}
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
        HomepageHeaderModel*header =self.ProductArr[indexPath.row];
        if ([header.app_url length]==2||[header.app_url length]==3) {
           CategoryVC*cateVC=[CategoryVC new];
            cateVC.urlNum = [self.ProductArr[indexPath.row] app_url];
            cateVC.CName = self.cityName;
            cateVC.titleW =header.title;
            cateVC.hidesBottomBarWhenPushed =YES;
            [self.navigationController pushViewController:cateVC animated:YES];
        }else if ([header.app_url length]>5){
        CarouselWebViewVC*WebVC =[CarouselWebViewVC new];
        WebVC.url = [self.ProductArr[indexPath.row] app_url];
              WebVC.titleW = header.title;
            [self.navigationController pushViewController:WebVC animated:YES];
        }else if ([header.app_url length]==4){
            
        }else{
//             NSLog(@"zhoubian");
            self.tabBarController.selectedIndex =1;
            
        }
        
    }else if (indexPath.section == 2){
        HomepageHeaderModel*header =self.PackageArr[indexPath.row];
        if ([header.app_url length]>12) {
        CarouselWebViewVC*WebVC =[CarouselWebViewVC new];
        WebVC.url = [self.PackageArr[indexPath.row] app_url];
        WebVC.titleW = header.title;
        [self.navigationController pushViewController:WebVC animated:YES];
        }else if ([header.app_url length]==2||[header.app_url length]==3) {
            CategoryVC*cateVC=[CategoryVC new];
            cateVC.urlNum = [self.ProductArr[indexPath.row] app_url];
            cateVC.CName = self.cityName;
            cateVC.titleW =header.title;
            cateVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:cateVC animated:YES];

        }else if ([header.app_url length]==4){
            
        }else{
            
            NSString *str1 = [self.PackageArr[indexPath.row] app_url];

            NSString * str2 = @"&";
            NSRange range = [str1 rangeOfString:str2];
//            NSLog(@"%@",NSStringFromRange(range));
//            NSLog(@"%ld",range.location);
            
            NSInteger length =  str1.length;
            NSString *productId = [str1 substringWithRange:NSMakeRange(0, range.location)];
            NSString *linkId = [str1 substringWithRange:NSMakeRange(range.location+1, length-range.location-1)];
            
            ComDetailVC*detali =[ComDetailVC new];
            detali.bookID = [linkId integerValue];
            detali.detailID =[productId integerValue];
             detali.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:detali animated:YES];
  
        }
    }else if (indexPath.section==4){

        
        HomepagePackageModel*package =self.RecommendationArr[indexPath.row];
        NSInteger productld=package.productId;
        NSInteger nlinkId=package.channelLinkId;

        ComDetailVC*detailVC =[ComDetailVC new];
        detailVC.bookID = nlinkId;
        detailVC.detailID = productld;

        detailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailVC animated:YES];
        detailVC.hidesBottomBarWhenPushed = YES;
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
    cateVC.titleW=a.name;
    UINavigationController *rootNC = [[UINavigationController alloc] initWithRootViewController:cateVC];
    [self presentViewController:rootNC animated:YES completion:nil];
    
}
- (void)getDetailControllerB10{
    
    CategoryVC*cateVC =[CategoryVC new];
    HomepageScenicModel*a = self.cityArr[1];
    cateVC.CityName =a.name;
    cateVC.CityCode =a.cityCode;
    cateVC.titleW=a.name;
    UINavigationController *rootNC = [[UINavigationController alloc] initWithRootViewController:cateVC];
    [self presentViewController:rootNC animated:YES completion:nil];
}
- (void)getDetailControllerB11{
    
    CategoryVC*cateVC =[CategoryVC new];
    HomepageScenicModel*a = self.cityArr[2];
    cateVC.CityName =a.name;
    cateVC.CityCode =a.cityCode;
    cateVC.titleW=a.name;
    UINavigationController *rootNC = [[UINavigationController alloc] initWithRootViewController:cateVC];
    [self presentViewController:rootNC animated:YES completion:nil];
}
- (void)getDetailControllerB12{
    
    CategoryVC*cateVC =[CategoryVC new];
    HomepageScenicModel*a = self.cityArr[3];
    cateVC.CityName =a.name;
    cateVC.CityCode =a.cityCode;
    cateVC.titleW=a.name;
    UINavigationController *rootNC = [[UINavigationController alloc] initWithRootViewController:cateVC];
    [self presentViewController:rootNC animated:YES completion:nil];
}
- (void)getDetailControllerB13{
    CategoryVC*cateVC =[CategoryVC new];
    HomepageScenicModel*a = self.cityArr[4];
    cateVC.CityName =a.name;
    cateVC.CityCode =a.cityCode;
    cateVC.titleW=a.name;
    UINavigationController *rootNC = [[UINavigationController alloc] initWithRootViewController:cateVC];
    [self presentViewController:rootNC animated:YES completion:nil];}
- (void)getDetailControllerB14{
    
    CategoryVC*cateVC =[CategoryVC new];
    HomepageScenicModel*a = self.cityArr[5];
    cateVC.CityName =a.name;
    cateVC.CityCode =a.cityCode;
    cateVC.titleW=a.name;
    UINavigationController *rootNC = [[UINavigationController alloc] initWithRootViewController:cateVC];
    [self presentViewController:rootNC animated:YES completion:nil];
}
- (void)getDetailControllerB15{
    
    CategoryVC*cateVC =[CategoryVC new];
    HomepageScenicModel*a = self.cityArr[6];
    cateVC.CityName =a.name;
    cateVC.CityCode =a.cityCode;
    cateVC.titleW=a.name;
    UINavigationController *rootNC = [[UINavigationController alloc] initWithRootViewController:cateVC];
    [self presentViewController:rootNC animated:YES completion:nil];
}
- (void)getDetailControllerB16{
    //更多为城市列表
    
    LocationVC *locationVC = [LocationVC new];
    
    locationVC.block =^(NSString *string,NSString*cityName,NSString*cityCode){
        
        self.string = string;
        self.cityName = cityName;
        self.cityCode =cityCode;
    };
    
    locationVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:locationVC animated:YES];
    
    
    
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






//-(NSMutableArray*)ScrollArr{
//    
//    if (_ScrollArr == nil) {
//        _ScrollArr = [NSMutableArray new];
//    }
//    return _ScrollArr;
//    
//}


@end
