//
//  UIButton+MineButton.m
//  QRPay
//
//  Created by 黄露 on 2016/11/21.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "UIButton+MineButton.h"
#import <objc/runtime.h>


@interface UIButton ()

@end

static const void *UtilityKey = &UtilityKey;

@implementation UIButton (MineButton)

- (instancetype) initWithType:(UIButtonType)butype andTitle:(NSString *)title titleColor:(UIColor *)titleColor frame:(CGRect)frame {
    
    if (self == [super initWithFrame:frame]) {
        self = [UIButton buttonWithType:butype];
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:titleColor forState:UIControlStateNormal];
        self.frame = frame;
        
    }
    return self;
}

@end
