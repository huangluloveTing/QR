//
//  ReceivablesHeaderView.m
//  QRPay
//
//  Created by yy on 16/9/19.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "ReceivablesHeaderView.h"

@interface ReceivablesHeaderView ()

@property (nonatomic ,strong) UIButton *QRViewBtn;

@end

@implementation ReceivablesHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.04];
        [self addSubview:self.moneyLable];
        [self addSubview:self.tipsable];
        [self addSubview:self.QRViewBtn];

        [self addSubview:self.addRemarkBtn];
        [self addSubview:self.remarkLable];
    }
    return self;
}

- (UIButton *) QRViewBtn {
    if (!_QRViewBtn) {
        _QRViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _QRViewBtn.frame = CGRectMake(10, 30, 30, 30);
        _QRViewBtn.backgroundColor = [UIColor blueColor];
        [_QRViewBtn addTarget:self action:@selector(QRBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _QRViewBtn;
}

-(UILabel *)tipsable
{
    if (!_tipsable) {
        
        _tipsable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 20)];
        _tipsable.textColor = [UIColor whiteColor];
        
        _tipsable.font = [UIFont systemFontOfSize:10.];
        _tipsable.backgroundColor = [UIColor darkGrayColor];
    }
    return _tipsable;
}

-(UIButton *)addRemarkBtn
{
    if (!_addRemarkBtn) {
        _addRemarkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addRemarkBtn.frame = CGRectMake(kDeviceWidth-100, HEIGHT_VIEW(self)-20, 100, 20);
        [_addRemarkBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_addRemarkBtn setTitle:@"添加收款备注" forState:UIControlStateNormal];
        _addRemarkBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
        [_addRemarkBtn addTarget:self action:@selector(addRemarkBtnHandel) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _addRemarkBtn;
}

- (void) QRBtnAction:(UIButton *)sender {
    if (self.tapAboutQRBtnBlock) {
        self.tapAboutQRBtnBlock(CGPointMake(CGRectGetWidth(sender.frame) / 2 + CGRectGetMinX(sender.frame), CGRectGetMaxY(sender.frame) + 5));
    }
}

-(void)addRemarkBtnHandel
{
    if (self.AddClickIndexBlock) {
        self.AddClickIndexBlock();
    }
}



-(UILabel *)remarkLable
{
    if (!_remarkLable) {
        _remarkLable = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height/2+25*PPHeight, kDeviceWidth, 20)];
        _remarkLable.textColor = [UIColor lightGrayColor];
        _remarkLable.textAlignment = NSTextAlignmentCenter;
        _remarkLable.font = [UIFont systemFontOfSize:12.0];

    }
    return _remarkLable;
}



-(UILabel *)moneyLable
{
    if (!_moneyLable) {
        
        _moneyLable = [[UILabel alloc]initWithFrame:self.bounds];
        _moneyLable.text = @"￥0.00";
        _moneyLable.backgroundColor = RGBACOLOR(235, 235, 235, 2);
        _moneyLable.textAlignment = NSTextAlignmentCenter;
        _moneyLable.textColor = [UIColor blackColor];
        _moneyLable.backgroundColor = [UIColor clearColor];
        _moneyLable.font = [UIFont fontWithName:@"Arial-BoldMT" size:50];
        
    }
    return _moneyLable;
}

- (void) setTipsTitle:(NSString *)tipsTitle {
    if (tipsTitle) {
        self.tipsable.text = tipsTitle;
    }
}
@end
