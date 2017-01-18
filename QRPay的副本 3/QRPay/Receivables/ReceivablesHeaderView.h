//
//  ReceivablesHeaderView.h
//  QRPay
//
//  Created by yy on 16/9/19.
//  Copyright © 2016年 yy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReceivablesHeaderView : UIView


@property (nonatomic , strong)void(^AddClickIndexBlock)();

@property (nonatomic ,strong) void (^tapAboutQRBtnBlock)(CGPoint);

@property (nonatomic , strong)UILabel *tipsable;
@property (nonatomic , strong)UILabel *moneyLable;
@property (nonatomic , strong)UIButton *addRemarkBtn;  //添加收款备注
@property (nonatomic , strong)UILabel *remarkLable;


@property (nonatomic ,copy) NSString *tipsTitle;  //获取当前时间

@end
