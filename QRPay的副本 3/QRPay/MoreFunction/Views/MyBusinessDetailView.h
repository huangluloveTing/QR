//
//  MyBusinessDetailView.h
//  QRPay
//
//  Created by 黄露 on 2016/11/28.
//  Copyright © 2016年 yy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowTradeSubView.h"

//获取我的交易详情的视图，包含新增商户，昨日交易量，累计商户

@interface MyBusinessDetailView : UIView

//背景颜色
@property (nonatomic ,strong) UIColor *bgColor;

//字体颜色
@property (nonatomic ,strong) UIColor *titleColor;

//数据
@property (nonatomic ,strong) NSArray *trades;

//标题的title 数组
@property (nonatomic ,strong) NSArray *titleArr;



@end
