//
//  UPConfig.m
//  EasyPay
//
//  Created by Leione on 16/5/19.
//  Copyright © 2016年 Leione. All rights reserved.
//

#import "UPConfig.h"
#import "Constant.h"
#import "DBGuestureLock.h"

@implementation UPConfig

/**
 *  配置服务器地址
 *
 */
+ (NSString *)getCompanyNO
{
    return @"ZL";
}
+ (NSString *)getCompanyCid
{
    return @"";
}

+ (NSString *)getServerURL
{
      return ServiceURL;
}

/**
 *  配置公司客服电话
 */

+ (NSString *)getTelephone
{
//    return [[PayConfig getUserInfo] valueForKey:@"servicePhone"];
    return @"15202809807";
}
+ (NSString *)getPhoneShow
{
    return [[PayConfig getUserInfo] valueForKey:@"servicePhone"];
}

/**
 *  获取BaiduSDKKey
 *
 */
+ (NSString *)getBaiduSDKKey
{
    return @"替换成自己的";
}

/**
 *  获取JPushkey
 *
 */
+ (NSString *)getJPushSDKKey
{
    return @"替换成自己的";
}

+ (NSString *)getMacKey
{
    return @"36BBD3276B6B7BBD1638CDDF64AF75AA";
}
+ (NSString *)getDesKey
{
    return @"F69CD4286C9FF0E558DDF6397C8E8317";
}

+ (NSString *)getServerBusiness
{
    return [[self getServerURL] stringByAppendingString:@"pay.action?"];
    
}


+ (NSString *)getServerParameter
{
    return @"%@.action?companyNo=%@&cid=%@&customerNo=%@&version=%@&requestData=%@&mac=%@";
}






+ (NSString *)getLaunchScreen
{
    return @"denglujm";
}

+ (NSString *)getLoginBackGroundImage
{
    return @"backImage";
}


/**
 *  获取JPushChannel
 *
 */

+ (NSString *)getJPushChannel
{
    return @"Publish channel";
}


+ (NSString *)getAgreement
{
    return @"agreement.html";
    
}


+ (NSString *)getJSKey
{
    return @"b805595dc4ff97a8";
}

+ (BOOL) getIsShowGestureLock {
    
    return [DBGuestureLock passwordSetupStatus];
}

+ (BOOL) isShowNewGuiderView {
    return [[NSUserDefaults standardUserDefaults] valueForKey:SHOWNEWGUIDER];
}

@end
