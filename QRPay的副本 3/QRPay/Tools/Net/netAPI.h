//
//  URLOperationWithBlock.h
//  TestAPI
//
//  Created by Leione on 14/1/28.
//  Copyright (c) 2014年 Leione. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URLOperationWithBlock.h"
#import "ReturnListModel.h"
#import "URLReturnModel.h"
#import "baseAPP.h"

/**
 *  网络请求API类 暂时不支持POST,
 *  
 *  可重用API,没有每个接口都要写一个函数,我只是习惯了而已
 */

@interface netAPI : NSObject

typedef void (^returnBlock)(URLReturnModel *returnModel);
typedef void (^returnListingBlock)(ReturnListModel *listing);


#define STATIS_OK 0
#define STATIS_NO 1

/**
 *  用户登录
 *
 *  @param phone              用户手机号
 *  @param businessDictionary 业务，需要根据API文档将各参数放到字典内
 *  @param listing            返回Model
 */
+ (void)usrLogin:(NSString *)phone business:(NSDictionary *)businessDictionary block:(returnListingBlock)listing;


/**
 *  注册、找回密码
 *
 *  @param phone              用户账号
 *  @param interface          interfaceCode，区分注册和找回密码
 *  @param businessDictionary 业务，需要根据API文档将各参数放到字典内
 *  @param listing            返回Model
 */
+ (void)usrRegister:(NSString *)phone interfaceCode:(NSString *)interface business:(NSDictionary *)businessDictionary block:(returnListingBlock)listing;

/**
 *  获取验证码
 *
 *  @param phone              用户手机号
 *  @param businessDictionary 业务参数
 *  @param listing            返回值
 */
+ (void)getVerificationCode:(NSString *)phone business:(NSDictionary *)businessDictionary block:(returnListingBlock)listing;

/**
 *  仅限于认证时上传图片
 *
 *  @param imageData          业务参数
 *  @param listing            返回
 */
+ (void)uploadImageWithInterfaceCode:(NSString *)interface ImageData:(NSData *)imageData block:(returnListingBlock)listing;



/**
 *  通用信息
 *
 *  @param businessDictionary 业务参数
 *  @param listing            返回
 */
+ (void)getGeneralInfoInterfaceCode:(NSString *)interface Business:(NSDictionary *)businessDictionary block:(returnListingBlock)listing;


@end
