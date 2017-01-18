//
//  URLReturnModel.m
//  wowilling
//
//  Created by 田原 on 14-3-7.
//  Copyright (c) 2014年 田原. All rights reserved.
//

#import "URLReturnModel.h"

@implementation URLReturnModel
@synthesize object;
@synthesize error;
- (URLReturnModel *)initWithData:(NSData *)getObject error:(NSError *)getError{
    self = [super init];
    if (self) {
        if (getObject == Nil || getError) {
            flag = FALSE;
        }else{
            flag = TRUE;
        }
        
        
        object = getObject;
        
        error = getError;
        
        if (flag) {
            
            NSDictionary *a  = [NSJSONSerialization JSONObjectWithData:getObject options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"%@",[PayConfig  dictionaryToJson:a] );
            
            if (![[a objectForKey:@"responseCode"] isKindOfClass:[NSNumber class]]) {
                errorCode = @([[a objectForKey:@"responseCode"] longLongValue]);
            }else{
                
                errorCode = [a objectForKey:@"responseCode"];
            }
            
            errorMsg = [a objectForKey:@"responseInfo"];
        }
    }
    return self;
}


- (BOOL)getFlag{
    return flag;
}
- (NSData *)getData{
    return object;
}
- (NSError *)getError{
    return error;
}
- (NSNumber *)getErrorCode
{
    return errorCode;
}

- (NSString *)getErrorMsg
{
    return errorMsg;
}

@end
