//
//  MyShopperChooseBtnView.h
//  QRPay
//
//  Created by 黄露 on 2016/11/26.
//  Copyright © 2016年 yy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyShopperChooseBtnView : UIView

//按钮的标题数组
@property (nonatomic ,strong) NSArray *btnTitles;


@property (nonatomic ,strong) UIColor *btnbgColor;

@property (nonatomic ,strong) UIColor *bottomLineColor;

@property (nonatomic ,strong) UIColor *tapedBtnColor;

//点击对应的按钮的block
@property (nonatomic ,strong) void (^tapedChooseBtnBlock)( NSInteger tag);

- (instancetype) initWithFrame:(CGRect)frame andTitles:(NSArray *)titles ;

@end
