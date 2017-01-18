//
//  MyBusinessDetailView.m
//  QRPay
//
//  Created by 黄露 on 2016/11/28.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "MyBusinessDetailView.h"

#define Padding (1)

@interface MyBusinessDetailView ()

@property (nonatomic ,strong) NSMutableArray *subViews;

@end

@implementation MyBusinessDetailView {
    NSArray *subTitles;
}

- (instancetype) initWithFrame:(CGRect)frame {
    if (self =[super initWithFrame:frame]) {
        self.subViews = [NSMutableArray array];
        
        self.bgColor = RGBCOLOR(40, 126, 251);
        
        subTitles = @[@"新增商户",@"昨日交易额",@"累计商户"];
        
        [self configSubView];
        
        
    }
    return self;
}

- (void) configSubView {
    
    CGFloat laWidth = (WIDTH_VIEW(self) - 2 * Padding) / 3;
    CGFloat H = HEIGHT_VIEW(self);
    
    for (int i = 0; i < 3; i++) {
        
        ShowTradeSubView *label = [[ShowTradeSubView alloc] initWithFrame:CGRectMake(i * (laWidth + Padding), 0, laWidth , H)];
        
        label.textColor = [UIColor whiteColor];
        
        label.textFont = [UIFont systemFontOfSize:16 * PPWidth < 16 ? 16 * PPWidth : 16];
        
        label.textColor = [UIColor whiteColor];
        label.title = subTitles[i];
        
        label.tag = 100 + i;
        
        [self addSubview:label];
        
        [self.subViews addObject:label];
        
        UILabel *seperatLine = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_MAXX(label), 0, 1, HEIGHT_VIEW(self))];
        
        seperatLine.backgroundColor = RGBCOLOR(239, 239, 244);
        
        [self addSubview:seperatLine];
    }
}

- (void) setBgColor:(UIColor *)bgColor {
    _bgColor = bgColor;
    self.backgroundColor = bgColor;
}

- (void) setTrades:(NSArray *)trades {
    
    for (ShowTradeSubView *label in self.subViews) {
        
        switch (label.tag - 100) {
            case 0:
                label.tradeNumber = [NSString stringWithFormat:@"%@", trades[0]];
                break;
                
            case 1:
                label.tradeNumber = [NSString stringWithFormat:@"%@", trades[1]];
                break;
                
            case 2:
                label.tradeNumber = [NSString stringWithFormat:@"%@", trades[2]];
                break;
                
            default:
                break;
        }
    }
}

- (void) setTitleArr:(NSArray *)titleArr {
    
    for (ShowTradeSubView *label in self.subViews) {
        switch (label.tag - 100) {
            case 0:
                label.title = [NSString stringWithFormat:@"%@", titleArr[0]];
                break;
                
            case 1:
                label.title = [NSString stringWithFormat:@"%@", titleArr[1]];
                break;
                
            case 2:
                label.title = [NSString stringWithFormat:@"%@", titleArr[2]];
                break;
                
            default:
                break;
        }
    }
}

@end

