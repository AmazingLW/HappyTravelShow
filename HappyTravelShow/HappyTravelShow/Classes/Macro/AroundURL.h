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


//#warning 定位的位置 金五星 修改
#define AllScenic(page,cityName) [NSString stringWithFormat:@"http://appapi.yaochufa.com/v2/Product/GetAroundProductList?pageIndex=%ld&longitude=116.343648&latitude=40.030561&version=4.3.1&sort=n&province=1&system=iOS&pageSize=20&channel=AppStore&city=%@",page,cityName]

//详情页
#define detailURL(productID) [NSString stringWithFormat:@"http://appapi.yaochufa.com/v2/Product/GetProductInfoById?productId=%ld&version=4.3.1&system=iOS&channel=AppStore",productID]

//点击景点列表弹出的小景点列表
//#warning 定位的位置 金五星
#define littleScenicURL(scenicName,cityName) [NSString stringWithFormat:@"http://appapi.yaochufa.com/v2/Product/GetAroundProductList?pageIndex=1&longitude=116.343658&latitude=40.030583&scenicName=%@&version=4.3.1&sort=n&province=0&system=iOS&pageSize=20&channel=AppStore&city=%@",scenicName,cityName]

//当目的城市选定 景点全部时 列表

#define partScenic(scenicName) [NSString stringWithFormat:@"http://appapi.yaochufa.com/v2/Product/GetAroundProductList?pageIndex=1&longitude=116.343642&latitude=40.030598&version=4.3.1&sort=n&province=0&system=iOS&pageSize=20&channel=AppStore&city=%@",scenicName]



//当 目的城市为全部 景点全部  排序方式改变   筛选方式改变  city(景德镇)

#define chooseAllScenic(page,sortType,tagName,cityName) [NSString stringWithFormat:@"http://appapi.yaochufa.com/v2/Product/GetAroundProductList?pageIndex=%ld&longitude=116.343594&latitude=40.030572&version=4.3.1&sort=%@&province=1&tagName=%@&system=iOS&pageSize=20&channel=AppStore&city=%@",page,sortType,tagName,cityName]

// 当目的城市选定 景点全部 排序方式 sortType 任意  筛选方式改变  city(是目的城市 @"上饶")

#define chooseLittleScenic(sortType,tagName,cityName) [NSString stringWithFormat:@"http://appapi.yaochufa.com/v2/Product/GetAroundProductList?pageIndex=1&longitude=116.343594&latitude=40.030572&version=4.3.1&sort=%@&province=0&tagName=%@&system=iOS&pageSize=20&channel=AppStore&city=%@",sortType,tagName,cityName]

// 当目的城市选定 景点选定 排序方式 sortType 任意  筛选方式改变  景点(scenicName) 三清山  city(是目的城市 @"上饶")

#define chooseAllCity(scenicName,sortType,tagName,cityName) [NSString stringWithFormat:@"http://appapi.yaochufa.com/v2/Product/GetAroundProductList?pageIndex=1&longitude=116.343594&latitude=40.030572&scenicName=%@&version=4.3.1&sort=%@&province=0&tagName=%@&system=iOS&pageSize=20&channel=AppStore&city=%@",scenicName,sortType,tagName,cityName]





//n默认排序 不用管

// pa 价格变高 pd 价格变低  s 销量优先  xp新品优先  d 离我最近


//当 目的城市全部 景点全部 默认排序 就是全部景点
//当 目的城市选定 景点全部 默认排序 就是 partScenic(scenicName)


//排序 目的城市全部 景点全部 价格变高  city传进来的城市 (景德镇的经纬度) 筛选为全部

#define sortDataUp(type,cityName) [NSString stringWithFormat:@"http://appapi.yaochufa.com/v2/Product/GetAroundProductList?pageIndex=1&longitude=116.343715&latitude=40.030547&version=4.3.1&sort=%@&province=1&system=iOS&pageSize=20&channel=AppStore&city=%@",type,cityName]


//排序 目的城市选定 景点全部 价格变高 cityName(选定的目的城市) (上饶) 筛选为全部

#define sortPartDataUp(type,cityName) [NSString stringWithFormat:@"http://appapi.yaochufa.com/v2/Product/GetAroundProductList?pageIndex=1&longitude=116.343633&latitude=40.03057&version=4.3.1&sort=%@&province=0&system=iOS&pageSize=20&channel=AppStore&city=%@",type,cityName]

//排序 目的城市选定 景点选定  价格变高   cityName  上饶   scenicName 江湾  筛选为全部

#define sortLittleDataUp(scenicName,type,cityName) [NSString stringWithFormat:@"http://appapi.yaochufa.com/v2/Product/GetAroundProductList?pageIndex=1&longitude=116.343633&latitude=40.03057&scenicName=%@&version=4.3.1&sort=%@&province=0&system=iOS&pageSize=20&channel=AppStore&city=%@",scenicName,type,cityName]


//排序 当目的城市为全部 景点选定时  灵岩洞 会自动找到上饶拼接字符串

//http://appapi.yaochufa.com/v2/Product/GetAroundProductList?pageIndex=1&longitude=116.343634&latitude=40.030569&scenicName=%E7%81%B5%E5%B2%A9%E6%B4%9E&machineCode=00000000-62a0-833f-ffff-ffffc33ba23b&version=4.3.1&sort=n&province=0&system=android&pageSize=20&channel=huaweimarket&city=%E4%B8%8A%E9%A5%B6



//------------------------------------




//点击景点名 取到景点列表 排序方式自定 筛选全部就是不拼接&tagName=%@
// cityName 是 定位的城市名
#define scenicList(scenicName,sort,cityName) [NSString stringWithFormat:@"http://appapi.yaochufa.com/v2/Product/GetAroundProductList?pageIndex=1&longitude=116.343635&latitude=40.030579&scenicName=%@&version=4.3.1&sort=%@&province=0&system=iOS&pageSize=20&channel=AppStore&city=%@",scenicName,sort,cityName]

//当 排序存在时 筛选存在  点击景点名 也就是在上一个url上再拼接一个&tagName=%@

#define partScenicList(scenicName,sort,tagName,cityName) [NSString stringWithFormat:@"http://appapi.yaochufa.com/v2/Product/GetAroundProductList?pageIndex=1&longitude=116.343635&latitude=40.030579&scenicName=%@&version=4.3.1&sort=%@&province=0&tagName=%@&system=iOS&pageSize=20&channel=AppStore&city=%@",scenicName,sort,tagName,cityName]


//----------------------搜索

// http://appapi.yaochufa.com/v2/Util/GetSearchHotKeys?machineCode=00000000-62a0-833f-ffff-ffffc33ba23b&version=4.3.1&keyCount=12&system=android&cityId=1&channel=huaweimarket
//热门城市
#define hotCity(cityID) [NSString stringWithFormat:@"http://appapi.yaochufa.com/v2/Util/GetSearchHotKeys?version=4.3.1&keyCount=12&system=iOS&cityId=%ld&channel=AppStore",cityID]


//热门搜索

//全部景点
#define hotCityList(inPutCity,p, dingweiCity) [NSString stringWithFormat:@"http://appapi.yaochufa.com/v2/Search/Search?version=4.3.1&sort=1&keyWord=%@&minPrice=0&system=iOS&p=%ld&channel=AppStore&maxPrice=999999&city=%@&s=20",inPutCity,p,dingweiCity]



#endif
