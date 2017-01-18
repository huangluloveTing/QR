//
//  SetGestureLockViewController.h
//  QRPay
//
//  Created by 黄露 on 2016/11/24.
//  Copyright © 2016年 yy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBGuestureLock.h"

typedef NS_ENUM(NSInteger , SetGuestureType) {
    ToSetGuesture = 0,
    ToClearGuesture
};

@interface SetGestureLockViewController : BasesViewController

@property (nonatomic ,assign) SetGuestureType setType;

@end
