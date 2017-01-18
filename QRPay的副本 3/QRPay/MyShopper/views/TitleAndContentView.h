//
//  TitleAndContentView.h
//  QRPay
//
//  Created by 黄露 on 2016/11/29.
//  Copyright © 2016年 yy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleAndContentView : UIView

@property (nonatomic ,copy) NSString *title;            //title

@property (nonatomic ,copy) NSString *contentString;    //content

@property (nonatomic ,strong) UIColor *titleColor;      // title的颜色

@property (nonatomic ,strong) UIColor *contentColor;    // content的yans

@property (nonatomic ,strong) UIFont *titleFont;        // title的font

@property (nonatomic ,strong) UIFont *contentFont;      // content的font

- (void) toAdjustToFit;    //是否自适应

@end
