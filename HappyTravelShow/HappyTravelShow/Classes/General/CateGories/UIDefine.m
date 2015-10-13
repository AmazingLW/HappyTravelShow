//
//  UIDefine.m
//  HappyTravelShow
//
//  Created by Amazing on 15/10/13.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "UIDefine.h"

@implementation UIViewController (Alert)


//显示提示框
- (void)p_showAlertView:(NSString *)title message:(NSString *)message{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertView show];
}

//返回错误码
- (NSString *)errorCode:(NSInteger)code{
    switch (code) {
        case 1:
            return @"服务器内部错误或者参数错误，一般是因为传入了错误的参数，或者没有在本文档里明确定义的运行时错误，都会以代码 1 指代";
            break;
        case 100:
            return  @"无法建立 TCP 连接到 LeanCloud 服务器，通常是因为网络故障，或者我们服务器故障引起的，我们的服务器状态可以查看 健康状态检查";
            
            break;
        case 101:
            return  @"查询的 Class 不存在，或者要关联的 Pointer 对象不存在";
            
            break;
        case 103:
            return  @"非法的 Class 名称，Class 名称大小写敏感，并且必须以英文字母开头，有效的字符仅限在英文字母、数字以及下划线";
            
            break;
        case 104:
            return  @"缺少 objectId，通常是在查询的时候没有传入 objectId，或者 objectId 非法。objectId 只能为字母、数字组成的字符串";
            
            break;
        case 105:
            return  @"无效的 key 名称，也就是 Class 的列名无效，列名必须以英文字母开头，有效的字符仅限在英文字母、数字以及下划线";
            
            break;
        case 106:
            return  @"无效的 Pointer 格式，Pointer必须为形如 {className: 'Post', objectId:'xxxxxx'} 的 JSON 对象";
            
            break;
        case 107:
            return  @"无效的 JSON 对象，解析 JSON 数据失败。";
            
            break;
        case 111:
            return  @"想要存储的值不匹配列的类型，请检查你的数据管理平台中列定义的类型，查看存储的数据是否匹配这些类型";
            
            break;
        case 112:
            return  @"推送订阅的频道无效，频道名称必须不是空字符串，只能包含英文字母、数字以及下划线，并且只能以英文字母开头";
            
            break;
        case 113:
            return  @"Class 中的某个字段设定成必须，保存的对象缺少该字段";
            
            break;
        case 114:
            return  @" iOS 推送存储的 deviceToken 无效";
            
            break;
        case 116:
            return  @"要存储的对象超过了大小限制，我们限制单个对象的最大大小在 16 M";
            
            break;
        case 117:
            return  @"更新的 Key 是只读属性，无法更新";
            
            break;
        case 119:
            return  @"该操作无法从客户端发起。通常可以通过在应用设置里开启对应选项就可以解决";
            
            break;
        case 120:
            return  @"查询结果无法从缓存中找到，SDK 在使用从查询缓存的时候，如果发生缓存没有命中，返回此错误。";
            
            break;
        case 121:
            return  @"JSON 对象中 key 的名称不能包含 $ 和 . 符号";
            
            break;
        case 122:
            return  @"无效的文件名称，文件名称只能是英文字母、数字和下划线组成，并且名字长度限制在 1 到 36 之间";
            
            break;
        case 123:
            return  @" ACL 格式错误";
            
            break;
        case 124:
            return  @"请求超时，超过一定时间（默认 10 秒）没有返回，通常是因为网络故障或者该操作太耗时引起的。";
            
            break;
        case 125:
            return  @"电子邮箱地址无效";
            
            break;
        case 126:
            return  @"无效的用户 Id，可能用户不存在";
            
            break;
        case 127:
            return  @"手机号码无效";
            
            break;
        case 137:
            return  @"违反 class 中的唯一性索引约束（unique），尝试存储重复的值";
            
            break;
        case 139:
            return  @"角色名称非法，角色名称只能以英文字母、数字或下划线组成。";
            
            break;
        case 140:
            return  @"超过应用的容量限额，请升级账户等级";
            
            break;
        case 141:
            return  @"云引擎脚本编译或者运行报错";
            
            break;
        case 142:
            return  @"云引擎校验错误，通常是因为 beforeSave、beforeDelete 等函数返回 error。";
            
            break;
        case 145:
            return  @"本设备没有启用支付功能。";
            
            break;
        case 150:
            return  @"转换数据到图片失败。";
            
            break;
        case 160:
            return  @"账户余额不足。";
            
            break;
        case 200:
            return  @"没有提供用户名，或者用户名为空。";
            
            break;
        case 201:
            return  @"没有提供密码，或者密码为空";
            
            break;
        case 202:
            return  @"用户名已经被占用。";
            
            break;
        case 203:
            return  @"电子邮箱地址已经被占用。";
            
            break;
        case 204:
            return  @"没有提供电子邮箱地址。";
            
            break;
        case 205:
            return  @"找不到电子邮箱地址对应的用户。";
            
            break;
        case 206:
            return  @"没有提供 session，无法修改用户信息，这通常是因为没有登录的用户想修改信息。修改用户信息必须登录，除非在云引擎里，或者使用 master key 调用 REST API。";
            
            break;
        case 207:
            return  @"只能通过注册创建用户，不允许第三方登录。";
            
            break;
        case 208:
            return  @"第三方帐号已经绑定到一个用户，不可绑定到其他用户。";
            
            break;
        case 210:
            return  @"用户名和密码不匹配。";
            
            break;
        case 211:
            return  @"找不到用户。";
            
            break;
        case 212:
            return  @"请提供手机号码。";
            
            break;
        case 213:
            return  @"手机号码对应的用户不存在。";
            
            break;
        case 214:
            return  @"手机号码已经被注册。";
            
            break;
        case 215:
            return  @"未验证的手机号码。";
            
            break;
        case 216:
            return  @"未验证的邮箱地址。";
            
            break;
        case 250:
            return  @"连接的第三方账户没有返回用户唯一标示 id";
            
            break;
        case 251:
            return  @"无效的账户连接，一般是因为 access token 非法引起的。";
            
            break;
        case 300:
            return  @"CQL 语法错误";
            
            break;
        case 301:
            return  @"新增对象失败，通常是数据格式问题。";
            
            break;
        case 302:
            return  @"无效的 GeoPoint 类型，请确保经度在 -180 到 180 之间，纬度在 -90 到 90 之间。";
            
            break;
        case 401:
            return  @"未经授权的访问，没有提供 App id，或者 App id 和 App key 校验失败，请检查配置。";
            
            break;
        case 403:
            return  @"操作被禁止，因为 Class 权限限制。";
            
            break;
        case 502:
            return  @"服务器维护中。";
            
            break;
        case 503:
            return  @"超过流量访问限制，默认 API 并发 1000 访问每秒，通过数据管理平台每秒限制上传一个文件，并且每分钟最多上传 30 个文件，如需提升，请联系我们。";
            
            break;
        case 600:
            return  @"无效的短信签名。短信签名是指附加在短信文本前后位置，使用中文括号【】括起来的文字，短信签名只能位于短信开头或者结束的位置，并且限制在 10（包含 10 个字符）个字符内。 默认发送的短信签名使用的是应用名称，应用名称可以在应用设置里修改。短信自定义模板可以在模板里自定义签名。";
            
            break;
        case 601:
            return  @"发送短信过于频繁。我们限制验证类短信一分钟一条，每天每个号码限制在 10 条左右。我们强烈建议用户使用图形验证码或者倒数计时等方式来避免用户重复发送验证码，以及可能存在的短信验证码攻击。";
            
            break;
        case 602:
            return  @"发送短信或者语音验证码失败，这是短信提供商返回错误，如果确认手机号码没有问题，请联系我们处理。";
            
            break;
        case 603:
            return  @"无效的短信验证码，通常是不匹配或者过期";
            
            break;
        case 604:
            return  @"找不到自定义的短信模板，请检查模板名称是否正确或者模板是否已经创建并审核通过";
            
            break;
        case 605:
            return  @"短信模板未审核";
            
            break;
        case 606:
            return  @"渲染短信模板失败，通常是模板语法问题，我们的短信模板仅支持 handlerbars 模板语法。";
            
            break;
            
        default:
            break;
    }
    return @"";
}

@end