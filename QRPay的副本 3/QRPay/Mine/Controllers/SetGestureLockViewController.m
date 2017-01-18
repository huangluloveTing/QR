//
//  SetGestureLockViewController.m
//  QRPay
//
//  Created by 黄露 on 2016/11/24.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "SetGestureLockViewController.h"


#define TEXTFONT ()

@interface SetGestureLockViewController ()<DBGuestureLockDelegate>

@property (nonatomic ,strong) DBGuestureLock *gestureLock;
@property (nonatomic ,strong) UIView *headerView;
@property (nonatomic ,strong) UILabel *bottomTipsLabel;
@property (nonatomic ,strong) UIView *containLockView;

@end

@implementation SetGestureLockViewController


#pragma mark -- Private Property Getmethod

- (UIView *) headerView {
    if (!_headerView) {
        
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_VIEW(self.view), 80)];
        
        CGFloat subviewH = (HEIGHT_VIEW(_headerView) - 15) / 2;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, WIDTH_VIEW(_headerView), subviewH )];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = [UIImage imageNamed:@"qrdemo"];
        [_headerView addSubview:imageView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, VIEW_MAXY(imageView) + 5, WIDTH_VIEW(self.view), subviewH)];
        titleLabel.text = @"绘制解锁图案";
        titleLabel.textColor = [UIColor darkTextColor];
        titleLabel.font = [UIFont systemFontOfSize:15];
        [_headerView addSubview:titleLabel];
        titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _headerView;
}



- (UIView *) containLockView {
    if (!_containLockView) {
        _containLockView = [[UIView alloc] initWithFrame:CGRectMake(0, VIEW_MAXY(self.headerView), WIDTH_VIEW(self.view), WIDTH_VIEW(self.view))];
        self.gestureLock = [DBGuestureLock lockOnView:_containLockView delegate:self];
        [_containLockView addSubview:self.gestureLock];
        
        NSLog(@"password = %@",[[self.gestureLock class] getGuestureLockPassword]);
    }
    return _containLockView;
}

- (UILabel *) bottomTipsLabel {
    if (!_bottomTipsLabel) {
        _bottomTipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, VIEW_MAXY(self.containLockView), WIDTH_VIEW(self.view), 30)];
        if (self.setType == ToSetGuesture) {
            _bottomTipsLabel.text = @"设置手势密码，防止他人未经授权查看";
        } else {
            _bottomTipsLabel.text = @"验证手势";
        }
        
        _bottomTipsLabel.textColor = [UIColor darkTextColor];
        _bottomTipsLabel.font = [UIFont systemFontOfSize:15];
        _bottomTipsLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _bottomTipsLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.containLockView];
    [self.view addSubview:self.bottomTipsLabel];
   
    self.navigationItem.leftBarButtonItem = self.leftBarButton;
}

- (void) customPopViewController {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- DBGestureLockDelegate
-(void) guestureLock:(DBGuestureLock *)lock didSetPassword:(NSString *)password {

    lock.firstTimeSetupPassword = password;
    
    if (password.length < 4) {
        self.bottomTipsLabel.text = @"至少4个 , 再次输入你的手势";
        [[lock class] clearGuestureLockPassword];
    }
    
    else {
        self.bottomTipsLabel.text = @"再次输入你的手势";
    }
}

-(void) guestureLock:(DBGuestureLock *)lock didGetCorrectPswd:(NSString *)password {

//    if (lock.firstTimeSetupPassword && ![lock.firstTimeSetupPassword isEqualToString:DBFirstTimeSetupPassword]) {
//        lock.firstTimeSetupPassword = DBFirstTimeSetupPassword;
//        NSLog(@"password has been setup!");
//        self.bottomTipsLabel.text = @"password has been setup!";
//    } else {
        NSLog(@"login success");
        
        if (self.setType == ToClearGuesture) {
            [[lock class] clearGuestureLockPassword];
            self.bottomTipsLabel.text = @"手势已取消";
        }else {
            self.bottomTipsLabel.text = @"手势设置成功";
        }
        
        [self performSelector:@selector(customPopViewController) withObject:self afterDelay:0.3];
//    }
}

- (void) guestureLock:(DBGuestureLock *)lock didGetIncorrectPswd:(NSString *)password {
    //NSLog(@"Password incorrect: %@", password);
    if (![lock.firstTimeSetupPassword isEqualToString:DBFirstTimeSetupPassword]) {
        NSLog(@"Error: password not equal to first setup!");
        self.bottomTipsLabel.text = @"手势错误 ！";
    } else {
        NSLog(@"login failed");
        self.bottomTipsLabel.text = @"手势错误 ！";
    }
}

-(BOOL)showButtonCircleCenterPointOnState:(DBButtonState)buttonState {
    /*
    DBButtonStateNormal = 0,
    DBButtonStateSelected,
    DBButtonStateIncorrect
    */
    switch (buttonState) {
        case DBButtonStateNormal:
            return NO;
            break;
            
        case DBButtonStateSelected:
            return YES;
            break;
            
        case DBButtonStateIncorrect:
            return YES;
            break;
            
        default:
            break;
    }
    return YES;
}
-(BOOL)fillButtonCircleCenterPointOnState:(DBButtonState)buttonState {
    switch (buttonState) {
        case DBButtonStateNormal:
            return NO;
            break;
            
        case DBButtonStateSelected:
            return YES;
            break;
            
        case DBButtonStateIncorrect:
            return YES;
            break;
            
        default:
            break;
    }
    return YES;
}
-(CGFloat)radiusOfButtonCircleOnState:(DBButtonState)buttonState{
    switch (buttonState) {
        case DBButtonStateNormal:
            return 2;
            break;
            
        case DBButtonStateSelected:
            return 2;
            break;
            
        case DBButtonStateIncorrect:
            return 2;
            break;
            
        default:
            break;
    }
    return 2;
}
-(CGFloat)widthOfButtonCircleStrokeOnState:(DBButtonState)buttonState {
    
    switch (buttonState) {
        case DBButtonStateNormal:
            return 2;
            break;
            
        case DBButtonStateSelected:
            return 2;
            break;
            
        case DBButtonStateIncorrect:
            return 2;
            break;
            
        default:
            break;
    }
    
}
-(CGFloat)radiusOfButtonCircleCenterPointOnState:(DBButtonState)buttonState {
    switch (buttonState) {
        case DBButtonStateNormal:
            return 0;
            break;
            
        case DBButtonStateSelected:
            return 2;
            break;
            
        case DBButtonStateIncorrect:
            return 2;
            break;
            
        default:
            return 2;
            break;
    }
}
-(CGFloat)lineWidthOfGuestureOnState:(DBButtonState)buttonState {
    switch (buttonState) {
        case DBButtonStateNormal:
            return 5;
            break;
            
        case DBButtonStateSelected:
            return 5;
            break;
            
        case DBButtonStateIncorrect:
            return 5;
            break;
            
        default:
            return 5;
            break;
    }
}
-(UIColor *)colorOfButtonCircleStrokeOnState:(DBButtonState)buttonState {
    switch (buttonState) {
        case DBButtonStateNormal:
            return [UIColor lightGrayColor];
            break;
            
        case DBButtonStateSelected:
            return [UIColor darkGrayColor];
            break;
            
        case DBButtonStateIncorrect:
            return [UIColor redColor];
            break;
            
        default:
            return [UIColor whiteColor];
            break;
    }
}
-(UIColor *)colorForFillingButtonCircleOnState:(DBButtonState)buttonState {
    switch (buttonState) {
        case DBButtonStateNormal:
            return [UIColor whiteColor];
            break;
            
        case DBButtonStateSelected:
            return [UIColor lightGrayColor];
            break;
            
        case DBButtonStateIncorrect:
            return [UIColor orangeColor];
            break;
            
        default:
            break;
    }
}
-(UIColor *)colorOfButtonCircleCenterPointOnState:(DBButtonState)buttonState {
    switch (buttonState) {
        case DBButtonStateNormal:
            return [UIColor lightGrayColor];
            break;
            
        case DBButtonStateSelected:
            return [UIColor greenColor];
            break;
            
        case DBButtonStateIncorrect:
            return [UIColor redColor];
            break;
            
        default:
            break;
    }
}
-(UIColor *)lineColorOfGuestureOnState:(DBButtonState)buttonState {
    switch (buttonState) {
        case DBButtonStateNormal:
            return [UIColor lightGrayColor];
            break;
            
        case DBButtonStateSelected:
            return [UIColor lightGrayColor];
            break;
            
        case DBButtonStateIncorrect:
            return [UIColor redColor];
            break;
            
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
