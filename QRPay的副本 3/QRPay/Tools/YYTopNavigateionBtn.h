//
//  YYTopNavigateionBtn.h
//  QRCodePay
//
//  Created by yy on 16/5/30.
//  Copyright © 2016年 yy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YYTopNavigationBtnDelegate <NSObject>

-(void)navigationBtnClick:(UIButton *)button;

@end



@interface YYTopNavigateionBtn : UIView

-(id)initWithFrame:(CGRect)frame withTitle:(NSArray *)titleArr;

@property (nonatomic , strong)UILabel *lable;


@property (nonatomic , weak)id<YYTopNavigationBtnDelegate>delegate;



@end
