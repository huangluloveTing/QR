//
//  MyAppUserInformation.m
//  QRPay
//
//  Created by 黄露 on 2016/12/1.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "MyAppUserInformation.h"

@implementation MyAppUserInformation

- (instancetype) initWithDic:(NSDictionary *)dic {
    /*
     @property (nonatomic ,assign) BOOL appStatus;
     @property (nonatomic ,copy) NSString *appUsername;
     @property (nonatomic ,assign) NSInteger authority;
     @property (nonatomic ,copy) NSString *companyName;
     @property (nonatomic ,copy) NSString *servicePhone;
     @property (nonatomic ,assign) CGFloat maxAmountAlipay;
     @property (nonatomic ,assign) CGFloat maxAmountWechat;
     @property (nonatomic ,assign) CGFloat minAmountAlipay;
     @property (nonatomic ,assign) CGFloat minAmountWechat;
     */
    if (self = [super init]) {
        self.appStatus = [dic[@"appStatus"] boolValue];
        self.appUsername = [NSString stringWithFormat:@"%@",dic[@"appUsername"]];
        self.authority = [dic[@"authority"] integerValue];
        self.companyName = dic[@"companyName"];
        self.servicePhone = dic[@"servicePhone"];
        self.maxAmountAlipay = [dic[@"maxAmountAlipay"] floatValue];
        self.maxAmountWechat = [dic[@"maxAmountWechat"] floatValue];
        self.minAmountAlipay = [dic[@"minAmountAlipay"] floatValue];
        self.minAmountWechat = [dic[@"minAmountWechat"] floatValue];
    }
    return self;
}

@end
