//
//  MyShareFeeModel.h
//  QRPay
//
//  Created by 黄露 on 2016/11/28.
//  Copyright © 2016年 yy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyShareFeeModel : NSObject

@property (nonatomic ,copy) NSString *nameStr;

@property (nonatomic ,strong) UIImage *headImage;

@property (nonatomic ,copy) NSString *timeStr;

@property (nonatomic ,assign) CGFloat percent;

@end
