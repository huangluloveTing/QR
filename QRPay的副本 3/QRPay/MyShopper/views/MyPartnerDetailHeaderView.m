//
//  MyPartnerDetailHeaderView.m
//  QRPay
//
//  Created by 黄露 on 2016/11/28.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "MyPartnerDetailHeaderView.h"

#define NAME_FONT ([UIFont systemFontOfSize:18 * PPWidth])

#define HEAD_TITLE_FONT ([UIFont systemFontOfSize:16 * PPWidth])

@interface MyPartnerDetailHeaderView ()

@property (nonatomic ,strong) MyShopperChooseBtnView *chooseBtnView;     //选项按钮

@property (nonatomic ,strong) UIImageView *headImageView;    //头部imageView

@property (nonatomic ,strong) MyBusinessDetailView *showTradeView;  //头部显示交易信息的视图

@property (nonatomic ,strong) UILabel *nameLabel;       // 合伙人姓名

@property (nonatomic ,strong) UILabel *idNumberView;    // 合伙人的身份证号码

@property (nonatomic ,strong) UILabel *percentlabel;    // 合伙人的分润比

@property (nonatomic ,strong) UILabel *IdLabel;         // 合伙人的ID

@end

@implementation MyPartnerDetailHeaderView {
    
    NSMutableArray *titleArr;
}

- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        trades = [NSMutableArray arrayWithObjects: @"100",@"50000.00",@"500", nil];
////        [self configAllViews];
        
        titleArr = [NSMutableArray arrayWithObjects: @"昨日分润",@"昨日交易额",@"累计商户",nil];
        self.backgroundColor =  TABLEVIEW_GROUPED_BGCOLOR;
        [self configAllViews];
    }
    return self;
}

- (void) layoutSubviews {
    
}

- (void) configAllViews {
    
    self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_VIEW(self), WIDTH_VIEW(self) / 2)];
    
    self.headImageView.image = [UIImage imageNamed:@"partnerBgImg"];
    self.headImageView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:self.headImageView];
    
    CGFloat titleH = HEIGHT_VIEW(self.headImageView) / 8;
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, HEIGHT_VIEW(self.headImageView) - titleH * 4, WIDTH_VIEW(self), titleH)];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.text = @"张孝顺";
    self.nameLabel.font = NAME_FONT;
    
    [self.headImageView addSubview:self.nameLabel];
    
    self.idNumberView = [[UILabel alloc] initWithFrame:CGRectMake(0, VIEW_MAXY(self.nameLabel), WIDTH_VIEW(self), titleH)];
    self.idNumberView.textColor = [UIColor whiteColor];
    self.idNumberView.text = @"513721199909098765";
    self.idNumberView.font = HEAD_TITLE_FONT;
    self.idNumberView.textAlignment = NSTextAlignmentCenter;
    [self.headImageView addSubview:self.idNumberView];
    
    self.percentlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, VIEW_MAXY(self.idNumberView), WIDTH_VIEW(self), titleH)];
    self.percentlabel.text = [NSString stringWithFormat:@"分润百分比：%f",0.38];
    self.percentlabel.font = HEAD_TITLE_FONT;
    self.percentlabel.textColor = [UIColor whiteColor];
    self.percentlabel.textAlignment = NSTextAlignmentCenter;
    [self.headImageView addSubview:self.percentlabel];
    
    self.IdLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, VIEW_MAXY(self.percentlabel), WIDTH_VIEW(self), titleH)];
    self.IdLabel.text = @"000009";
    self.IdLabel.font = HEAD_TITLE_FONT;
    self.IdLabel.textColor = [UIColor whiteColor];
    self.IdLabel.textAlignment = NSTextAlignmentCenter;
    [self.headImageView addSubview:self.IdLabel];
    
    self.showTradeView = [[MyBusinessDetailView alloc] initWithFrame:CGRectMake(0, VIEW_MAXY(self.headImageView), WIDTH_VIEW(self), 40)];
//    self.showTradeView.trades = trades;
    self.showTradeView.titleArr = titleArr;
    
    [self addSubview:self.showTradeView];
    
    self.chooseBtnView = [[MyShopperChooseBtnView alloc] initWithFrame:CGRectMake(0, VIEW_MAXY(self.showTradeView) + 10, WIDTH_VIEW(self), 40) andTitles:@[@"已开通",@"审核中",@"拒绝"]];
    self.chooseBtnView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.chooseBtnView];
}

- (void) setParterName:(NSString *)parterName {
    _parterName = parterName;
    self.nameLabel.text = parterName;
}

- (void) setIdNumber:(NSString *)idNumber {
    _idNumber = idNumber;
    self.idNumberView.text = idNumber;
}

- (void) setPercent:(CGFloat)percent {
    _percent = percent;
    self.percentlabel.text = [NSString stringWithFormat:@"分润百分比：%.2f",percent];
}

- (void) setId:(NSInteger)Id {
    _Id = Id;
    self.IdLabel.text = [NSString stringWithFormat:@"%ld",Id];
}

- (void) setTradesArr:(NSArray *)tradesArr {
    self.showTradeView.trades = tradesArr;
}

@end
