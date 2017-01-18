//
//  MyPartnerListModel.h
//  QRPay
//
//  Created by 黄露 on 2016/11/29.
//  Copyright © 2016年 yy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger , PayResultStatus) {
    Pay_Success = 0,
    Pay_Watting,
    Pay_Failed,
    Pay_Unknown
};

@interface MyPartnerListModel : NSObject

/**
 *     我的合伙人的订单详情的Model
 *
 *
 *      下面为model 的属性
 *
 *
 */


//订单编号
@property (nonatomic ,copy) NSString *orderId;

//合伙人编号
@property (nonatomic ,copy) NSString *partnerId;

//销售人员编号
@property (nonatomic ,copy) NSString *salerId;

//商户手续费
@property (nonatomic ,assign) CGFloat rate;

//银行订单号
@property (nonatomic ,copy) NSString *bankOrderId;

//交易金额
@property (nonatomic ,assign) CGFloat money;

//交易时间
@property (nonatomic ,copy) NSString *tradeTime;

//支付状态
@property (nonatomic ,assign) PayResultStatus payResultStatus;

@end
