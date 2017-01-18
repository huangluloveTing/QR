//
//  UPConfig.h
//  EasyPay
//
//  Created by Leione on 16/5/19.
//  Copyright © 2016年 Leione. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UPConfig : NSObject

/**
 *  获取代理商编号
 *
 */
+ (NSString *)getCompanyNO;
/**
 *  获取公司 CID
 *
 */

+ (NSString *)getCompanyCid;


/**
 *  获取服务器地址（get 请求）
 *
 */
+ (NSString *)getServerURL;

/**
 *  获取服务器地址（post 请求）
 *
 */
+ (NSString *)getServerBusiness;

/**
 *  获取百度地图key
 *
 */

+ (NSString *)getBaiduSDKKey;

/**
 *  获取JPushkey
 *
 */
+ (NSString *)getJPushSDKKey;

/**
 *  获取JPushChannel
 *
 */

+ (NSString *)getJPushChannel;


/**
 *  获取默认 JSKEY
 *
 */
+ (NSString *)getJSKey;

/**
 *  获取客服电话（拨打）
 *
 */
+ (NSString *)getTelephone;

/**
 *  获取客服电话（展示）
 *
 */

+ (NSString *)getPhoneShow;


/**
 *  获取启动页
 *
 */

+ (NSString *)getLaunchScreen;

/**
 *  获取登录 logo
 *
 */

+ (NSString *)getLoginBackGroundImage;

/**
 *  服务协议 , 简刷/简付通不同
 *
 *  简付通2.5以前版本使用 agreement2.5.html
 
 *  2.5及其他 使用 agreement.html
 */
+ (NSString *)getAgreement;

/**
 *  获取默认秘钥
 *
 */


+ (NSString *)getMacKey;
+ (NSString *)getDesKey;

/**
 *  获取业务参数
 *
 */
+ (NSString *)getServerParameter;

/**
 *    是否有手势锁
 */
+ (BOOL) getIsShowGestureLock;

/**
 *  是否显示新手导航页
 *
 */
+ (BOOL) isShowNewGuiderView;

@end
