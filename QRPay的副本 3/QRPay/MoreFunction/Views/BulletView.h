//
//  BulletView.h
//  QRPay
//
//  Created by 黄露 on 2016/11/17.
//  Copyright © 2016年 yy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BulletViewModel : NSObject

@property (nonatomic ,copy) NSString *message;

@end

@interface BulletView : UIView

//弹幕的移动速度。---> 指弹幕从开始到结束所需的时间
@property (nonatomic ,assign) CGFloat moveSpeed;

//弹幕的字体颜色
@property (nonatomic ,strong) UIColor *titleColor;

//弹幕的字体样式
@property (nonatomic ,strong) UIFont *titleFont;

//弹幕前面的图标图片
@property (nonatomic ,strong) UIImage *noteImage;

//边框宽度
@property (nonatomic ,assign) CGFloat borderWith;

//边框颜色
@property (nonatomic ,strong) UIColor *borderColor;

- (instancetype) initWithFrame:(CGRect)frame andTitles:(NSArray *)bulletTitles;

- (void) startShoot;
- (void) stopShoot;

@end
