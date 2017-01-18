//
//  MyShopperChooseBtnView.m
//  QRPay
//
//  Created by 黄露 on 2016/11/26.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "MyShopperChooseBtnView.h"

#define Padding (1 * PPWidth)

@interface MyShopperChooseBtnView ()

@property (nonatomic ,strong) UILabel *bottomLabel;

@end

@implementation MyShopperChooseBtnView
{
    CGFloat btnWidth;   //按钮的宽度
    NSMutableArray *allBtns;   //所有按钮的数组
}

- (instancetype) initWithFrame:(CGRect)frame andTitles:(NSArray *)titles {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        allBtns = [NSMutableArray array];
        self.tapedBtnColor = [UIColor lightGrayColor];
        self.btnTitles = titles;
        [self configViews];
        [self addSubview:self.bottomLabel];
    }
    
    return self;
}

- (void)configViews {
    if (self.btnTitles.count > 0) {
        
        btnWidth = (WIDTH_VIEW(self) - (self.btnTitles.count - 1) * Padding) / self.btnTitles.count;
        
        for (int i = 0; i < self.btnTitles.count; i ++) {
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(i * (btnWidth + Padding), 0, btnWidth, HEIGHT_VIEW(self) - 2);
            btn.tag = 100 + i;
            [btn setTitle:self.btnTitles[i] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:14 * PPWidth];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            [btn addTarget:self action:@selector(chooseBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            
            if (i == 0) {
                [btn setTitleColor:self.tapedBtnColor forState:UIControlStateNormal];
            }
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_MAXX(btn), 0, Padding, HEIGHT_VIEW(self))];
            
            label.backgroundColor = [UIColor lightGrayColor];
            
            [self addSubview:label];
            
            [self addSubview:btn];
            
            [allBtns addObject:btn];
        }
    }
}

- (UILabel *)bottomLabel {
    if (! _bottomLabel) {
        _bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, HEIGHT_VIEW(self ) - 1, btnWidth, 1)];
        
        _bottomLabel.backgroundColor = [UIColor darkGrayColor];
        
    }
    
    return _bottomLabel;
}

- (void) chooseBtnAction:(UIButton *)sender {
    
    WEAKSELF
    for (UIButton *btn in allBtns) {
        if (sender == btn) {
            [btn setTitleColor:self.tapedBtnColor forState:UIControlStateNormal];
            
            [UIView animateWithDuration:0.25 animations:^{
                CGRect tapedFrame = btn.frame;
                
                tapedFrame.origin.y = HEIGHT_VIEW(self) - 1;
                tapedFrame.size.height = 1;
                
                weakSelf.bottomLabel.frame = tapedFrame;
            }];
        }
        
        else {
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
    
    if (self.tapedChooseBtnBlock) {
        self.tapedChooseBtnBlock(sender.tag - 100);
    }
}

- (void)setBtnbgColor:(UIColor *)btnbgColor {
    if (btnbgColor) {
        for (UIButton *btn in allBtns) {
            btn.backgroundColor = btnbgColor;
        }
    }
}

- (void) setBottomLineColor:(UIColor *)bottomLineColor {
    self.bottomLabel.backgroundColor = bottomLineColor;
}

- (void) setTapedBtnColor:(UIColor *)tapedBtnColor {
    _tapedBtnColor = tapedBtnColor;

}

@end
