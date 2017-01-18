//
//  MyShareFeeTableViewCell.h
//  QRPay
//
//  Created by 黄露 on 2016/11/28.
//  Copyright © 2016年 yy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyShareFeeTableViewCell : UITableViewCell

/**
 *       我的分润cell
 *
 *       属性依次为：图片 ， 标题 ， 时间  ， 分润
 */

@property (nonatomic ,strong) UIImage *headImage;

@property (nonatomic ,copy) NSString *nameStr;

@property (nonatomic ,copy) NSString *timeStr;

@property (nonatomic ,assign) CGFloat sharePercent;

@end
