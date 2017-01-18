//
//  URLOperationWithBlock.h
//  TestAPI
//
//  Created by Leione on 14/1/28.
//  Copyright (c) 2014年 Leione. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URLReturnModel.h"

typedef void (^returnBlock)(URLReturnModel *returnModel);
@interface URLOperationWithBlock : NSOperation


//data为post数据 postFunction为post地址 block为回调函数
- (instancetype)initWithURL:(NSData*)getInfo
            serveceFunction:(NSString *)getPostLoca
                 customerNo:(NSString *)customer
                   business:(NSDictionary *)business
                returnblock:(returnBlock)rblock isPost:(BOOL)postOrGet;
@end
