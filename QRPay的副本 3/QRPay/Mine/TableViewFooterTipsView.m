//
//  TableViewFooterTipsView.m
//  QRPay
//
//  Created by 黄露 on 2016/11/25.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "TableViewFooterTipsView.h"

@interface TableViewFooterTipsView ()

#define IMAGEW (40)

@property (nonatomic ,strong) UILabel *tipsLabel;
@property (nonatomic ,strong) UIImageView *tipsHeadImageView;

@end

@implementation TableViewFooterTipsView

- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    [self addSubview:self.tipsLabel];
    [self addSubview:self.tipsHeadImageView];
}

- (UILabel *) tipsLabel {
    if (!_tipsLabel ) {
        _tipsLabel = [[UILabel alloc] init];
        
        _tipsLabel.textAlignment = NSTextAlignmentLeft;
        _tipsLabel.numberOfLines = 0;
        _tipsLabel.font =[UIFont systemFontOfSize:11 * PPWidth];
        
        NSString *tipsStr = @"该信息用来接收结算资金，请仔细填写商户银行卡信息\n银行卡开户名必须与身份证姓名相同\n联行号信息若未查询成功，请填写所属市级分行查询联行号";
        
        _tipsLabel.text = tipsStr;
        
        _tipsLabel.textAlignment = NSTextAlignmentLeft;
        
        _tipsLabel.frame = CGRectMake(IMAGEW + 10, 5, WIDTH_VIEW(self) - IMAGEW - 20, 80);
    }
    return _tipsLabel;
}

- (UIImageView *)tipsHeadImageView {
    if (!_tipsHeadImageView) {
        _tipsHeadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, IMAGEW / 3, IMAGEW / 3)];
        
        _tipsHeadImageView.center = CGPointMake(5 + IMAGEW / 2, self.tipsLabel.center.y);
        
        _tipsHeadImageView.contentMode = UIViewContentModeScaleToFill;
        _tipsHeadImageView.image = [UIImage imageNamed:@"tab_home_h"];
        
    }
    return _tipsHeadImageView;
}

- (void) setFontsize:(CGFloat)fontsize {
    _fontsize = fontsize;
    self.tipsLabel.font = [UIFont systemFontOfSize:fontsize];
}

- (void )setContentStr:(NSString *)contentStr {
    _contentStr = contentStr;
    self.tipsLabel.text = contentStr;
}

@end
