//
//  CommomURL.h
//  HappyTravelShow
//
//  Created by Amazing on 15/10/8.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#ifndef HappyTravelShow_CommomURL_h
#define HappyTravelShow_CommomURL_h


//请求 book url
#define URL_requestBook @"http://appapi.yaochufa.com/v2/ProductPackage/GetCommonPackagesByLinkIdV424?linkId=67207&version=4.3.1&checkOutDate=2015-11-11&system=iOS&checkInDate=2015-10-07&channel=AppStore&isSelected=false"

#warning checkindate 时间变成当天

#define URL_RequestBookData(linkId) [NSString stringWithFormat:@"http://appapi.yaochufa.com/v2/ProductPackage/GetCommonPackagesByLinkIdV424?linkId=%ld&version=4.3.1&checkOutDate=2015-11-11&system=iOS&checkInDate=2015-10-12&channel=AppStore&isSelected=false",linkId]



//请求详情数据
#define URL_requestDetail @"http://appapi.yaochufa.com/v2/Product/GetProductInfoById?productId=11790&version=4.3.1&system=iOS&channel=AppStore"


#define URL_requestDetailData(productId) [NSString stringWithFormat:@"http://appapi.yaochufa.com/v2/Product/GetProductInfoById?productId=%ld&version=4.3.1&system=iOS&channel=AppStore",productId]







#endif
