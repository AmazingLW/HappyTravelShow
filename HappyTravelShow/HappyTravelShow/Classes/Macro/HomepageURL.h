//
//  HomepageURL.h
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/7.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#ifndef HappyTravelShow_HomepageURL_h
#define HappyTravelShow_HomepageURL_h

//轮播图--热门景区以上
//#define kPackage @"http://apiphp.yaochufa.com/you/advertiselist/AdList?version=4.3.0&system=ios&channel=AppStore&area_code=110100&column=appTopicBig%2CappTopicMid%2CbannerSquare%2CbannerRound%2CbannerScroll"

#define kPackage(cityCode,s1,s2,s3,s4) [NSString stringWithFormat:@"http://apiphp.yaochufa.com/you/advertiselist/AdList?version=4.3.0&system=ios&channel=AppStore&area_code=%@&column=appTopicBig%@2CappTopicMid%@2CbannerSquare%@2CbannerRound%@2CbannerScroll",cityCode,s1,s2,s3,s4]

//热门城市
//#define kCity @"http://apiphp.yaochufa.com/portal/scenic/ScenicIndex?imei=58F00310-C46F-41FA-B925-243B20D143C3&system=ios&cityCode=110100&channel=AppStore&version=4.3.0"

#define kCity(cityCode) [NSString stringWithFormat:@"http://apiphp.yaochufa.com/portal/scenic/ScenicIndex?imei=58F00310-C46F-41FA-B925-243B20D143C3&system=ios&cityCode=%@&channel=AppStore&version=4.3.0",cityCode]

//精品推荐
//#define kRecommendation @"http://apiphp.yaochufa.com/playpoint/recommend?pageSize=10&system=ios&userId=0&city=110100&channel=AppStore&version=4.3.0&pageIndex=1"

#define kRecommendation(cityCode) [NSString stringWithFormat:@"http://apiphp.yaochufa.com/playpoint/recommend?pageSize=10&system=ios&userId=0&city=%@&channel=AppStore&version=4.3.0&pageIndex=1",cityCode]

//点击门票and温泉
#define  KTicket(tagId,p,city,sort)[NSString stringWithFormat:@"http://appapi.yaochufa.com/v2/Product/GetProductList?system=ios&version=4.3.0&channel=AppStore&tagId=%@&longitude=116.35029328037&pageIndex=%ld&latitude=40.036319146892&type=tag&city=%@&sort=%@&pageSize=20",tagId,p,city,sort]

//点击亲子游and市区
#define  KFamily(p,propertyId,city,sort)[NSString stringWithFormat:@"http://appapi.yaochufa.com/v2/Product/GetProductList?system=ios&version=4.3.0&channel=AppStore&pageIndex=%ld&longitude=116.35027617524&latitude=40.036361935048&type=property&propertyId=%@&city=%@&sort=%@&pageSize=20",p,propertyId,city,sort]


#define  KCityDetails(CityName,cityCode,sort) [NSString stringWithFormat:@"http://apiphp.yaochufa.com/portal/circum/searchlist?p=1&system=ios&channel=AppStore&version=4.3.0&minPrice=0&keyWord=%@&cityCode=%@&s=20&lat=40.036354004545&lng=116.35025721584&sort=%ld&maxPrice=999999",CityName,cityCode,sort]


#define k @"http://apiphp.yaochufa.com/portal/circum/searchlist?p=1&system=ios&channel=AppStore&version=4.3.0&minPrice=0&keyWord=%E5%A4%A9%E6%B4%A5&cityCode=120100&s=20&lat=40.036354004545&lng=116.35025721584&sort=2&maxPrice=999999"

//热门景区点击URL

#define URL_ScenicDetail(scenicid) [NSString stringWithFormat:@"http://apiphp.yaochufa.com/portal/scenic/scenicDetail430?version=4.3.1&id=%ld&system=iOS&channel=AppStore",scenicid]

//门票URL
#define URL_ticketData(ticketID) [NSString stringWithFormat:@"http://apiphp.yaochufa.com/portal/scenic/GetMoreProduct430?pageIndex=1&itemId=91&version=4.3.1&id=%ld&system=iOS&pageSize=10&channel=AppStore",ticketID]

//所有城市列表
#define kCityList @"http://appapi.yaochufa.com/v2/Position/GetCityList?machineCode=00000000-62a0-833f-ffff-ffffc33ba23b&version=4.3.1&system=android&channel=huaweimarket"


//天气url
#define URL_sky(cityEncoding) [NSString stringWithFormat:@"http://appapi.yaochufa.com/v2/Product/GetWeatherInfoByCity?productId=0&version=4.3.1&system=iOS&cityName=%@&channel=AppStore",cityEncoding]




#endif
