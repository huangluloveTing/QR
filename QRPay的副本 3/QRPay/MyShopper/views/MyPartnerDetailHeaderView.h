//
//  MyPartnerDetailHeaderView.h
//  QRPay
//
//  Created by 黄露 on 2016/11/28.
//  Copyright © 2016年 yy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyShopperChooseBtnView.h"
#import "MyBusinessDetailView.h"

@interface MyPartnerDetailHeaderView : UIView

/**
 *      我的合伙人详情页头部视图
 *
 *      属性依次为：合伙人姓名 ， 合伙人身份证号码，分润百分比，编号，昨日分润，昨日交易额，累计商户,显示合伙人的大概交易信息
 */

@property (nonatomic ,copy) NSString *parterName;
@property (nonatomic ,copy) NSString *idNumber;
@property (nonatomic ,assign) CGFloat percent;
@property (nonatomic ,assign) NSInteger Id;
@property (nonatomic ,strong) NSArray *tradesArr;


@end
