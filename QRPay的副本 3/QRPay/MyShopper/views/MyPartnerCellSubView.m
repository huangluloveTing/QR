//
//  MyPartnerCellSubView.m
//  QRPay
//
//  Created by 黄露 on 2016/11/28.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "MyPartnerCellSubView.h"


#define IMGPadding (20 * PPWidth)

#define IMGWIDTH_HEIGHT (10)

#define CONTENT_LABEL_FONT (12)

@interface MyPartnerCellSubView ()

@property (nonatomic ,strong) UIImageView *imageView;


@property (nonatomic ,strong) UILabel *contentLabel;

@end

@implementation MyPartnerCellSubView


- (UIImageView *) imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(IMGPadding, 0, IMGWIDTH_HEIGHT,IMGWIDTH_HEIGHT)];
        _imageView.contentMode = UIViewContentModeScaleToFill;
        _imageView.center = CGPointMake(_imageView.center.x, HEIGHT_VIEW(self) / 2);
    }
    
    return _imageView;
}

-(UILabel *) contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_MAXX(self.imageView) + 5, 0, WIDTH_VIEW(self) - VIEW_MAXX(self.imageView) - IMGPadding, HEIGHT_VIEW(self))];
        
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.textColor = [UIColor lightGrayColor];
        _contentLabel.font = [UIFont systemFontOfSize:CONTENT_LABEL_FONT];
    }
    
    return _contentLabel;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    [self addSubview:self.imageView];
    [self addSubview:self.contentLabel];
}

- (void) setContentString:(NSString *)contentString {
    _contentString = contentString;
    self.contentLabel.text = [NSString stringWithFormat:@"  %@",contentString];
}

- (void) setHeaderImage:(UIImage *)headerImage {
    _headerImage = headerImage;
    self.imageView.image = headerImage;
}

- (void) setContentFont:(UIFont *)contentFont {
    _contentFont = contentFont;
    self.contentLabel.font = contentFont;
}

- (void) setContentColor:(UIColor *)contentColor {
    _contentColor = contentColor;
    self.contentLabel.textColor = contentColor;
}

@end
