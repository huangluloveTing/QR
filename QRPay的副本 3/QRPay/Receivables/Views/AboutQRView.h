//
//  AboutQRView.h
//  QRPay
//
//  Created by 黄露 on 2016/11/18.
//  Copyright © 2016年 yy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutQRView : UIView

@property (nonatomic ,strong) UIImage *headerImage;
@property (nonatomic ,copy)   NSString *title;

- (instancetype) initWithFrame:(CGRect)frame andImage:(UIImage *)image andTitle:(NSString *)title;

@end
