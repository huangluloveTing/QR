//
//  ToSetGestureTableViewCell.h
//  QRPay
//
//  Created by 黄露 on 2016/11/24.
//  Copyright © 2016年 yy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToSetGestureTableViewCell : UITableViewCell

@property (nonatomic ,strong) void (^switchValueChangeBlock)(UISwitch *swch);
@property (nonatomic ,strong) UISwitch *switchView;

@end
