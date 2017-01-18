//
//  TitleAndContentView.m
//  QRPay
//
//  Created by 黄露 on 2016/11/29.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "TitleAndContentView.h"

@interface TitleAndContentView ()

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic ,strong) UILabel *contentLabel;

@end

@implementation TitleAndContentView

- (void) layoutSubviews {
    [super layoutSubviews];
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.contentLabel];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH_VIEW(self) / 3, HEIGHT_VIEW(self))];
        
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    return _titleLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_MAXX(self.titleLabel), 0, WIDTH_VIEW(self) * 2 / 3, HEIGHT_VIEW(self))];
        
        _contentLabel.textColor = [UIColor blackColor];
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    return _contentLabel;
}


- (void) setTitle:(NSString *)title {
    _title = title ;
    self.titleLabel.text = title;
}

- (void)setContentString:(NSString *)contentString {
    _contentString = contentString;
    self.contentLabel.text = contentString;
}

- (void) setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    self.titleLabel.textColor = titleColor;
}

- (void) setContentColor:(UIColor *)contentColor {
    _contentColor = contentColor;
    self.contentLabel.textColor = contentColor;
}

- (void) setTitleFont:(UIFont *)titleFont  {
    _titleFont = titleFont;
    self.titleLabel.font = titleFont;
}

- (void) setContentFont:(UIFont *)contentFont {
    _contentFont = contentFont;
    self.contentLabel.font = contentFont;
}

- (void) toAdjustToFit {
    CGSize size = [self.title sizeWithAttributes:@{NSFontAttributeName : self.titleLabel.font}];
    
    self.titleLabel.frame = CGRectMake(0, 0, size.width, HEIGHT_VIEW(self));
    self.contentLabel.frame = CGRectMake(VIEW_MAXX(self.titleLabel) + 10, 0, WIDTH_VIEW(self) - VIEW_MAXX(self.titleLabel)- 10 , HEIGHT_VIEW(self));
}

@end
