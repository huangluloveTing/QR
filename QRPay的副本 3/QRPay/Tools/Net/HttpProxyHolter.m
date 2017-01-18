//
//  HttpHroxyHolter.m
//  Demo1
//
//  Created by Leione on 15/12/30.
//  Copyright © 2015年 Leione. All rights reserved.
//

#import "HttpProxyHolter.h"

@implementation HttpProxyHolter

+ (BOOL)isSettingHroxy
{
    NSDictionary *proxySettings = NSMakeCollectable([(NSDictionary *)CFNetworkCopySystemProxySettings() autorelease]);
    
    NSArray *proxies = NSMakeCollectable([(NSArray *)CFNetworkCopyProxiesForURL((CFURLRef)[NSURL URLWithString:@"http://www.baidu.com"], (CFDictionaryRef)proxySettings) autorelease]);
    
    if (proxies.count == 0 ) {
        
        return NO;
    }
    
    NSDictionary *settings = [proxies objectAtIndex:0];
    
    if ([settings objectForKey:(NSString *)kCFProxyHostNameKey]) {
        
        return YES;
        
    }
    
    return NO;
}
@end
