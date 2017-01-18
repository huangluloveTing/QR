//
//  AboutQRView.m
//  QRPay
//
//  Created by 黄露 on 2016/11/18.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "AboutQRView.h"


#define MARGIN (10)

@interface AboutQRView ()

@property (nonatomic ,strong) UIImageView *imageView;
@property (nonatomic ,strong) UILabel *titleLabel;
@property (nonatomic ,assign) CGFloat imageViewHeight;

@end

@implementation AboutQRView

- (instancetype) initWithFrame:(CGRect)frame andImage:(UIImage *)image andTitle:(NSString *)title {
    
    if (self = [super initWithFrame:frame]) {
        self.headerImage = image;
        self.title = title;
        self.imageViewHeight = self.bounds.size.height - 2 * MARGIN;
        [self configViews];
        
        self.imageView.image = image;
        self.titleLabel.text = title;
    }
    
    return self;
}

- (void) configViews {
    [self addSubview:self.imageView];
    [self addSubview:self.titleLabel];
}

#pragma mark -- Private Property GetMoethod

- (UIImageView *) imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(MARGIN, MARGIN, self.imageViewHeight, self.imageViewHeight)];
        _imageView.contentMode = UIViewContentModeScaleToFill;
        
    }
    
    return _imageView;
}

- (UILabel *) titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN + CGRectGetMaxX(self.imageView.frame), CGRectGetMinY(self.imageView.frame), self.bounds.size.width - CGRectGetMaxX(self.imageView.frame) - 2 * MARGIN, self.imageViewHeight)];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textColor = [UIColor lightGrayColor];
    }
    
    return _titleLabel;
}

@end
