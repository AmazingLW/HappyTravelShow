//
//  FinderURL.h
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/6.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#ifndef HappyTravelShow_FinderURL_h
#define HappyTravelShow_FinderURL_h

//图片链接拼接
#define  kURL(url) [NSString stringWithFormat:@"http://cdn1.jinxidao.com/%@",url]

//发现主页面数据接口拼接
#define  fURL(cityCode,pageIndex)[NSString stringWithFormat:@"http://apiphp.yaochufa.com/portal/theme/areaThemeList?system=ios&pageSize=10&channel=AppStore&cityCode=%@&version=4.3.0&pageIndex=%ld",cityCode,pageIndex]
//发现各种景点页面数据接口拼接
#define mURL(id,cityCode,pageIndex)[NSString stringWithFormat:@"http://apiphp.yaochufa.com/portal/theme/themeinfo?system=ios&pageSize=10&channel=AppStore&id=%@&cityCode=%@&version=4.3.0&pageIndex=%ld",id,cityCode,pageIndex]
#endif
