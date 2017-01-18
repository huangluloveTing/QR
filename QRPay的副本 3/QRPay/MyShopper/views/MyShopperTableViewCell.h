//
//  MyShopperTableViewCell.h
//  QRPay
//
//  Created by 黄露 on 2016/11/27.
//  Copyright © 2016年 yy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyShopperTableViewCell : UITableViewCell

//商户图片
@property (nonatomic ,copy) NSString *headerImage;

//商户名称
@property (nonatomic ,copy) NSString *shopName;

//商户注册时间
@property (nonatomic ,copy) NSString *registerTime;

//商户图片暂未图片
@property (nonatomic ,strong) UIImage *headerPlaceImage;

//本月累计交易额
@property (nonatomic ,copy) NSString *totalAccount;

@end
