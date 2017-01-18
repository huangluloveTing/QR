//
//  MyPartnerOrderListTableViewCell.m
//  QRPay
//
//  Created by 黄露 on 2016/11/29.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "MyPartnerOrderListTableViewCell.h"


@interface MyPartnerOrderListTableViewCell ()

@property (nonatomic ,strong) UILabel *orderIdLabel;

@property (nonatomic ,strong) UILabel *timeLabel;

@property (nonatomic ,strong) UILabel *percentLabel;

@end

@implementation MyPartnerOrderListTableViewCell

- (void) layoutSubviews {
    [super layoutSubviews];
    
    [self.contentView addSubview:self.orderIdLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.percentLabel];
}

- (UILabel *) orderIdLabel {
    if (!_orderIdLabel) {
        _orderIdLabel = [[UILabel alloc] initWithFrame:CGRectMake( 20, 10 , WIDTH_VIEW(self.contentView) - 80, HEIGHT_VIEW(self.contentView) / 2 - 10)];
        
        _orderIdLabel.textColor = [UIColor blackColor];
        
        _orderIdLabel.font = [UIFont systemFontOfSize:17 * PPWidth];
        
        _orderIdLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    return _orderIdLabel;
}

- (UILabel *) timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(34, VIEW_MAXY(self.orderIdLabel) + 5, WIDTH_VIEW(self.contentView) - 100, HEIGHT_VIEW(self.contentView) - VIEW_MAXY(self.orderIdLabel) - 10)];
        
        _timeLabel.textColor = [UIColor lightGrayColor];
        _timeLabel.font = [UIFont systemFontOfSize:14];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, VIEW_MINY(_timeLabel),10  , 10)];
        
        imageView.center = CGPointMake(imageView.center.x, _timeLabel.center.y);
        
        imageView.contentMode = UIViewContentModeScaleToFill;
        
        imageView.image = [UIImage imageNamed:@"tab_list_h"];
        [self.contentView addSubview:imageView];
    }
    
    return _timeLabel;
}

- (UILabel *)percentLabel {
    if (!_percentLabel) {
        _percentLabel = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_MAXX(self.orderIdLabel), 0, WIDTH_VIEW(self.contentView) - VIEW_MAXX(self.orderIdLabel) - 5, HEIGHT_VIEW(self.contentView))];
        
        _percentLabel.textAlignment = NSTextAlignmentCenter;
        _percentLabel.textColor = [UIColor blackColor];
        _percentLabel.font = [UIFont systemFontOfSize:18];
    }
    
    return _percentLabel;
}

- (void) setOrderId:(NSString *)orderId {
    _orderId = orderId;
    self.orderIdLabel.text = [NSString stringWithFormat:@"订单号: %@",orderId];
}

- (void) setOrderTime:(NSString *)orderTime {
    _orderTime = orderTime;
    self.timeLabel.text = orderTime;
    
}

- (void) setPercent:(CGFloat)percent {
    _percent = percent;
    self.percentLabel.text = [NSString stringWithFormat:@"%.2f",percent];
}

@end
