//
//  LaunchViewController.h
//  QRPay
//
//  Created by 黄露 on 2016/11/19.
//  Copyright © 2016年 yy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LaunchAdViewController : UIViewController

@property (nonatomic ,strong) UIImage *adImage; //本地图片的启动画面
@property (nonatomic ,copy) NSString *destUrl;  //点击图片对应的操作URL

@property (nonatomic ,strong) void  (^AnimationDidEndBlock)(NSString *destUrl); //动画结束或者点击跳转按钮后的block

@property (nonatomic ,assign) CGFloat duration; //停留时间

@property (nonatomic ,assign) CGPoint skipBtnCenter; //跳过按钮的中点坐标

@end
