//
//  URLOperationWithBlock.h
//  TestAPI
//
//  Created by Leione on 14/1/28.
//  Copyright (c) 2014年 Leione. All rights reserved.
//

#import "netAPI.h"

//商户登录
#define OPERATOR_LOGIN @"OPERATOR_LOGIN"

//新版本检查
#define CHECK_VERSION @"CHECK_VERSION"

//修改密码
#define CHANGE_PASSWORD  @"CHANGE_PASSWORD"

//忘记密码
#define FORGET_PASSWORD @"FORGET_PASSWORD"

//短信发送
#define SMS_SEND @"SMS_SEND"





@implementation netAPI


/**
 *  用户登录
 *
 *  @param phone              用户手机号
 *  @param businessDictionary 业务，需要根据API文档将各参数放到字典内
 *  @param listing            返回Model
 */
+(void)usrLogin:(NSString *)phone business:(NSDictionary *)businessDictionary block:(returnListingBlock)listing
{
    [self testAPIGetTestWithBlock:nil getFunction:OPERATOR_LOGIN customerNo:phone business:businessDictionary block:^(URLReturnModel *returnModel) {
        
        if (returnModel != Nil && [returnModel getFlag]) {
            ReturnListModel *a = [[ReturnListModel alloc]initWithData:[returnModel getData]];
            listing(a);
        }else{
            ReturnListModel *a = [[ReturnListModel alloc]initWithError:@"404" errorMsg:HTTPErrorMsg];
            listing(a);
        }
        
    }];
}


/**
 *  注册、找回密码
 *
 *  @param phone              用户账号
 *  @param interface          interfaceCode，区分注册和找回密码
 *  @param businessDictionary 业务，需要根据API文档将各参数放到字典内
 *  @param listing            返回Model
 */
+(void)usrRegister:(NSString *)phone interfaceCode:(NSString *)interface business:(NSDictionary *)businessDictionary block:(returnListingBlock)listing
{
    [self testAPIGetTestWithBlock:nil getFunction:interface customerNo:phone business:businessDictionary block:^(URLReturnModel *returnModel) {
        
        if (returnModel != Nil && [returnModel getFlag]) {
            ReturnListModel *a = [[ReturnListModel alloc]initWithData:[returnModel getData]];
            listing(a);
        }else{
            ReturnListModel *a = [[ReturnListModel alloc]initWithError:@"404" errorMsg:HTTPErrorMsg];
            listing(a);
        }
        
    }];
}




/**
 *  仅限于认证时上传图片
 *
 *  @param imageData          业务参数
 *  @param listing            返回
 */
+ (void)uploadImageWithInterfaceCode:(NSString *)interface ImageData:(NSData *)imageData block:(returnListingBlock)listing
{
    [self testAPIPostTestWithBlock:imageData getFunction:interface customerNo:@"uploadImage" business:nil block:^(URLReturnModel *returnModel)
    {
        if (returnModel != Nil && [returnModel getFlag]) {
            ReturnListModel *a = [[ReturnListModel alloc]initWithData:[returnModel getData]];
            listing(a);
        }else{
            ReturnListModel *a = [[ReturnListModel alloc]initWithError:@"404" errorMsg:HTTPErrorMsg];
            listing(a);
        }
    }];
    
}

/**
 *  获取验证码
 *
 *  @param phone              用户手机号
 *  @param businessDictionary 业务参数
 *  @param listing            返回值
 */
+ (void)getVerificationCode:(NSString *)phone business:(NSDictionary *)businessDictionary block:(returnListingBlock)listing
{
    [self testAPIGetTestWithBlock:nil getFunction:SMS_SEND customerNo:phone business:businessDictionary block:^(URLReturnModel *returnModel) {
        
        if (returnModel != Nil && [returnModel getFlag]) {
            ReturnListModel *a = [[ReturnListModel alloc]initWithData:[returnModel getData]];
            listing(a);
        }else{
            ReturnListModel *a = [[ReturnListModel alloc]initWithError:@"error" errorMsg:HTTPErrorMsg];
            listing(a);
        }
        
    }];
}

/**
 *  get获取信息
 *
 *  @param businessDictionary 业务参数
 *  @param listing            返回
 */
+ (void)getGeneralInfoInterfaceCode:(NSString *)interface
                        Business:(NSDictionary *)businessDictionary
                           block:(returnListingBlock)listing
{
    [self testAPIGetTestWithBlock:nil getFunction:interface customerNo:nil business:businessDictionary block:^(URLReturnModel *returnModel) {
        
        if (returnModel != Nil && [returnModel getFlag]) {
            
            ReturnListModel *a = [[ReturnListModel alloc]initWithData:[returnModel getData]];
            
            listing(a);
            
        }else{
            ReturnListModel *a = [[ReturnListModel alloc]initWithError:@"404" errorMsg:HTTPErrorMsg];
            listing(a);
        }
        
    }];
}




/*
   ------------------------------------我是分割线！非必要，以下函数不要改动------------------------------------
*/


#pragma base API


+(void)testAPIGetTestWithBlock:(NSData *)getInfo
                   getFunction:(NSString *)function
                    customerNo:(NSString *)customer
                      business:(NSDictionary *)business
                         block:(returnBlock)block{

    URLOperationWithBlock *operation = [[URLOperationWithBlock alloc]initWithURL:getInfo serveceFunction:function customerNo:customer business:business returnblock:block isPost:FALSE];
    [operation setQueuePriority:NSOperationQueuePriorityHigh];
    [[baseAPP getBaseNSOperationQueue] addOperation:operation];
   
}


+(void)testAPIPostTestWithBlock:(NSData *)postInfo
                    getFunction:(NSString *)function
                     customerNo:(NSString *)customer
                       business:(NSDictionary *)business
                          block:(returnBlock)block{
    
    URLOperationWithBlock *operation = [[URLOperationWithBlock alloc]initWithURL:postInfo serveceFunction:function customerNo:customer business:business  returnblock:block isPost:TRUE];
    
    [operation setQueuePriority:NSOperationQueuePriorityHigh];
    [[baseAPP getBaseNSOperationQueue] addOperation:operation];
    
    
}


@end
     
     

