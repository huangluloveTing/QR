//
//  MyAppUserInformation.h
//  QRPay
//
//  Created by 黄露 on 2016/12/1.
//  Copyright © 2016年 yy. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  app使用者的个人信息
 *
 *  包含所有app相关信息
 */

@interface MyAppUserInformation : NSObject

@property (nonatomic ,assign) BOOL appStatus;
@property (nonatomic ,copy) NSString *appUsername;
@property (nonatomic ,assign) NSInteger authority;
@property (nonatomic ,copy) NSString *companyName;
@property (nonatomic ,copy) NSString *servicePhone;
@property (nonatomic ,assign) CGFloat maxAmountAlipay;
@property (nonatomic ,assign) CGFloat maxAmountWechat;
@property (nonatomic ,assign) CGFloat minAmountAlipay;
@property (nonatomic ,assign) CGFloat minAmountWechat;

- (instancetype) initWithDic:(NSDictionary *)dic;

@end
