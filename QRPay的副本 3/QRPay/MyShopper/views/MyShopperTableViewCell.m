//
//  MyShopperTableViewCell.m
//  QRPay
//
//  Created by 黄露 on 2016/11/27.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "MyShopperTableViewCell.h"

@interface MyShopperTableViewCell ()

@property (nonatomic ,strong) UIImageView *shopImageView;

@property (nonatomic ,strong) UILabel *shopNameLabel;

@property (nonatomic ,strong) UILabel *registerTimeLabel;

@property (nonatomic ,strong) UILabel *totalAccountTipsLabel;

@property (nonatomic ,strong) UILabel *accountLabel;

@property (nonatomic ,strong) UILabel *bottomLine;

@end

@implementation MyShopperTableViewCell {
    CGFloat imageH;
}

#pragma mark -- SubViews

- (UIImageView *)shopImageView {
    if (!_shopImageView) {
        
        imageH = HEIGHT_VIEW(self.contentView) / 3;
        _shopImageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageH, imageH, imageH, imageH)];
        _shopImageView.layer.masksToBounds = YES;
        _shopImageView.layer.cornerRadius = imageH / 2;
        _shopImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    
    return _shopImageView;
}

- (UILabel *)shopNameLabel {
    if (!_shopNameLabel) {
        imageH = HEIGHT_VIEW(self.contentView) / 3;
        _shopNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageH * 3, 10, CGRectGetMinX(self.totalAccountTipsLabel.frame) - imageH * 3, imageH)];
        _shopNameLabel.font = [UIFont systemFontOfSize:18 * PPWidth];
        _shopNameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _shopNameLabel;
}

- (UILabel *)registerTimeLabel {
    if (!_registerTimeLabel) {
        _registerTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_MAXX(self.shopImageView) + 10 *PPWidth, VIEW_MAXY(self.shopNameLabel) + 10 * PPWidth, VIEW_MIXX(self.totalAccountTipsLabel) - VIEW_MAXX(self.shopImageView),  HEIGHT_VIEW(self.totalAccountTipsLabel))];
        _registerTimeLabel.font = [UIFont systemFontOfSize:14 * PPWidth];
        _registerTimeLabel.textColor = [UIColor lightGrayColor];
        
    }
    return _registerTimeLabel;
}

- (UILabel *)totalAccountTipsLabel {
    if (!_totalAccountTipsLabel) {
        _totalAccountTipsLabel = [[UILabel alloc] init];
        NSString *tipsStr = @"本月累计交易";
        _totalAccountTipsLabel.text = tipsStr;
        CGSize size = [tipsStr sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14 * PPWidth]}];
        
        _totalAccountTipsLabel.frame = CGRectMake(WIDTH_VIEW(self.contentView) - size.width - 60 * PPWidth, VIEW_MAXY(self.shopNameLabel) + 10 * PPWidth, size.width + 50 * PPWidth, HEIGHT_VIEW(self.contentView) - VIEW_MAXY(self.shopNameLabel) - 15 * PPWidth);
        _totalAccountTipsLabel.textColor =[ UIColor lightGrayColor];
        _totalAccountTipsLabel.font = [UIFont systemFontOfSize:14 * PPWidth];
        _totalAccountTipsLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _totalAccountTipsLabel;
}

- (UILabel *)accountLabel {
    if (!_accountLabel) {
        _accountLabel = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_MIXX(self.totalAccountTipsLabel), VIEW_MINY(self.shopNameLabel), WIDTH_VIEW(self.totalAccountTipsLabel), HEIGHT_VIEW(self.shopNameLabel))];
        
        _accountLabel.font = [UIFont systemFontOfSize:16 * PPWidth];
        _accountLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _accountLabel;
}

- (UILabel *) bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UILabel alloc] initWithFrame:CGRectMake(0, HEIGHT_VIEW(self.contentView) - 1, WIDTH_VIEW(self.contentView), 1)];
        _bottomLine.backgroundColor = RGBCOLOR(239, 239, 244);
    }
    
    return _bottomLine;
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
//        self.imageView.frame = CGRectMake(imageH, imageH, imageH, imageH);
//        self.imageView.layer.masksToBounds = YES;
//        self.imageView.layer.cornerRadius = imageH / 2;
        
        
//        self.textLabel.frame = CGRectMake(VIEW_MAXY(self.imageView) + 10, 10 , WIDTH_VIEW(self.contentView), 30 * PPWidth);
        
//        self.textLabel.font = [UIFont systemFontOfSize:18 * PPWidth];
        
//        self.detailTextLabel.frame = CGRectMake(VIEW_MAXX(self.imageView), VIEW_MAXY(self.contentView) - 20 * PPWidth, WIDTH_VIEW(self.contentView), imageH / 2);
//        self.detailTextLabel.font = [UIFont systemFontOfSize:14 * PPWidth];
//        self.detailTextLabel.textColor = [UIColor lightGrayColor];
    }
    
    return self;
}

- (void) setShopName:(NSString *)shopName {
    _shopName = shopName;
    self.shopNameLabel.text = shopName;
}

- (void) setHeaderPlaceImage:(UIImage *)headerPlaceImage {
    _headerPlaceImage = headerPlaceImage;
    self.shopImageView.image = headerPlaceImage;
}

- (void) setRegisterTime:(NSString *)registerTime {
    self.registerTimeLabel.text = registerTime;
}

- (void) setTotalAccount:(NSString *)totalAccount {
    _totalAccount = totalAccount;
    self.accountLabel.text = totalAccount;
    
    if (totalAccount.length == 0 || totalAccount == nil) {
        self.totalAccountTipsLabel.hidden = YES;
    }
}

- (void) layoutSubviews {
    [self.contentView addSubview:self.shopImageView];
    [self.contentView addSubview:self.shopNameLabel];
    [self.contentView addSubview:self.registerTimeLabel];
    [self.contentView addSubview:self.accountLabel];
    [self.contentView addSubview:self.totalAccountTipsLabel];
    [self.contentView addSubview:self.bottomLine];
}

@end
