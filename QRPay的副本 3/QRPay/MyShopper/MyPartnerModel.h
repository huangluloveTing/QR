//
//  MyPartnerModel.h
//  QRPay
//
//  Created by 黄露 on 2016/11/28.
//  Copyright © 2016年 yy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyPartnerModel : NSObject

/**
 *      我的合伙人的cell 的model
 *
 *      属性分别为 ： 合伙人姓名，合伙人电话号码，昨日成交额，新增商户
 */

@property (nonatomic ,copy) NSString *partnerName;

@property (nonatomic ,copy) NSString *partnerPhone;

@property (nonatomic ,assign) CGFloat yesterdayTradeCount;

@property (nonatomic ,assign) NSInteger newShopper;

@end
