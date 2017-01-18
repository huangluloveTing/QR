//
//  URLOperationWithBlock.m
//  TestAPI
//
//  Created by Leione on 14/1/28.
//  Copyright (c) 2014年 Leione. All rights reserved.
//

#import "URLOperationWithBlock.h"
#import "HttpProxyHolter.h"
#import "desuntil.h"
#import "MD5Utils.h"

@interface URLOperationWithBlock ()
{
    NSData *postInfo;
    NSString *postLoca;
    NSDictionary *businessDic;
    NSString *customerNo;
    BOOL isPost;
    returnBlock block;
}
@end


@implementation URLOperationWithBlock

//data为post数据 postFunction为post地址 block为回调函数
- (instancetype)initWithURL:(NSData*)getInfo
            serveceFunction:(NSString *)getPostLoca
                 customerNo:(NSString *)customer
                   business:(NSDictionary *)business
                returnblock:(returnBlock)rblock isPost:(BOOL)postOrGet
{
    self = [super init];
    if (self) {
        postInfo = getInfo;
        postLoca = getPostLoca;
        isPost = postOrGet;
        businessDic = business;
        customerNo = customer;
        block =rblock;
    }
    
    return self;
}


- (void)main{
    
    
    if ([HttpProxyHolter isSettingHroxy]) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            block(Nil);
        });
        
        return;
    }
    
    
    NSString *urlString = nil;
    
    if (!isPost) {
        
        urlString= [[NSString stringWithFormat:@"%@%@",[UPConfig getServerURL],[self configParameter]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        urlString= [NSString stringWithFormat:@"%@",[UPConfig getServerURL]];
    }else{
        
        urlString =[[NSString stringWithFormat:@"%@%@.action",[UPConfig getServerURL],postLoca] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ;
//        urlString= [NSString stringWithFormat:@"%@",[UPConfig getServerURL]];
        
    }
    
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    
    NSLog(@"%@",urlString);
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:1000];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    if (isPost) {
        
        [request setHTTPMethod:@"POST"];
        
        if (postInfo != Nil) {
            
            [request setHTTPBody:postInfo];
        }
        
        if ([customerNo isEqualToString:@"uploadImage"]) {
            
            //设置HTTPHeader
            [request setValue:@"multipart/form-data; boundary=AaB03x" forHTTPHeaderField:@"Content-Type"];
            //设置Content-Length
            [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[postInfo length]] forHTTPHeaderField:@"Content-Length"];
        }
        
        
    }else{
        
        [request setHTTPMethod:@"GET"];
        
    }
    
    request.timeoutInterval = 20.f;
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
            NSLog(@"error : %@",error);
        }
        
        if (data) {
            NSDictionary *DIC = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            
            NSLog(@"dic = %@",DIC[@"responseData"]);
        }
        
        URLReturnModel *objRe = [[URLReturnModel alloc]initWithData:data error:error];
        
        if (block != Nil) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                block(objRe);
            });
            
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                block(Nil);
            });
        }
    }];
    
    [task resume];
}


-(NSDictionary *)jsonTodictionary:(NSString *)JSONString
{
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableContainers error:nil];
    
    return responseJSON;
}

- (NSString *)configParameter
{
   
    NSString* desStr = [desuntil encryptStr:[PayConfig  dictionaryToStrings:businessDic] keys:[UPConfig getDesKey]];
    
    NSString* md5Str = [MD5Utils md5:[PayConfig  dictionaryToStrings:businessDic] AndKey:[UPConfig getMacKey]];
    
    customerNo = customerNo ? customerNo : [[PayConfig  getUserInfo] objectForKey:@"customerNo"];
    
    return [NSString stringWithFormat:[UPConfig getServerParameter],postLoca,[UPConfig getCompanyNO],[UPConfig getCompanyCid],customerNo,VERSION,desStr,md5Str];
}


@end
