//
//  QRContainerView.m
//  QRPay
//
//  Created by 黄露 on 2016/11/18.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "QRContainerView.h"
#import "AboutQRView.h"

#define ABOUTVIEWH (60)

@implementation QRContainerView

-(instancetype) initWithFrame:(CGRect)frame andModels:(NSArray *)models {
    if (self = [super initWithFrame:frame]) {
        self.models = models;
        [self configViews];
    }
    return self;
}

- (void) configViews {
    
    if (self.models.count > 0) {
        for (int i = 0; i < self.models.count; i ++) {
            
            CustomModel *model = self.models[i];
            CGFloat viewHeight =  (CGRectGetHeight(self.bounds) - self.models.count + 1) / self.models.count;
            AboutQRView *view = [[AboutQRView alloc] initWithFrame:CGRectMake(0, i * viewHeight + i , CGRectGetWidth(self.bounds), viewHeight) andImage:model.image andTitle:model.title];

            [self addSubview:view];
            
            if (i != self.models.count - 1) {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(2, CGRectGetMaxY(view.frame), CGRectGetWidth(self.bounds) - 4, 1)];
                label.backgroundColor = [UIColor lightGrayColor];
                [self addSubview:label];
            }
        }
    }
}

@end

