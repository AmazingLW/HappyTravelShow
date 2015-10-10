//
//  AroundURL.h
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/7.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#ifndef HappyTravelShow_AroundURL_h
#define HappyTravelShow_AroundURL_h
//定位传得cityNAme
//取得目的城市 和 景点列表 和 tags
#define AROUNDCITY(cityName) [NSString stringWithFormat:@"http://appapi.yaochufa.com/v2/Theme/GetSceniceAndTagsByCity?version=4.3.1&system=iOS&cityName=%@&channel=AppStore",cityName]

//取到全部景点 和 productId(详情页) cityName 是定位的city
#warning 需要经纬度 默认景德镇的经纬度(后期如果不加就删去)
#define AllScenic(cityName) [NSString stringWithFormat:@"http://appapi.yaochufa.com/v2/Product/GetAroundProductList?pageIndex=1&longitude=116.343648&latitude=40.030561&version=4.3.1&sort=n&province=1&system=iOS&pageSize=20&channel=AppStore&city=%@",cityName]

//详情页
#define detailURL(productID) [NSString stringWithFormat:@"http://appapi.yaochufa.com/v2/Product/GetProductInfoById?productId=%ld&version=4.3.1&system=iOS&channel=AppStore",productID]

//点击景点列表弹出的小景点列表
#warning 需要经纬度 默认景德镇的经纬度(后期如果不加就删去)
#define littleScenicURL(scenicName,cityName) [NSString stringWithFormat:@"http://appapi.yaochufa.com/v2/Product/GetAroundProductList?pageIndex=1&longitude=116.343658&latitude=40.030583&scenicName=%@&version=4.3.1&sort=n&province=0&system=iOS&pageSize=20&channel=AppStore&city=%@",scenicName,cityName]

//当目的城市选定 景点全部时 列表

#define partScenic(scenicName) [NSString stringWithFormat:@"http://appapi.yaochufa.com/v2/Product/GetAroundProductList?pageIndex=1&longitude=116.343642&latitude=40.030598&version=4.3.1&sort=n&province=0&system=iOS&pageSize=20&channel=AppStore&city=%@",scenicName]


// 当目的城市是某一个特定城市 并且景点是全部是 筛选

#define chooseAllScenic(tagName,cityName) [NSString stringWithFormat:@"http://appapi.yaochufa.com/v2/Product/GetAroundProductList?pageIndex=1&longitude=116.343648&latitude=40.030561&version=4.3.1&sort=n&province=0&tagName=%@&system=iOS&pageSize=20&channel=AppStore&city=%@",tagName,cityName]

//当目的城市是特定城市 景点是特定的景点 是筛选  cityName 是特定的目的城市 scenicName是特定的景点 tagName 是筛选的类型
#define chooseLittleScenic(scenicName,tagName,cityName) [NSString stringWithFormat:@"http://appapi.yaochufa.com/v2/Product/GetAroundProductList?pageIndex=1&longitude=116.343648&latitude=40.030561&scenicName=%@&version=4.3.1&sort=n&province=0&tagName=%@&system=iOS&pageSize=20&channel=AppStore&city=%@",scenicName,tagName,cityName]


//当目的城市为全部使筛选  cityName 是定位时的城市

#define chooseAllCity(tagName,cityName) [NSString stringWithFormat:@"http://appapi.yaochufa.com/v2/Product/GetAroundProductList?pageIndex=1&longitude=116.343648&latitude=40.030561&version=4.3.1&sort=n&province=1&tagName=%@&system=iOS&pageSize=20&channel=AppStore&city=%@",tagName,cityName]


//n默认排序 不用管

// pa 价格变高 pd 价格变低  s 销量优先  xp新品优先  d 离我最近


//当 目的城市全部 景点全部 默认排序 就是全部景点
//当 目的城市选定 景点全部 默认排序 就是 partScenic(scenicName)


//排序 目的城市全部 景点全部 价格变高  city传进来的城市 (景德镇的经纬度)

#define sortDataUp(type,cityName) [NSString stringWithFormat:@"http://appapi.yaochufa.com/v2/Product/GetAroundProductList?pageIndex=1&longitude=116.343673&latitude=40.030488&version=4.3.1&sort=%@&province=1&system=iOS&pageSize=20&channel=AppStore&city=%@",type,cityName]


//排序 目的城市选定 景点全部 价格变高 cityName(选定的目的城市) (上饶)

#define sortPartDataUp(type,cityName) [NSString stringWithFormat:@"http://appapi.yaochufa.com/v2/Product/GetAroundProductList?pageIndex=1&longitude=116.343633&latitude=40.03057&version=4.3.1&sort=%@&province=0&system=iOS&pageSize=20&channel=AppStore&city=%@",type,cityName]

//排序 目的城市选定 景点选定  价格变高   cityName  上饶   scenicName 江湾

#define sortLittleDataUp (scenicName,type,cityName) [NSString stringWithFormat:@"http://appapi.yaochufa.com/v2/Product/GetAroundProductList?pageIndex=1&longitude=116.343633&latitude=40.03057&scenicName=%@&version=4.3.1&sort=%@&province=0&system=iOS&pageSize=20&channel=AppStore&city=%@",scenicName,type,cityName]









#endif
