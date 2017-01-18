//
//  MyPartnerTableViewCell.m
//  QRPay
//
//  Created by 黄露 on 2016/11/28.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "MyPartnerTableViewCell.h"

@interface MyPartnerTableViewCell ()

@property (nonatomic ,strong) MyPartnerCellSubView *partnerNameView;   //商户名称

@property (nonatomic ,strong) MyPartnerCellSubView *partnerPhoneView;  //商户电话

@property (nonatomic ,strong) MyPartnerCellSubView *tradeNumView;   //商户成交额

@property (nonatomic ,strong) MyPartnerCellSubView *addCountView;   //新增商户数

@end

@implementation MyPartnerTableViewCell

- (MyPartnerCellSubView *)partnerNameView {
    if (!_partnerNameView) {
        _partnerNameView = [[MyPartnerCellSubView alloc] initWithFrame:CGRectMake(0, 5, WIDTH_VIEW(self.contentView) / 2, (HEIGHT_VIEW(self.contentView) - 20) / 3 ) ];
        _partnerNameView.headerImage = [UIImage imageNamed:@"partner3_1"];
        _partnerNameView.contentFont = [UIFont systemFontOfSize:18 * PPWidth];
        _partnerNameView.contentColor = [UIColor blackColor];
    }
    return _partnerNameView;
}

- (MyPartnerCellSubView *)partnerPhoneView {
    if (!_partnerPhoneView) {
        _partnerPhoneView = [[MyPartnerCellSubView alloc] initWithFrame:CGRectMake(VIEW_MAXX(self.partnerNameView) + 10, 5, WIDTH_VIEW(self.contentView) / 2 - 10, HEIGHT_VIEW(self.partnerNameView))];
        _partnerPhoneView.headerImage = [UIImage imageNamed:@"partner4_1"];
        
        _partnerPhoneView.contentFont = [UIFont systemFontOfSize:17 * PPWidth];
        _partnerPhoneView.contentColor = [UIColor blueColor];
    }
    return _partnerPhoneView;
}

- (MyPartnerCellSubView *)tradeNumView {
    if (!_tradeNumView) {
        _tradeNumView = [[MyPartnerCellSubView alloc] initWithFrame:CGRectMake(0, VIEW_MAXY(self.partnerNameView) + 5, WIDTH_VIEW(self.contentView), (HEIGHT_VIEW(self.contentView) - 20) / 3 )];
        _tradeNumView.headerImage = [UIImage imageNamed:@"partner1_1"];
    }
    return _tradeNumView;
}

- (MyPartnerCellSubView *)addCountView {
    if (!_addCountView) {
        _addCountView = [[MyPartnerCellSubView alloc] initWithFrame:CGRectMake(0, VIEW_MAXY(self.tradeNumView) + 5, WIDTH_VIEW(self.contentView), HEIGHT_VIEW(self.tradeNumView))];
        _addCountView.headerImage = [UIImage imageNamed:@"partner2_1"];
    }
    return _addCountView;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
    [self.contentView addSubview:self.partnerNameView];
    [self.contentView addSubview:self.partnerPhoneView];
    [self.contentView addSubview:self.tradeNumView];
    [self.contentView addSubview:self.addCountView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleBlue;
}

- (void) setPartnerName:(NSString *)partnerName {
    _partnerName = partnerName;
    self.partnerNameView.contentString = partnerName;
}

- (void) setPartnerPhone:(NSString *)partnerPhone {
    _partnerPhone = partnerPhone;
    self.partnerPhoneView.contentString = partnerPhone;
}

- (void) setYesterdayTradeCount:(CGFloat)yesterdayTradeCount {
    _yesterdayTradeCount = yesterdayTradeCount;
    self.tradeNumView.contentString = [NSString stringWithFormat:@"昨日交易量：%f",yesterdayTradeCount];
}

- (void) setNewShopper:(NSInteger)newShopper {
    _newShopper = newShopper;
    self.addCountView.contentString = [NSString stringWithFormat:@"新增商户：%ld",(long)newShopper];
}

@end
