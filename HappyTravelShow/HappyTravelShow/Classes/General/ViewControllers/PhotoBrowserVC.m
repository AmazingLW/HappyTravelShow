//
//  PhotoBrowserVC.m
//  HappyTravelShow
//
//  Created by Amazing on 15/10/10.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "PhotoBrowserVC.h"

@interface PhotoBrowserVC ()<UIScrollViewDelegate>
{
    UIView *_backView;
}
@end

@implementation PhotoBrowserVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    [self drawView];
    
    [self setValueWithIndex:self.pageIndex];
}


- (void)drawView{
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
    _backView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_backView];
    
    //轮播图
    self.photoScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 150, kScreenWidth, 150)];
    [_backView addSubview:self.photoScrollView];
    
    self.photoScrollView.delegate = self;
    //主标题
    self.mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, kScreenHeight - 140, 180, 25)];
    self.mainLabel.textColor = [UIColor whiteColor];
    [_backView addSubview:self.mainLabel];
    
    
    //子标题
    self.subLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, kScreenHeight - 115, 150, 15)];
    self.subLabel.textColor = [UIColor grayColor];
    [_backView addSubview:self.subLabel];
    
    //浏览位置
    self.locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 60, kScreenHeight - 140, 70, 15)];
    self.locationLabel.textColor = [UIColor whiteColor];
    self.locationLabel.text = @"3/14";
    [_backView addSubview:self.locationLabel];
    
    
}

- (void)setValueWithIndex:(NSInteger)index{
    self.mainLabel.text = self.strMain;
    
    //给scrollview 赋值
    
    
    for (int i = 0; i < self.imgArr.count; i++) {
        UIImageView *photoImgView = self.imgArr[i];
        [photoImgView setFrame:CGRectMake( i * kScreenWidth, -64, kScreenWidth, self.photoScrollView.frame.size.height)];
        
        // 图片的显示格式为合适大小
        photoImgView.contentMode = UIViewContentModeCenter;
        photoImgView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.photoScrollView addSubview:photoImgView];
        
    }

    
    //显示到具体的位置
    if (index == 0) {
        self.photoScrollView.contentOffset = CGPointZero;
    }else{
        self.photoScrollView.contentOffset = CGPointMake(index * kScreenWidth, 0);
    }
    
    //显示内容
    
    self.mainLabel.text = self.strMain;
    self.subLabel.text = [self.photoInfoArr[index] title];
    self.locationLabel.text = [NSString stringWithFormat:@"%ld/%ld",index+1,self.photoInfoArr.count];
    
    self.photoScrollView.contentSize = CGSizeMake(self.imgArr.count * kScreenWidth, 0);
    self.photoScrollView.showsHorizontalScrollIndicator = NO;
    self.photoScrollView.showsVerticalScrollIndicator = NO;
    self.photoScrollView.pagingEnabled = YES;
    
}

/** 滚动完毕时调用 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x/kScreenWidth;
    
    self.mainLabel.text = self.strMain;
    self.subLabel.text = [self.photoInfoArr[index] title];
    self.locationLabel.text = [NSString stringWithFormat:@"%ld/%ld",index+1,self.photoInfoArr.count];
    

}


- (void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
