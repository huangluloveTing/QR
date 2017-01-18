//
//  ShowTradeSubView.m
//  QRPay
//
//  Created by 黄露 on 2016/11/28.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "ShowTradeSubView.h"


#define SubH ((HEIGHT_VIEW(self) - 15 ) / 2)

@interface ShowTradeSubView ()

@property (nonatomic ,strong) UILabel *tradeLabel;
@property (nonatomic ,strong) UILabel *titleLabel;

@end

@implementation ShowTradeSubView

- (instancetype) initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.textFont = [UIFont systemFontOfSize:18 * PPWidth];
        self.textColor = [UIColor whiteColor];
    }
    
    return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
    [self addSubview:self.tradeLabel];
    [self addSubview:self.titleLabel];
}

- (UILabel *)tradeLabel {
    
    if (!_tradeLabel) {
        _tradeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, WIDTH_VIEW(self), SubH)];
        
        _tradeLabel.textAlignment = NSTextAlignmentCenter;
        
        _tradeLabel.font =  self.textFont;
        
        _tradeLabel.textColor = self.textColor;
    }
    
    return _tradeLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, VIEW_MAXY(self.tradeLabel) + 5, WIDTH_VIEW(self), SubH)];
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        _titleLabel.font = self.textFont;
        
        _titleLabel.textColor = self.textColor;
    }
    return _titleLabel;
}

-(void) setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

- (void) setTradeNumber:(NSString *)tradeNumber {
    _tradeNumber = tradeNumber;
    self.tradeLabel.text = tradeNumber;
}

@end
