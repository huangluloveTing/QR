//
//  BindShopperOrPartnerViewController.h
//  QRPay
//
//  Created by 黄露 on 2016/12/1.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "BasesViewController.h"


typedef NS_ENUM(NSInteger , ActionType) {
    action_BindShopper = 0,
    action_bindPartner
};

@interface BindShopperOrPartnerViewController : BasesViewController

@property (nonatomic ,assign) ActionType actionType;

@end
