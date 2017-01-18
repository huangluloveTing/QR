//
//  medicalHistoryModel.m
//  doctorGrey
//
//  Created by osx on 15/5/13.
//  Copyright (c) 2015年 Leione. All rights reserved.
//

#import "LoginViewController.h"
#import "ReturnListModel.h"
#import "desuntil.h"
#import "MD5Utils.h"



@implementation ReturnListModel



- (ReturnListModel *)initWithError:(NSString *)getErrorCode errorMsg:(NSString *)GetErrorMsg{
    self = [super init];
    if (self) {
        errorCode = getErrorCode;
        errorMsg = GetErrorMsg;
    }
    return self;
}

-(ReturnListModel *)initWithData:(NSData *)mainData{
    
    self = [super init];
    
    if (self) {
        
        NSString *receiveStr = [[NSString alloc]initWithData:mainData encoding:NSUTF8StringEncoding];
        NSError *error;
        NSData* aData = [receiveStr dataUsingEncoding: NSUTF8StringEncoding];
        NSDictionary *a = Nil;
        
        a = [NSJSONSerialization JSONObjectWithData:aData options:NSJSONReadingMutableContainers error:&error];
        
        errorCode = [PayConfig nilStr:[a objectForKey:@"responseCode"]];
        errorMsg = [NSString stringWithFormat:@"%@,返回码：%@",[PayConfig nilStr:[a objectForKey:@"responseInfo"]],errorCode];//;
        
//        responseInfo
//        登录接口返回秘钥 与用户接口请求的秘钥不一样 就会返回ERR099 ERR104  就会发送通知 通知用户重新登录（用户每次登录后台返回的秘钥就更新一次）
        
        if ([errorCode isEqualToString:@"ERR104"] || [errorCode isEqualToString:@"ERR099"]) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"accountTimeout" object:nil userInfo:@{@"message":errorMsg}];
        }
        
        
//        ERR099
        
        if (!error && [errorCode isEqualToString:@"00"]) {
            
            NSString *responseData = [a objectForKey:@"responseData"];
            
            NSLog(@"info = %@",[a objectForKey:@"responseInfo"]);
            
            if (responseData) {
                
                NSString* decryptStr = [desuntil decryptStr:responseData keys:[UPConfig getDesKey]];
                
                if (decryptStr) {
                    
                    responseDictionary = [NSJSONSerialization JSONObjectWithData:[decryptStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
                }else{
                    
                    errorCode = @"";
                    errorMsg = @"数据解析失败,请重试";
                }
                
                NSLog(@"%@",[PayConfig dictionaryToJson:responseDictionary] );
            }
        }
    }
    return self;
}

- (NSString *)getErrorCode{
    
    return errorCode;
}
- (NSString *)getErrorMsg{
    return errorMsg;
}

- (id )getResponseDictionary
{
    return responseDictionary;
}

@end
