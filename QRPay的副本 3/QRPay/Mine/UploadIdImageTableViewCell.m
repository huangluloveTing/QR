//
//  UploadIdImageTableViewCell.m
//  QRPay
//
//  Created by 黄露 on 2016/11/25.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "UploadIdImageTableViewCell.h"

@interface UploadIdImageTableViewCell ()

@property (nonatomic ,strong) UIButton *cameraBtn;
@property (nonatomic ,strong) UIImageView *realImageView;

@end

@implementation UploadIdImageTableViewCell


- (UIButton *)cameraBtn {
    if (!_cameraBtn) {
        _cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _cameraBtn.frame = CGRectMake(5, 5, WIDTH_VIEW(self.contentView) / 2, HEIGHT_VIEW(self.contentView) - 10);
        
        _cameraBtn.titleEdgeInsets = UIEdgeInsetsMake(HEIGHT_VIEW(_cameraBtn) - 20 , - 60, 5, 0);
        CGFloat margin = (WIDTH_VIEW (_cameraBtn) - 40 ) / 2 ;
        _cameraBtn.imageEdgeInsets = UIEdgeInsetsMake(HEIGHT_VIEW(self.contentView) - 80 , margin, 30, margin);
        
        [_cameraBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _cameraBtn.titleLabel.font = [UIFont systemFontOfSize:14 * PPWidth];
        [_cameraBtn addTarget:self action:@selector(tapCameraBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _cameraBtn;
}

- (UIImageView *)realImageView {
    if (!_realImageView) {
        _realImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_MAXX(self.cameraBtn) + 5, 5, WIDTH_VIEW(self.contentView) - VIEW_MAXX(self.cameraBtn) - 10, HEIGHT_VIEW(self.contentView) - 10)];
        
        _realImageView.image = [UIImage imageNamed:@"bottomImage"];
        _realImageView.contentMode = UIViewContentModeScaleToFill;
        _realImageView.layer.cornerRadius = 5 * PPWidth;
        _realImageView.layer.masksToBounds = YES;
    }
    
    return _realImageView;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    [self.contentView addSubview:self.cameraBtn];
    [self.contentView addSubview:self.realImageView];
}

- (void) tapCameraBtnAction {
    NSLog(@"tap camear btn ");
    
    if (self.tapCameraBtnBlock) {
        self.tapCameraBtnBlock(self , self.realImageView);
    }
}

#pragma mark -- set property method
- (void) setBtnTitle:(NSString *)btnTitle {
    
    _btnTitle = btnTitle;
    
    [self.cameraBtn setTitle:btnTitle forState:UIControlStateNormal];
}

- (void) setStyleImage:(UIImage *)styleImage {
    _styleImage = styleImage;
    self.realImageView.image = styleImage;
    
}

- (void) setCameraImage:(UIImage *)cameraImage {
    _cameraImage = cameraImage;
    [self.cameraBtn setImage:cameraImage forState:UIControlStateNormal];
}

@end
