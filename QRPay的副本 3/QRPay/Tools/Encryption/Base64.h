//
//  Base64.h
//  EasyPay
//
//  Created by 刘欣 on 15/5/7.
//  Copyright (c) 2015年 刘欣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Base64 : NSObject

+(int)char2Int:(char)c;
+(NSData *)decode:(NSString *)data;
+(NSString *)encode:(NSData *)data;

@end
