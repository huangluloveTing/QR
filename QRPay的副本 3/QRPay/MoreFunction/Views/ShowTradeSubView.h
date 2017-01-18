//
//  ShowTradeSubView.h
//  QRPay
//
//  Created by 黄露 on 2016/11/28.
//  Copyright © 2016年 yy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowTradeSubView : UIView

/**
 *      显示交易量信息的视图   
 */

@property (nonatomic ,copy) NSString *tradeNumber;

@property (nonatomic ,copy) NSString *title;

@property (nonatomic ,strong) UIFont *textFont;

@property (nonatomic ,strong) UIColor *textColor;

@end
