//
//  ToSetGestureTableViewCell.m
//  QRPay
//
//  Created by 黄露 on 2016/11/24.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "ToSetGestureTableViewCell.h"

@interface ToSetGestureTableViewCell ()

/**
 *    去设置手势锁的选择cell
 */
@property (nonatomic ,strong) UILabel *titleLabel;
@property (nonatomic ,strong) UIImageView *headImageView;


@end

@implementation ToSetGestureTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (UILabel *) titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_MAXX(self.headImageView), 5, VIEW_MAXX(self.switchView) - VIEW_MAXX(self.headImageView) , HEIGHT_VIEW(self.contentView) - 10)];
        _titleLabel.text = @"   手 势 锁";
        _titleLabel.textColor = [UIColor lightGrayColor];
        _titleLabel.font = [UIFont systemFontOfSize:18];
    }
    
    return _titleLabel;
}

- (UIImageView *) headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, HEIGHT_VIEW(self.contentView) - 20 , HEIGHT_VIEW(self.contentView) - 20)];
        _headImageView.image = [UIImage imageNamed:@"gesture"];
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
        
    }
    
    return _headImageView;
}

- (UISwitch *) switchView {
    if (!_switchView) {
        _switchView = [[UISwitch alloc] initWithFrame:CGRectMake(WIDTH_VIEW(self.contentView) - 55, 5, 50, HEIGHT_VIEW(self.contentView) - 10)];
        
        [_switchView addTarget:self action:@selector(switchAction) forControlEvents:UIControlEventValueChanged];
    }
    
    return _switchView;
}

- (void) layoutSubviews {
    [self.contentView addSubview:self.headImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.switchView];
}

- (void) switchAction {
    if (self.switchValueChangeBlock) {
        self.switchValueChangeBlock(self.switchView);
    }
}
@end
