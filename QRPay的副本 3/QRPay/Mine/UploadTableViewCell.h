//
//  UploadTableViewCell.h
//  QRPay
//
//  Created by 黄露 on 2016/11/22.
//  Copyright © 2016年 yy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UploadTableViewCell : UITableViewCell

@property (nonatomic ,copy) NSString *markTitle;         //标题
@property (nonatomic ,copy) NSString *contentString;     //textField 的text
@property (nonatomic ,assign) BOOL isShowKeyboard;       //是否可显示键盘
@property (nonatomic ,copy) NSString *placeholderStr;    //textField 的站位字符
@property (nonatomic ,assign) UIKeyboardType keyBoardType; //textField弹出键盘的类型

@property (nonatomic ,strong) void (^PressTextFieldBlock)(UploadTableViewCell *cell);

@end
