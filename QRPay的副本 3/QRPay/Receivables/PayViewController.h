//
//  PayViewController.h
//  QRPay
//
//  Created by yy on 16/9/19.
//  Copyright © 2016年 yy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRCodeCreatView.h"

@interface PayViewController : BasesViewController

@property (nonatomic,strong) NSString *moneyString;
@property (nonatomic,strong) NSString *typeString;
@property (nonatomic,strong) NSString *remarkString;

@property (nonatomic,strong) NSString *payUrl;
@property (nonatomic,strong) NSString *orderid;

@end
