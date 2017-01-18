//
//  UIButton+MineButton.h
//  QRPay
//
//  Created by 黄露 on 2016/11/21.
//  Copyright © 2016年 yy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BtnPressBlock)(UIButton *btn);

@interface UIButton (MineButton)


- (instancetype) initWithType:(UIButtonType) butype andTitle:(NSString *)title titleColor:(UIColor *)titleColor frame:(CGRect)frame;

@end
