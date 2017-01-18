//
//  PayConfig.h
//  EasyPay
//
//  Created by Leione on 15/9/28.
//  Copyright © 2015年 Leione. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface PayConfig : NSObject


/**
 *  字典转字符串
 *
 *  @param dic 目标字典
 *
 *  @return 转换后的JSON字符串
 */

+  (NSString*)dictionaryToJson:(NSDictionary *)dic;

/**
 *  字符串转字典
 *
 *  @param JSONString 目标字符串
 *
 *  @return 转换后的字典
 */
+  (NSDictionary *)jsonTodictionary:(NSString *)JSONString;

/**
 *  字典转字符串
 *
 *  @param dic 目标字典
 *
 *  @return 转换后的JSON字符串
 */

+(NSString *)dictionaryToStrings:(NSDictionary *)dic;
/**
 *  获取设备版本
 *
 *  @return 设备版本
 */
+ (NSString *)deviceString;
/**
 *  获取保存用户信息的字典
 *
 *  @return 用户信息字典
 */

+ (NSDictionary *)getUserInfo;
+ (NSString *)getUserPhone;

+ (NSString *) getPassword;


+ (BOOL) isSavePassword;

/**
 *  正则表达式，判断是否是整数
 *
 *  @param mobileNum 目标手机号
 *
 *  @return 判断结果
 */
+ (BOOL)isIntegerNumber:(NSString *)mobileNum;

/**
 *  身份证验证
 *
 *  @param cardNo 目标身份证
 *
 *  @return 结果
 */
+ (BOOL)checkIdentityCardNo:(NSString*)cardNo;



/**压缩图片，0.5倍 */
+ (UIImage *)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;

/**文字高度自适应 */
+ (CGFloat )getHighWithString:(NSString *)string withFont:(CGFloat )font width:(CGFloat)with;
+ (CGFloat)gettipHighWithString:(NSString *)string withFont:(CGFloat )font width:(CGFloat)with;
/**
 *  判断银行卡号,使用luhn规则
 *
 *  @param cardNo 输入的银行卡
 *
 *  @return 结果
 */
+ (BOOL) checkCardNo:(NSString*) cardNo;

/**
 *  监测定位权限
 *
 *  @return
 */
+ (BOOL)checkLocationServices;

///**用钥匙串存储UUID和获得UUID*/
//+ (NSString *)getUUIDFromKeychainItemWrapper;

/**
 *  将数字转换成字母
 */

+ (NSString *)exportNumberStringtoLetterString;
/**
 *  检查手机号
 */
+ (BOOL)isMobile:(NSString *)mobile;



/**处理空字符串*/
+ (NSString *)nilStr:(NSString *)str;



+ (CGFloat)getCachesSize;
+ (void)clearCaches;


/**将汉字转换成无声调的拼音,只适用于银行转换, 不能处理多音字**/
+ (NSString *)chineseCharacters2Pinyin:(NSString *)string;

+ (void) saveConfigWithKey:(NSString *)key andData:(id) data;
+ (id) getDataWithKey:(NSString *)key;


+ (NSString *) getCurrentDate ;

+ (void) openURLWithURL:(NSString *)url;    //打开外部浏览器

//添加键盘弹出和关闭观察模式
+ (void) addKeyBorderObserveWithTarget:(id)target andKeyborderAppearSEL:(SEL)asel eyborderDisappearSEL:(SEL)dsel;

//移除键盘观察
+ (void) removeKeyBorderObserveWithTarget:(id) target;


#pragma mark -- 判断使用者的身份---即使用权限
+ (NSInteger) getUserAuthority;

@end
