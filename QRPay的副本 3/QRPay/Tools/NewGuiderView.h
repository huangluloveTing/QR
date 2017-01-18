//
//  GuiderView.h
//  QRPay
//
//  Created by 黄露 on 2016/11/19.
//  Copyright © 2016年 yy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewGuiderView : UIView

@property (nonatomic ,strong) NSArray <UIImage *> *images; //导航页所有图片

@property (nonatomic ,assign) CGFloat duration;  //总的显示时间

@property (nonatomic ,copy) NSString *openBtnTitle;//进入按钮的title

@property (nonatomic ,strong) UIColor *btnTitleColor;//进入按钮的title颜色

@property (nonatomic ,strong) UIColor *btnBgColor;//进入按钮的背景颜色

@property (nonatomic ,strong) UIImage *btnBgImage;//进入按钮的背景图片

@property (nonatomic ,assign) CGFloat btnborderRudius;// 进入按钮的边框圆弧

@property (nonatomic ,assign) CGPoint openBtnCenterPoint; //进入按钮的位置

@property (nonatomic ,assign) BOOL isShowPageControl;     //是否显示pageControl

- (void) showLaunchView;

@end
