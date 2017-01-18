//
//  CustomPresentationController.h
//  QRPay
//
//  Created by 黄露 on 2016/11/23.
//  Copyright © 2016年 yy. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger , CustomPrentedViewAppearDirection){
    fromTopLeftToRight = 0,     //  从左到右
    fromBottomToTop,            //  从底部到上部
    fromTopRightToLeft,         //  从右边到左边
    fromBottomRightToTopLeft,   //  从左边底部到右上部
    fromShadeToLight            //  从暗到明渐进
};

@interface CustomPresentationController : UIPresentationController

@property (nonatomic ,strong) void (^PressBackgroundViewBlock)();

@end
