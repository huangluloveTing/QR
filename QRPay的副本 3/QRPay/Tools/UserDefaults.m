//
//  UserDefaults.m
//  QRPay
//
//  Created by 黄露 on 2016/11/30.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "UserDefaults.h"

@implementation UserDefaults

+ (void) saveValue:(NSString *)value withKey:(NSString *)key {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults removeObjectForKey:key];
    [defaults setObject:value forKey:key];
    [defaults synchronize];
}

+ (void) svaInteger:(NSInteger)integer withKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    [defaults removeObjectForKey:key];
    [defaults setInteger:integer forKey:key];
    [defaults synchronize];
}

+ (void)saveBool:(BOOL)isture withKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    [defaults setBool:isture forKey:key];
    [defaults synchronize];
}

+ (NSString *) getValueForKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] valueForKey:key];
}

+ (void) removeValueForKey:(NSString *)key {
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}

@end
