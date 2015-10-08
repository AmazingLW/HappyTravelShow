//
//  AroundURL.h
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/7.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#ifndef HappyTravelShow_AroundURL_h
#define HappyTravelShow_AroundURL_h

//取得目的城市 和 景点列表 和 tags
#define AROUNDCITY(cityName) [NSString stringWithFormat:@"http://appapi.yaochufa.com/v2/Theme/GetSceniceAndTagsByCity? version=4.3.1&system=iOS&cityName=%@&channel=AppStore",cityName]

//取到全部景点 和 productId(详情页)
#warning 需要经纬度 默认北京的经纬度(后期如果不加就删去)
#define AllScenic(cityName) [NSString stringWithFormat:@"http://appapi.yaochufa.com/v2/Product/GetAroundProductList?pageIndex=1&longitude=116.343762&latitude=40.030576 &version=4.3.1&sort=n&province=1&system=iOS&pageSize=20&channel=AppStore&city=%@",cityName]

//详情页
#define detailURL(productID) [NSString stringWithFormat:@"http://appapi.yaochufa.com/v2/Product/GetProductInfoById?productId=%ld &version=4.3.1&system=iOS&channel=AppStore",productID]

//点击景点列表弹出的小景点列表
#warning 需要经纬度 默认北京的经纬度(后期如果不加就删去)
#define littleScenicURL(scenicName,cityName) [NSString stringWithFormat:@"http://appapi.yaochufa.com/v2/Product/GetAroundProductList?pageIndex=1&longitude=116.34362&latitude=40.030591&scenicName=%@&version=4.3.1&sort=n&province=0&system=iOS&pageSize=20&channel=AppStore&city=%@",scenicName,cityName]


#endif
