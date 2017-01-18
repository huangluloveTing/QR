//
//  MyPartnerOrderListTableViewCell.h
//  QRPay
//
//  Created by 黄露 on 2016/11/29.
//  Copyright © 2016年 yy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPartnerOrderListTableViewCell : UITableViewCell

@property (nonatomic ,copy) NSString *orderId;

@property (nonatomic ,copy) NSString *orderTime;

@property (nonatomic ,assign) CGFloat percent;

@end
