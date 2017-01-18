//
//  UploadIdImageTableViewCell.h
//  QRPay
//
//  Created by 黄露 on 2016/11/25.
//  Copyright © 2016年 yy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UploadIdImageTableViewCell : UITableViewCell

@property (nonatomic ,strong) UIImage *cameraImage;
@property (nonatomic ,strong) UIImage *styleImage;
@property (nonatomic ,copy)   NSString *btnTitle;

@property (nonatomic ,strong) void (^tapCameraBtnBlock)(UploadIdImageTableViewCell *cell , UIImageView *imageView);

@end
