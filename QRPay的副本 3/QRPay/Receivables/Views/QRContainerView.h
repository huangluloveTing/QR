//
//  QRContainerView.h
//  QRPay
//
//  Created by 黄露 on 2016/11/18.
//  Copyright © 2016年 yy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomModel.h"

@interface QRContainerView : UIView

@property (nonatomic ,strong) NSArray<CustomModel *> *models;

- (instancetype)initWithFrame:(CGRect)frame andModels:(NSArray *)models;

@end
