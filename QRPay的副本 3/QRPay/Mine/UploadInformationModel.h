//
//  UploadInformationModel.h
//  QRPay
//
//  Created by 黄露 on 2016/11/22.
//  Copyright © 2016年 yy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UploadInformationModel : NSObject

@property (nonatomic ,copy) NSString *name;         //姓名
@property (nonatomic ,copy) NSString *idNum;        //身份证号码
@property (nonatomic ,copy) NSString *bankName;     //开户行
@property (nonatomic ,copy) NSString *bankId;       //银行卡号
@property (nonatomic ,copy) NSString *bankRegion;   //开户地区
@property (nonatomic ,copy) NSString *detailBank;   //开户支行

@end
