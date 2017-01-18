//
//  MyShareFeeTableViewCell.m
//  QRPay
//
//  Created by 黄露 on 2016/11/28.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "MyShareFeeTableViewCell.h"


#define IMG_WIDTH (10)

#define VIEW_PADDING (8)

@interface MyShareFeeTableViewCell ()

@property (nonatomic ,strong) UIImageView *headImageView;

@property (nonatomic ,strong) UILabel *nameLabel;

@property (nonatomic ,strong) UILabel *timeLabel;

@property (nonatomic ,strong) UILabel *sharePercentLabel;

@property (nonatomic ,strong) UIImageView *tipsImageView;

@end

@implementation MyShareFeeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (UIImageView *) headImageView {
    
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_PADDING, VIEW_PADDING, IMG_WIDTH, IMG_WIDTH)];
        _headImageView.contentMode = UIViewContentModeScaleToFill;
    }
    
    return _headImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel ) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_PADDING * 2 + IMG_WIDTH, VIEW_PADDING, WIDTH_VIEW(self.contentView) - 4 * IMG_WIDTH, (HEIGHT_VIEW(self.contentView) - 3 * VIEW_PADDING) / 2  + VIEW_PADDING)];
        self.headImageView.center = CGPointMake(self.headImageView.center.x, _nameLabel.center.y);
        
        _nameLabel.textColor = [[UIColor blueColor] colorWithAlphaComponent:0.4];
        
        _nameLabel.font = [UIFont systemFontOfSize:18];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLabel;
}

- (UILabel *) timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_PADDING, VIEW_MAXY(self.nameLabel) + VIEW_PADDING, VIEW_MIXX(self.sharePercentLabel), (HEIGHT_VIEW(self.contentView) - 3 * VIEW_PADDING)/ 2 - VIEW_PADDING / 2) ];
        
        _timeLabel.textColor = [UIColor blackColor];
        _timeLabel.font = [UIFont systemFontOfSize:15];
        
        _timeLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    return _timeLabel;
}

- (UILabel *)sharePercentLabel {
    if (!_sharePercentLabel) {
        _sharePercentLabel = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_VIEW(self.contentView) - (2 * VIEW_PADDING + IMG_WIDTH) - 50, VIEW_MAXY(self.nameLabel), 50, HEIGHT_VIEW(self.contentView) / 2)];
        
        _sharePercentLabel.textColor = [UIColor blackColor];
        
        _sharePercentLabel.font = [UIFont systemFontOfSize:15];
        
        _sharePercentLabel.textAlignment = NSTextAlignmentRight;
    }
    
    return _sharePercentLabel;
}

- (UIImageView *) tipsImageView {
    if (!_tipsImageView ) {
        _tipsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_MAXX(self.sharePercentLabel) + VIEW_PADDING, VIEW_MINY(self.sharePercentLabel), IMG_WIDTH, IMG_WIDTH)];
        _tipsImageView.center = CGPointMake(_tipsImageView.center.x, self.sharePercentLabel.center.y);
        _tipsImageView.contentMode = UIViewContentModeScaleToFill;
        _tipsImageView.image = [UIImage imageNamed:@"qinglihuancun3x"];
    }
    
    return _tipsImageView;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
    [self.contentView addSubview:self.headImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.sharePercentLabel];
    [self.contentView addSubview:self.tipsImageView];
}

- (void) setHeadImage:(UIImage *)headImage {
    _headImage = headImage ;
    self.headImageView.image = headImage;
}

- (void) setNameStr:(NSString *)nameStr {
    _nameStr = nameStr;
    self.nameLabel.text = nameStr;
}

- (void) setTimeStr:(NSString *)timeStr {
    _timeStr = timeStr;
    self.timeLabel.text = timeStr;
}

- (void) setSharePercent:(CGFloat)sharePercent {
    _sharePercent = sharePercent;
    self.sharePercentLabel.text = [NSString stringWithFormat:@"%.2f",sharePercent];
}

@end
