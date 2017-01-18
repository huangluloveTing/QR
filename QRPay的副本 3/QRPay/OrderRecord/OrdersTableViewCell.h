//
//  OrdersTableViewCell.h
//  QRPay
//
//  Created by yy on 16/9/19.
//  Copyright © 2016年 yy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrdersTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@property (weak, nonatomic) IBOutlet UILabel *moneyLable;


@property (weak, nonatomic) IBOutlet UILabel *stateLable;

@property (weak, nonatomic) IBOutlet UILabel *timeLable;

@end
