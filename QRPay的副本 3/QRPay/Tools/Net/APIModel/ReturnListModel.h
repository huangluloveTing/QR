//
//  medicalHistoryModel.h
//  doctorGrey
//
//  Created by osx on 15/5/13.
//  Copyright (c) 2015年 Leione. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReturnListModel : NSObject{
    NSString *errorCode;
    NSString *errorMsg;
    id responseDictionary;
    
}
-(ReturnListModel *)initWithData:(NSData *)mainData;
-(ReturnListModel *)initWithError:(NSString *)getErrorCode errorMsg:(NSString *)GetErrorMsg;
-(NSString *)getErrorCode;
-(NSString *)getErrorMsg;
-(id)getResponseDictionary;

@end
