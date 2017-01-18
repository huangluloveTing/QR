//
//  UserDefaults.h
//  QRPay
//
//  Created by 黄露 on 2016/11/30.
//  Copyright © 2016年 yy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaults : NSObject

+ (void) saveValue:(NSString *)value withKey:(NSString *)key;
+ (NSString *) getValueForKey:(NSString *)key;

+ (void) removeValueForKey:(NSString *) key;

@end
