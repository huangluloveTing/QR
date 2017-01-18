//
//  YYNumberKeyboard.h
//  QRPay
//
//  Created by yy on 16/9/18.
//  Copyright © 2016年 yy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YYNumberKeyboardDelegate <NSObject>

-(void)getResultMoneyString:(NSString *)moneyStr;
-(void)getSureBtnTypeString:(NSString *)typeStr;

@end

@interface YYNumberKeyboard : UIView
@property (nonatomic , copy) NSString *resultStr;
@property (nonatomic , copy) NSString *typeMaxAmount;
@property (nonatomic , assign)BOOL clickPoint;

@property (nonatomic , weak)id<YYNumberKeyboardDelegate>delegate;

@end
