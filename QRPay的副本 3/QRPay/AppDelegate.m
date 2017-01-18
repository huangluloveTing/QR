//
//  AppDelegate.m
//  QRPay
//
//  Created by yy on 16/9/18.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "JPUSHService.h"
#import <JSPatch/JSPatch.h>

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

#import <ShareSDK/ShareSDK.h>
#import "WeiboSDK.h"
#import "WXApi.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>

@interface AppDelegate ()<JPUSHRegisterDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    LoginViewController *loginVC = [[LoginViewController alloc]init];
    UINavigationController*loginNC = [[UINavigationController alloc]initWithRootViewController:loginVC];
    
    self.window.rootViewController = loginNC;
    
    // Override point for customization after application launch.
    NSString *md5key = [PayConfig  nilStr:[[NSUserDefaults standardUserDefaults] valueForKey:@"kDefalutUpdataKey"]];
    [self configUpdateFunctionWithkey:md5key];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [[UINavigationBar appearance] setBarTintColor:RGBCOLOR(40, 126, 251)];

    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    
    /**
     *
     *  版本更新
     *
     **/
    [self checkVersionUpdate];
    
    
    //推送
     [self configPushServerWithLaunchOptions:launchOptions];
  
    [self sharedConfig];
    
    return YES;
}


- (void) sharedConfig {
    
    [ShareSDK registerApp:@"192b316800fac"
          activePlatforms:
                @[
                  @(SSDKPlatformTypeSinaWeibo),
//                  @(SSDKPlatformTypeTencentWeibo),
                  @(SSDKPlatformSubTypeWechatTimeline),
                  @(SSDKPlatformSubTypeWechatSession)
//                  @(SSDKPlatformTypeSMS),
//                  @(SSDKPlatformSubTypeQQFriend)
                  ]
          onImport:^(SSDKPlatformType platformType) {
              
              switch (platformType) {
                  case SSDKPlatformTypeWechat:
                      [ShareSDKConnector connectWeChat:[WXApi class]];
                      break;
                      
                  case SSDKPlatformTypeSinaWeibo:
                      [ShareSDKConnector connectWeChat:[WeiboSDK class]];
                      break;
                      
                  case SSDKPlatformSubTypeWechatSession:
                      [ShareSDKConnector connectWeChat:[WeiboSDK class]];
                      break;
                      
                  case SSDKPlatformSubTypeWechatTimeline:
                      [ShareSDKConnector connectWeChat:[WeiboSDK class]];
                      break;
                      
                  case SSDKPlatformTypeQQ:
                      [ShareSDKConnector connectWeChat:[QQApiInterface class]];
                      break;
                      
                  default:
                      break;
              }
    }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
              switch (platformType)
              {
                  case SSDKPlatformTypeSinaWeibo:
                      //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                      [appInfo SSDKSetupSinaWeiboByAppKey:@"2677537957"
                                                appSecret:@"156ce6dbe925843d4e7469ba26417c4a"
                                              redirectUri:@"http://www.baidu.com"
                                                 authType:SSDKAuthTypeBoth];
                      break;
                      
                  case SSDKPlatformTypeWechat:
                      [appInfo SSDKSetupWeChatByAppId:@"wx974c477695c4ef9a"
                                            appSecret:@"5ef6b8d018dc40a689b8edb9e6fecb98"];
                      break;
                      
                  case SSDKPlatformSubTypeWechatSession:
                      [appInfo SSDKSetupWeChatByAppId:@"wx974c477695c4ef9a"
                                            appSecret:@"5ef6b8d018dc40a689b8edb9e6fecb98"];
                      break;
                      
                  case SSDKPlatformSubTypeWechatTimeline:
                      [appInfo SSDKSetupWeChatByAppId:@"wx974c477695c4ef9a"
                                            appSecret:@"5ef6b8d018dc40a689b8edb9e6fecb98"];
                      break;
                      
                  case SSDKPlatformTypeQQ:
                      [appInfo SSDKSetupQQByAppId:@"100371282"
                                           appKey:@"aed9b0303e3ed1e27bae87c33761161d"
                                         authType:SSDKAuthTypeBoth];
                      break;
                      
                  case SSDKPlatformTypeRenren:
                      [appInfo        SSDKSetupRenRenByAppId:@"226427"
                                                      appKey:@"fc5b8aed373c4c27a05b712acba0f8c3"
                                                   secretKey:@"f29df781abdd4f49beca5a2194676ca4"
                                                    authType:SSDKAuthTypeBoth];
                      break;
                      
                  case SSDKPlatformTypeGooglePlus:
                      [appInfo SSDKSetupGooglePlusByClientID:@"232554794995.apps.googleusercontent.com"
                                                clientSecret:@"PEdFgtrMw97aCvf0joQj7EMk"
                                                 redirectUri:@"http://localhost"];
                      break;
                      
                  default:
                      break;
              }
    
    }];
    
}

#pragma mark - WX回调
//- (BOOL) application:(UIApplication *)application handleOpenURL:(NSURL *)url {
//    return [ShareSDK hand]
//}

#pragma mark -- WXAPIDelegate

- (void)configPushServerWithLaunchOptions:(NSDictionary *)launchOptions
{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
#endif
    } else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    
    //如不需要使用IDFA，advertisingIdentifier 可为nil
    [JPUSHService setupWithOption:launchOptions appKey:@"fb2e0bb589cf7b3380243bf7"
                          channel:@"Publish channel"
                 apsForProduction:FALSE
            advertisingIdentifier:NULL];
    
    //2.1.9版本新增获取registration id block接口。
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
            NSLog(@"registrationID获取成功：%@",registrationID);
        }
        else{
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];
}
- (void)configUpdateFunctionWithkey:(NSString *)md5key
{
    
//    [JSPatch testScriptInBundle];
    
        if (md5key.length < 5) {
            md5key = [UPConfig getJSKey];
        }
    
        if (md5key.length > 5) {
    //
            [JSPatch setupUserData:@{@"companyNO": [UPConfig getCompanyNO], @"companyCid": [UPConfig getCompanyCid]}];
            [JSPatch startWithAppKey:md5key];
            [JSPatch sync];
        }
}
- (void)checkVersionUpdate
{
    __block AppDelegate *blockSelf = self;
    [netAPI getGeneralInfoInterfaceCode:@"CHECK_VERSION" Business:[NSDictionary dictionaryWithObjectsAndKeys:[UPConfig getCompanyCid],@"cid",[UPConfig getCompanyNO],@"companyNo",VERSION,@"version", nil] block:^(ReturnListModel *listing) {
        
        if ([listing.getErrorCode isEqualToString:@"00"]) {
            
            NSString *md5Key_new = [PayConfig  nilStr:[listing.getResponseDictionary valueForKey:@"md5Key"]];
            NSString *md5key_old = [PayConfig  nilStr:[[NSUserDefaults standardUserDefaults] valueForKey:@"kDefalutUpdataKey"]];
            
            if (![md5Key_new isEqualToString:md5key_old]) {
                
                if (md5Key_new.length > 5) {
                    
                    [blockSelf configUpdateFunctionWithkey:md5Key_new];
                    [[NSUserDefaults standardUserDefaults] setObject:md5Key_new forKey:@"kDefalutUpdataKey"];
                    
                }else{
                    
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kDefalutUpdataKey"];
                }
                
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            
            NSString *currentS = [VERSION stringByReplacingOccurrencesOfString:@"." withString:@"0"];//字符串替换
            NSString *targetS = [[PayConfig  nilStr:[listing.getResponseDictionary valueForKey:@"newVersion"]] stringByReplacingOccurrencesOfString:@"." withString:@"0"];//
            
            NSInteger differ = currentS.length - targetS.length;//2.5.0 2.5
            if (labs(differ)) {//取绝对值
                
                if (differ > 0) {
                    //  防止后台版本返回2.5   时  后面补0
                    for (int i = 0 ; i < labs(differ) ; i++) {
                        targetS = [targetS stringByAppendingString:@"0"];
                    }
                    
                }else{
                    //   防止app版本显示2.5   时  后面补0
                    for (int i = 0 ; i < labs(differ) ; i++) {
                        currentS = [currentS stringByAppendingString:@"0"];
                    }
                }
            }
            
            if ([currentS integerValue] < [targetS integerValue]) {
                
                NSString *message = [PayConfig  nilStr:listing.getResponseDictionary[@"updateInfo"]];
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"      " message:message preferredStyle:UIAlertControllerStyleAlert];
                
                [alert addAction:[UIAlertAction actionWithTitle:@"版本更新" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                    NSString *urlString = listing.getResponseDictionary[@"downloadURL"];
                    
                    [NSThread cancelPreviousPerformRequestsWithTarget:self];
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
                    
                    exit(0);//退出应用程序
                    
                }]];
                
                if ([[PayConfig  nilStr:[listing.getResponseDictionary valueForKey:@"isMandatory"]] isEqualToString:@"N"]) {
                    [alert addAction:[UIAlertAction actionWithTitle:@"稍后更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                    }]];
                }
                
                UIViewController *current = [blockSelf getCurrentViewController];
                [current.navigationController presentViewController:alert animated:YES completion:nil];
            }
        }
        
    }];
}

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentViewController
{
    if ([self.window.rootViewController isKindOfClass:[UITabBarController class]]) {
        
        UITabBarController *tabBarC = (UITabBarController *)self.window.rootViewController;
        
        UINavigationController *result = tabBarC.selectedViewController;
        
        UIViewController *controllers = [result visibleViewController];
        
        return controllers;
        
    }else if ([self.window.rootViewController isKindOfClass:[UINavigationController class]]){
        
        UINavigationController *currentNA = (UINavigationController *)self.window.rootViewController;
        
        return currentNA.visibleViewController;
        
    }
    
    return nil;
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
 
    NSLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}



#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:
(UIUserNotificationSettings *)notificationSettings {
}

// Called when your app has been activated by the user selecting an action from
// a local notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forLocalNotification:(UILocalNotification *)notification
  completionHandler:(void (^)())completionHandler {
}

// Called when your app has been activated by the user selecting an action from
// a remote notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forRemoteNotification:(NSDictionary *)userInfo
  completionHandler:(void (^)())completionHandler {
}
#endif

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"iOS6及以下系统，收到通知:%@", [self logDic:userInfo]);
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler {
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"iOS7及以上系统，收到通知:%@", [self logDic:userInfo]);
    
    if ([[UIDevice currentDevice].systemVersion floatValue]<10.0 || application.applicationState>0) {
    }
    
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
}

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#pragma mark- JPUSHRegisterDelegate
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 前台收到远程通知:%@", [self logDic:userInfo]);
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 收到远程通知:%@", [self logDic:userInfo]);
        
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    
    completionHandler();  // 系统要求执行这个方法
}
#endif

// log NSSet with UTF8
// if not ,log will be \Uxxx
- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}

@end
