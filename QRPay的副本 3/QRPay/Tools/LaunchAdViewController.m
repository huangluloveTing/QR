//
//  LaunchViewController.m
//  QRPay
//
//  Created by 黄露 on 2016/11/19.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "LaunchAdViewController.h"
#import "UIButton+MineButton.h"

@interface LaunchAdViewController ()

@property (nonatomic ,strong) UIImageView *adImageView;//包含广告图片的视图

@property (nonatomic ,strong) UIButton *skipButton;    //跳过按钮

@property (nonatomic ,strong) NSTimer *cutdownTimer;   //计时器

@end

@interface LaunchAdViewController ()

@end

@implementation LaunchAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cutdownTimer = [NSTimer scheduledTimerWithTimeInterval:self.duration target:self selector:@selector(cutdownMethod) userInfo:nil repeats:NO];
    
    [self.view addSubview:self.adImageView];
    [self.view addSubview:self.skipButton];
}

- (UIImageView *)adImageView {
    if (!_adImageView) {
        _adImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        _adImageView.contentMode = UIViewContentModeScaleToFill;
        _adImageView.image = self.adImage;
        _adImageView.backgroundColor = [UIColor yellowColor];
        _adImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAdImageViewAction)];
        [_adImageView addGestureRecognizer:tapGesture];
    
    }
    
    return _adImageView;
}

- (UIButton *)skipButton {
    if (!_skipButton) {
        _skipButton = [[UIButton alloc] initWithType:UIButtonTypeCustom andTitle:@"跳过" titleColor:[UIColor redColor] frame:CGRectMake(0, 0, 40, 40)];
        _skipButton.center = self.view.center;
        if (self.skipBtnCenter.x && self.skipBtnCenter.y) {
            _skipButton.center = self.skipBtnCenter;
        }
        
        [_skipButton addTarget:self action:@selector(pressSkipBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _skipButton;
}

- (void)tapAdImageViewAction {
    self.AnimationDidEndBlock(self.destUrl);
}

- (void) cutdownMethod {
    [self pressSkipBtnAction];
}

- (void) pressSkipBtnAction {
    [self dismissViewControllerAnimated:NO completion:nil];
    [self.cutdownTimer invalidate];
}

@end
