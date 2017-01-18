//
//  MyTouchId.m
//  QRPay
//
//  Created by 黄露 on 2016/11/26.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "MyTouchId.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface MyTouchId ()

@property (nonatomic ,strong) LAContext *laContext;

@end

@implementation MyTouchId


- (void) comfirmTouchId {
    self.laContext = [[LAContext alloc] init];
    
    NSError *error = nil;
    
    //授权原因
    NSString *mylocalReason = @"授权指纹";
    self.laContext.localizedFallbackTitle =@"验证手势密码";
    
    //if条件判断设备是否支持Touch ID 是否开启Touch id等这个一定要写上（曾经3DTouch使用的时候没判断导致iOS9以后的系统启动app就崩溃）
    
    if([self.laContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                                error:&error]) {
        //弹出指纹识别界面
        
            
        [self.laContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
             localizedReason:mylocalReason
             reply:^(BOOL
                     success, NSError *authenticationError)
            {
                 
                 if(success) {   
                     /*如果验证成功了，如果你只需要使用指纹验证功能的话（注意这个验证的密码是你设置里面设置的那个密码，也就是一般人都会用来解锁iphone的那个密码） 在这里面可实现你设计的功能了，如果你的应用需要独立密码的话，需要让Touch ID 和 那个独立密码绑定 ，支付宝是在验证成功之后 跳转到设置支付密码的页面 让这个Touch和支付密码绑定，实现指纹支付，每次指纹识别通过间接性的使用了支付密码（本质还是支付密码）*/

                     NSLog(@"验证成功成功");
                     
                } else {
                     switch (authenticationError.code)
                     {
                         case LAErrorAuthenticationFailed:
                            {
                                NSLog(@"用户提供的指纹不对");
                             break;
                             }
                             
                         case LAErrorUserCancel:
                         {
                            NSLog(@"用户点击了取消按钮");
                            break;
                             
                         }
                             
                         case LAErrorUserFallback:
                         {
                             NSLog(@"用户选择输入密码");
                             
                             
                             break;
                             
                         }
                             
                         case LAErrorSystemCancel :
                         {
                             NSLog(@"切换到其他的app(按了Home按键)，被系统取消");
   
                             break;
                             
                         }//
                             
                         case LAErrorTouchIDLockout :
                         {
                             NSLog(@"用户指纹错误多次，TouchID 被锁定");
       
                                   break;
                         }//9.0
//                                   我试了验证过程中电话进来
//                                   返回的LAErrorSystemCancel
//                                   错误码
//                                   不是这个
                         case LAErrorAppCancel:
                         {
                           
                           NSLog(@"被(突如其来的)应用（电话）取消");
                           break;
                         }//LAErrorInvalidContex
                       
                         default:
                         {

                           break;
                         }
                     }
                }
            }];
    }
    else {
        switch (error.code)
        
        {
                //9.0 试过了不设置密码返回的是 LAErrorTouchIDNotEnrolled错误码
            case LAErrorPasscodeNotSet:
            {
                NSLog(@"在设置里面没有设置密码");
                break;
            }
            
            case LAErrorTouchIDNotAvailable:
            {
                NSLog(@"设备不支持Touch ID");
                break;
            }
            
            case LAErrorTouchIDNotEnrolled:
            {
                NSLog(@"在设置里面没有设置Touch Id 指纹");
                break;
            }
            
            case LAErrorInvalidContext:
            {
                NSLog(@"创建的指纹对象失效");
                break;
            }
            
            default:
            
            {
                break;
            }
        }
    }
}

@end
