//
//  oprationResultModel.m
//  jobSearch
//
//  Created by 田原 on 15/2/1.
//  Copyright (c) 2015年 麻辣工作室. All rights reserved.
//

#import "oprationResultModel.h"

@implementation oprationResultModel
-(oprationResultModel *)initWithData:(NSData *)mainData{
    self = [super init];
    if (self) {
        
        NSString *receiveStr = [[NSString alloc]initWithData:mainData encoding:NSUTF8StringEncoding];
        
        NSError *error;
        
        NSData* aData = [receiveStr dataUsingEncoding: NSUTF8StringEncoding];
        NSDictionary *a = Nil;
        BOOL flag = TRUE;
        @try {
            a = [NSJSONSerialization JSONObjectWithData:aData options:NSJSONReadingMutableContainers error:&error];
        }
        @catch (NSException *exception) {
            a = Nil;
            flag = false;
        }
        if (flag) {
            @try {
                errorCode = [a objectForKey:@"errorCode"];
                errorMsg = [a objectForKey:@"errorMsg"];
                datas = [a objectForKey:@"datas"];
            }@catch (NSException *exception) {
                flag = false;
            }
        }
        if (!flag) {
            errorCode = @1;
            errorMsg =@"错误";
        }
    }
    return self;
}

-(oprationResultModel *)initWithError:(NSNumber *)getStatus info:(NSString *)error{
    self = [super init];
    if (self) {
        errorCode = getStatus;
        errorMsg = error;
    }
    return self;
}
-(NSString *)getOprationID{
    return datas;
}
@end
