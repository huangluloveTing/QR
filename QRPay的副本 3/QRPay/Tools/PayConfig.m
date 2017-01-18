//
//  PayConfig.m
//  EasyPay
//
//  Created by Leione on 15/9/28.
//  Copyright © 2015年 Leione. All rights reserved.
//

#import "PayConfig.h"
//#import "MAdderss.h"
#import <CoreLocation/CoreLocation.h>
#import "sys/utsname.h"

@implementation PayConfig

+ (instancetype)shareConfig
{
    
    static PayConfig *shareEventUtils = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        shareEventUtils = [[PayConfig alloc] init];
    });
    
    return shareEventUtils;
}



+(NSString *)dictionaryToStrings:(NSDictionary *)dic{
    
    NSArray *keyArr = [dic allKeys];
    if (keyArr.count == 0) {
        return @"";
    }

    
    NSString *tempStr = @"";
    for (NSString *string in keyArr) {
        tempStr = [tempStr stringByAppendingString:[NSString stringWithFormat:@"&%@=%@",string,[dic valueForKey:string]]];
    }
    
    tempStr = [tempStr substringFromIndex:1];
    
    NSLog(@"%@",tempStr);
    
    
    return tempStr;
}




+ (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    
    if (!dic) {
        return nil;
    }
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    NSString *string = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSLog(@"\\u = %@",string);
    
    return [string stringByReplacingOccurrencesOfString:@"\\u0000" withString:@""];
}

+(NSDictionary *)jsonTodictionary:(NSString *)JSONString
{
    if (!JSONString) {
        return nil;
    }
    
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableContainers error:nil];
    
    return responseJSON;
}

+ (NSDictionary *)getUserInfo
{
    return [self jsonTodictionary:[[NSUserDefaults standardUserDefaults] valueForKey:APP_USERINFO_KEY]];
}


+ (NSString *)getUserPhone
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"phone"];
//    return @"18080584113";
}

+ (NSString *) getPassword {
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"password"];
}

+ (BOOL) isSavePassword {
    
    return [[[NSUserDefaults standardUserDefaults] valueForKey:@"savapassword"] boolValue];
}

+ (NSString *)getXcodeAppBuild
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] ;
}


//正则表达式，判断是否是整数
+ (BOOL)isIntegerNumber:(NSString *)mobileNum
{
    mobileNum = [mobileNum stringByReplacingOccurrencesOfString:@"." withString:@""];
    
    NSString *INTEGER = @"^\\d+$";
    //“^[u4e00-u9fa5],{0,}$”
    
    NSPredicate *regextestINTEGER = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", INTEGER];
    
    if ([regextestINTEGER evaluateWithObject:mobileNum] == YES)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

/**
 *  身份证校验
 *
 *  @param cardNo 待校验身份证号码
 *
 *  @return BOOL YES/NO
 */
+(BOOL)checkIdentityCardNo:(NSString*)cardNo
{
    if (cardNo.length != 18) {
        return  NO;
    }
    
    NSArray* codeArray = [NSArray arrayWithObjects:@"7",@"9",@"10",@"5",@"8",@"4",@"2",@"1",@"6",@"3",@"7",@"9",@"10",@"5",@"8",@"4",@"2", nil];
    
    NSDictionary* checkCodeDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1",@"0",@"X",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2", nil]  forKeys:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil]];
    
    NSScanner* scan = [NSScanner scannerWithString:[cardNo substringToIndex:17]];
    
    int val;
    
    BOOL isNum = [scan scanInt:&val] && [scan isAtEnd];
    
    if (!isNum) {
        return NO;
    }
    
    int sumValue = 0;
    
    for (int i =0; i<17; i++) {
    
        sumValue+=[[cardNo substringWithRange:NSMakeRange(i , 1) ] intValue]* [[codeArray objectAtIndex:i] intValue];
    
    }
    
    NSString* strlast = [checkCodeDic objectForKey:[NSString stringWithFormat:@"%d",sumValue%11]];
    
    if ([strlast isEqualToString: [[cardNo substringWithRange:NSMakeRange(17, 1)]uppercaseString]]) {
    
        return YES;
    }
    
    return  NO;
    
}



//对图片尺寸进行压缩--
+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    
//    首先，我们必须明确图片的压缩其实是两个概念：
//    
//    “压” 是指文件体积变小，但是像素数不变，长宽尺寸不变，那么质量可能下降。
//    “缩” 是指文件的尺寸变小，也就是像素数减少，而长宽尺寸变小，文件体积同样会减小。
//    1.
    
//    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
//    第一个参数是图片对象，第二个参数是压的系数，其值范围为0~1。压缩系数不宜太低，通常是0.3~0.7，过小则可能会出现黑边等

    /**
     2.图片“缩”处理
            压缩图片至目标尺寸
     *   返回按照源图片的宽、高比例压缩至目标宽、高的图片
     */

    
    UIGraphicsBeginImageContext(newSize);
    
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}


//cell高度自适应
+ (CGFloat)getHighWithString:(NSString *)string withFont:(CGFloat )font width:(CGFloat)with
{
    
    if (string == nil || [string isKindOfClass:[NSNull class]]) {
        string = @"";
    }
    
    //设置 属性字典
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};
    
    CGRect rect = [string boundingRectWithSize:CGSizeMake(with, 100000000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
    
    return rect.size.height;
}
+ (CGFloat)gettipHighWithString:(NSString *)string withFont:(CGFloat )font width:(CGFloat)with
{
    
    string = [string stringByReplacingOccurrencesOfString:@"\\r" withString:@""];
    NSArray *tips = [string componentsSeparatedByString:@"\n"];
    
    CGFloat height = 0;
    
    for (NSString *tip in tips) {
        
        NSLog(@"%@ ---------- %.f",tip,height);
        
        height = height + [self getHighWithString:tip withFont:font width:with] + 5;
        
    }
    
    return height;
}


//判断银行卡号
+ (BOOL) checkCardNo:(NSString*) cardNo
{
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[cardNo length];
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    
    cardNo = [cardNo substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}

+ (BOOL)checkLocationServices
{
    if ([CLLocationManager locationServicesEnabled] &&
        ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways
         || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse
         || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)) {
            
            return YES;
        }
    else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied){
        
        return NO;
    }
    
    return NO;
}


/**
 *  UUID
 */
#pragma mark 使用KeyChain保存和获取UDID
-(NSString*)getUUID
{
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    //    NSString * result = (NSString *)CFStringCreateCopy( NULL, uuidString);
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}


+ (NSString *)getUUIDFromKeychainItemWrapper
{
    
//    if (self.myUUID) {
//        
//        return self.myUUID;
//    }
//    
//    //    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithAccount:UUIDIdentifier service:UUIDIdentifier accessGroup:nil];
//    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:UUIDIdentifier accessGroup:nil];
//    
//    //从keychain里取出帐号密码
//    NSString * uuidString = [wrapper objectForKey:(__bridge id)kSecValueData];
//    
//    if (!uuidString || ![uuidString length]) {
//        
//        uuidString = [self getUUID];
//        
//        [wrapper setObject:uuidString forKey:(__bridge id)kSecValueData];
//    }
//    
//    wrapper = nil;
//    
//    self.myUUID = uuidString;
//    
//    return uuidString;
    
    return @"1000000000";
}


+ (NSString *)exportNumberStringtoLetterString
{
    
    NSString *number = [self getUserPhone];
    
    NSArray *letters =  @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"G"];
    
    NSString *currentString= @"";
    
    for (int i = 0; i < number.length; i++) {
        
        NSInteger cell = [[number substringWithRange:NSMakeRange(i, 1)] integerValue];
        
        currentString =  [currentString stringByAppendingString:letters[cell]];
    }
    
    return currentString;
}


+ (BOOL)isMobile:(NSString *)mobile
{
    NSString *MOBILE = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[03678]|18[0-9]|14[57])[0-9]{8}$";
    
    NSPredicate *regMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    return [regMobile evaluateWithObject:mobile];
}


+ (NSString *)nilStr:(NSString *)str
{
    if (![str isKindOfClass:[NSString class]]) {
        
        str = [NSString stringWithFormat:@"%@",str];
    }
    
    if (!str || [str isKindOfClass:[NSNull class] ] || [str isEqualToString:@"(null)"] || [str isEqualToString:@"<null>"] || [str isEqualToString:@"null"]) {
        
        str = @"";
    }
    
    return str;
}


+ (NSString*)deviceString
{
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
        
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G (A1203)";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G (A1241/A1324)";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS (A1303/A1325)";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (A1349)";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S (A1387/A1431)";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5 (A1428)";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (A1429/A1442)";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (A1456/A1532)";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (A1453/A1533)";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus (A1522/A1524)";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 (A1549/A1586)";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6 s (A1522/A1524)";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6 s Plus";
    
    //        if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G (A1213)";
    //        if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G (A1288)";
    //        if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G (A1318)";
    //        if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G (A1367)";
    //        if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G (A1421/A1509)";
    //
    //        if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G (A1219/A1337)";
    //
    //        if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (A1395)";
    //        if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2 (A1396)";
    //        if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (A1397)";
    //        if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2 (A1395+New Chip)";
    //        if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G (A1432)";
    //        if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G (A1454)";
    //        if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G (A1455)";
    //
    //        if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (A1416)";
    //        if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (A1403)";
    //        if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (A1430)";
    //        if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (A1458)";
    //        if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4 (A1459)";
    //        if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (A1460)";
    //
    //        if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air (A1474)";
    //        if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air (A1475)";
    //        if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air (A1476)";
    //        if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G (A1489)";
    //        if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G (A1490)";
    //        if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G (A1491)";
    //
    //        if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    //        if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    
    return platform;
}
+ (CGFloat)getCachesSize
{
    return  [self folderSizeAtPath:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0 ]] + [self folderSizeAtPath:NSTemporaryDirectory()];
}

+ (float ) folderSizeAtPath:(NSString*) folderPath
{
    
    NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSTemporaryDirectory();
    
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]){
        return 0;
    }
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName = nil;
    
    long long folderSize = 0;
    
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
        
    }
    
    return folderSize/(1024.0*1024.0);
}


+ (long long) fileSizeAtPath:(NSString*) filePath
{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

+ (void)clearCaches
{
    [self clearCachesAtPath:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0 ]];
    
    [self clearCachesAtPath:NSTemporaryDirectory()];
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}


+ (void)clearCachesAtPath:(NSString*) folderPath
{
    dispatch_async(
                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                   , ^{
                       
                       NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:folderPath];
                       NSLog(@"files :%ld",[files count]);
                       for (NSString *p in files) {
                           NSError *error;
                           NSString *path = [folderPath stringByAppendingPathComponent:p];
                           if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                               [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                           }
                       }
                       
                   });
}


+ (NSString *)chineseCharacters2Pinyin:(NSString *)string
{
    if ([string length]) {
        
        NSMutableString *ms = [[NSMutableString alloc] initWithString:string];
        
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO)) {
            NSLog(@"pinyin: %@", ms);
        }
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO)) {
            
            
            return [[ms stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"yinxing" withString:@"yinhang"];
            
        }
        
        return @"";
    }
    return @"";
}

+ (void) saveConfigWithKey:(NSString *)key andData:(id)data {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults] ;
    
    [userDefault setObject:data forKey:key];
    
    [userDefault synchronize];
}

+(id)getDataWithKey:(NSString *)key {
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults] ;
    
    id data = [userDefault objectForKey:key];
    
    return data;
}

+ (NSString *) getCurrentDate {
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    return dateString;
}

+ (void) openURLWithURL:(NSString *)url {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

+ (void) addKeyBorderObserveWithTarget:(id)target andKeyborderAppearSEL:(SEL)asel eyborderDisappearSEL:(SEL)dsel {
    [[NSNotificationCenter defaultCenter] addObserver:target selector:asel name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:target selector:dsel name:UIKeyboardWillHideNotification object:nil];
}

+ (void) removeKeyBorderObserveWithTarget:(id)target {
    [[NSNotificationCenter defaultCenter] removeObserver:target];
}


+ (NSInteger) getUserAuthority {
    
    return [[[self class] nilStr:[[[self class] getUserInfo] valueForKey:@"authority"]] integerValue];
}

@end
