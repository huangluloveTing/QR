//
//  QRCodeCreatView.h
//  QRPay
//
//  Created by yy on 16/9/18.
//  Copyright © 2016年 yy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QRCodeCreatView : UIView

@property (nonatomic , assign)CGFloat size;
@property (nonatomic , copy)NSString *URLString;
@property (nonatomic , strong)UIImageView *QRimageView;

-(void)startCreat;
-(UIImage *)getImgae;

@end
