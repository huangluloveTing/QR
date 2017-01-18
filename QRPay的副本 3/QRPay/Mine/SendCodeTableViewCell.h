//
//  SendCodeTableViewCell.h
//  QRPay
//
//  Created by 黄露 on 2016/11/24.
//  Copyright © 2016年 yy. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *     发送验证短信的cell
 *
 *      subTitleLabel      标题的label
 *      placeholder        textfield 的站位字符串
 *      btnstr             btn 的名字
 */


@interface SendCodeTableViewCell : UITableViewCell

@property (nonatomic ,copy) NSString *subTitles;
@property (nonatomic ,copy) NSString *placeholderStr;
@property (nonatomic ,copy) NSString *btnStr;
@property (nonatomic ,copy) NSString *contentString;

@property (nonatomic ,strong) void (^tapSendBtnBlock)(NSString *phoneNum , UIButton *btn);

@end
