//
//  SearchVC.m
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/12.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "SearchVC.h"
#import "AroundHelper.h"
#import "AroundDataBase1.h"
#import "AroundVC3.h"
#import "HomepageHelper.h"
#import "HomepageCityListModel.h"
#import "AroundVC4.h"
@interface SearchVC ()<UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong)UITextField *textfield;
@property (nonatomic, strong)UIButton *button;

@property (nonatomic, strong)UIButton *button1;

@property (nonatomic, strong)UIView *a;

@property (nonatomic, strong)NSMutableArray *cityArray;
@property (nonatomic, strong) UICollectionView *collection;

@property (nonatomic, strong)NSMutableArray *city;

@end

@implementation SearchVC
static NSString *const reuse = @"cell";
static NSString *const header = @"header";
static NSString *const footer = @"footer";

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
         self.navigationItem.hidesBackButton = YES;
        
//        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel:)];
//        self.navigationItem.rightBarButtonItem.width = 30;
//        self.navigationItem.rightBarButtonItem.tag = 1001;
//        
//        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrows"] style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
//        self.navigationItem.leftBarButtonItem.width = 30;
        _a = [[UIView alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 29)];
       // _a.backgroundColor = [UIColor redColor];
        
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(0, 0, 30, 29);
        [_button setBackgroundImage:[UIImage imageNamed:@"arrows"] forState:UIControlStateNormal];
          [_button setBackgroundColor:[UIColor whiteColor]];
        [_button addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
        
        
       _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        _button1.frame = CGRectMake(_a.frame.size.width - 60, 0,40, 29);
        //[button1 setBackgroundColor:[UIColor redColor]];
        [_button1 setTitle:@"搜索" forState:UIControlStateNormal];
        [_button1 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_button1 addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
        
        
        _textfield = [[UITextField alloc] initWithFrame:CGRectMake(30 , 0,_a.frame.size.width - 90 , 29)];
        _textfield.placeholder = @"搜索目的地/景点/酒店";
        _textfield.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];

        _textfield.returnKeyType = UIReturnKeySearch;
        _textfield.delegate = self;
        
        [_a addSubview:_button];
        [_a addSubview:_button1];
        [_a addSubview:_textfield];
        
//        
       self.navigationItem.titleView = _a;
        
        
         }
    
    return self;
    
    
}

//- (void)cityData{
//    _city = [NSMutableArray array];
//    [[HomepageHelper new] requestallCityList:@"positionCity" WithFinish:^(NSMutableArray *arr) {
//        
//        for (HomepageCityListModel *model in arr) {
//            NSString *cityName = model.cityNameAbbr;
//            
//            [_city addObject:cityName];
//        }
//    
//
//    }];
//    
//
//}


- (void)request{
    
    [[AroundHelper new] requestHotCityWithCityID:1 result:^(NSArray *array) {
        
        _cityArray = [NSMutableArray arrayWithArray:array];
        
        [self.collection reloadData];
        
    }];
    
    
}


//左侧按钮方法
- (void)back:(UIBarButtonItem *)barButton{
    
    [self.navigationController popViewControllerAnimated:YES];

}
//右侧按钮方法
- (void)cancel:(UIBarButtonItem *)barButton{
    
    [UIView animateWithDuration:0.5 animations:^{
       
        _button1.frame = CGRectMake(_a.frame.size.width + 10, 0, 0, 29);
          _textfield.frame = CGRectMake(30, 0,_a.frame.size.width - 30, 29);
        
        
        
    }];
    
    [self textFieldShouldReturn:_textfield];
    
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    [UIView animateWithDuration:0.3 animations:^{
        
      _button1.frame = _button1.frame = CGRectMake(_a.frame.size.width - 60, 0,40, 29);
        
        _textfield.frame = CGRectMake(30, 0,_a.frame.size.width - 90, 29);
        
    }];

     return YES;

    
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    __weak typeof(self) temp = self;
    [[HomepageHelper new] requestallCityList:@"positionCity" WithFinish:^(NSMutableArray *arr) {
        
        
        for (HomepageCityListModel *model in arr) {
            if ([temp.textfield.text isEqualToString:model.cityNameAbbr]) {

//                if (_delegate && [_delegate respondsToSelector:@selector(passwordWithString:)]) {
                    [_delegate passwordWithString:model.cityNameAbbr];
            //    }

            }
        }
    }];
     
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
   
   //[self cityData];

        __weak typeof(self) temp = self;
    [[HomepageHelper new] requestallCityList:@"positionCity" WithFinish:^(NSMutableArray *arr) {
        
        
        for (HomepageCityListModel *model in arr) {
            if ([temp.textfield.text isEqualToString:model.cityNameAbbr]) {
               
                
                AroundVC3 *around = [[AroundVC3 alloc] init];
                around.NAME = [model.cityNameAbbr mutableCopy];
            
//                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:around];
                
                //temp.block(model.cityNameAbbr);
                
//                if (_delegate && [_delegate respondsToSelector:@selector(passwordWithString:)]) {
//                    [_delegate passwordWithString:model.cityNameAbbr];
//                }
//                
                
               [temp.navigationController pushViewController:around animated:YES];
               
                [textField resignFirstResponder];
            
        
            }else{
              
                
                
            }
        }
        
       
        
    }];
    
  return YES;

}
     
        


    


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
  
   UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.itemSize = CGSizeMake(95, 30);
    
    layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    layout.headerReferenceSize = CGSizeMake(20, 30);
    
    
    
    _collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)collectionViewLayout:layout];
    _collection.backgroundColor = [UIColor whiteColor];
    _collection.dataSource = self;
    _collection.delegate = self;
    
    
    [_collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuse];
    
    [_collection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    [_collection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"aaa"];
    
//    [collection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footer];
//    
    [self.view addSubview:_collection];
    _collection.scrollEnabled = YES;
    
    [self request];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AroundVC4 *vc4 = [[AroundVC4 alloc] init];
    
    vc4.NAME = _cityArray[indexPath.row];
    vc4.Name = self.string;
    
    [self.navigationController pushViewController:vc4 animated:YES];
    
    //NSLog(@"%ld---%ld", indexPath.section,indexPath.row);
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    if (section == 0) {
//        
//        
//        
//        //如果没有历史 就返回0 header有两种
//        return 0;
//        
//        //如果有几个就返回几个
//        
//    }else {
        //根据请求的数据
        return _cityArray.count;
   // }

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuse forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor lightGrayColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 20)];
    label.center = CGPointMake(cell.frame.size.width / 2, cell.frame.size.height / 2);
    label.text = _cityArray[indexPath.row];
    
    [cell addSubview:label];
    
    return cell;
    
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

           //如果有历史返回一中头 没有返回另一种
            
    
    
    
//    if (indexPath.section == 0) {
//        
//        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
//        
//         UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200,10)];
//        label.center = CGPointMake(header.frame.size.width / 2, header.frame.size.height / 2);
//            label.text = @"暂无历史搜索记录";
//            label.textColor = [UIColor grayColor];
//            
//            [header addSubview:label];
//            
//            
//            return header;
//
//        
//        
//    }else if (indexPath.section == 1){
    
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"aaa" forIndexPath:indexPath];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,0 , 100, 10)];
        label.center = CGPointMake(header.frame.size.width / 2, header.frame.size.height / 2);
        label.text = @"热门搜索";
        label.textColor = [UIColor grayColor];
        
        [header addSubview:label];
        
        
        return header;

        
   //
   // }
    
    
            
  //  return nil;
    
  
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
