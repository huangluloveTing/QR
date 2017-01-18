//
//  YYAlertsView.m
//  提示框寻常
//
//  Created by yy on 16/7/7.
//  Copyright © 2016年 yy. All rights reserved.
//


#define MainScreenRect [UIScreen mainScreen].bounds
#define AlertView_W     270.0f
#define MessageMin_H    60.0f       //messagelab的最小高度
#define MessageMAX_H    120.0f      //messagelab的最大高度，当超过时，文本会以...结尾
#define YYATitle_H      20.0f
#define YYABtn_H        35.0f


#define YYADTitleFont       [UIFont boldSystemFontOfSize:17];
#define YYADMessageFont     [UIFont systemFontOfSize:14];
#define YYADBtnTitleFont    [UIFont systemFontOfSize:15];



#import "YYAlertsView.h"

@interface YYAlertsView() <UITextFieldDelegate>
@property (nonatomic,strong)UIWindow *alertWindow;
@property (nonatomic,strong)UIView   *alertView;

@property (nonatomic,strong)UILabel  *titleLab;
@property (nonatomic,strong)UILabel  *messageLab;
@property (nonatomic,strong)UIButton *cancelBtn;
@property (nonatomic,strong)UIButton *otherBtn;

@end



@implementation YYAlertsView {
    __block CGPoint alertTempY;
}





-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelBtnTitle:(NSString *)cancelTitle otherBtnTitle:(NSString *)otherBtnTitle
{
    
    if(self = [super init]){
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBorderAppear:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBorderDisappear:) name:UIKeyboardWillHideNotification object:nil];
        
        self.frame=MainScreenRect;
        self.backgroundColor=[UIColor colorWithWhite:.3 alpha:.7];
        
        _alertView=[UIView new];
        _alertView.backgroundColor=[UIColor whiteColor];
        _alertView.layer.cornerRadius=6.0;
        _alertView.layer.masksToBounds=YES;
        _alertView.userInteractionEnabled=YES;

        
        if (title) {
            _titleLab=[UILabel new];
            _titleLab.text=title;
            _titleLab.textAlignment=NSTextAlignmentCenter;
            _titleLab.textColor=[UIColor blackColor];
            _titleLab.font=YYADTitleFont;
        }


        if (message) {
            _messageLab=[UILabel new];
            _messageLab.textColor=[UIColor darkGrayColor];
            _messageLab.font=YYADMessageFont;
            _messageLab.text = message;
            _messageLab.numberOfLines=0;
            _messageLab.lineBreakMode=NSLineBreakByTruncatingTail;

        }
        //计算_alertView的高度
        [self addSubview:_alertView];
        [_alertView addSubview:_titleLab];
        [_alertView addSubview:_messageLab];
    
        
        _titleLab.frame = CGRectMake(0, 10, AlertView_W, YYATitle_H);
        
        
        _messageLab.frame = CGRectMake(15, VIEW_MAXY(_titleLab)+15, AlertView_W-30, [self getHighWithString:message withFont:14 width:AlertView_W-30]);
        
        
        _alertView.frame=CGRectMake(0, 0, AlertView_W, _messageLab.frame.size.height+YYATitle_H+YYABtn_H+50);
        _alertView.center=self.center;
        
        
        if (cancelTitle) {
            _cancelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            [_cancelBtn setTitle:cancelTitle forState:UIControlStateNormal];
            [_cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _cancelBtn.backgroundColor = RGBACOLOR(200, 200, 200, 1);
            _cancelBtn.titleLabel.font=YYADBtnTitleFont;
            _cancelBtn.layer.cornerRadius=3;
            _cancelBtn.layer.masksToBounds=YES;
            [_cancelBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_alertView addSubview:_cancelBtn];
        }
        
        if (otherBtnTitle) {
            _otherBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            [_otherBtn setTitle:otherBtnTitle forState:UIControlStateNormal];
            [_otherBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _otherBtn.titleLabel.font=YYADBtnTitleFont;
            _otherBtn.layer.cornerRadius=3;
            _otherBtn.layer.masksToBounds=YES;
            _otherBtn.backgroundColor = RGBACOLOR(15, 131, 255, 1);
            [_otherBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_alertView addSubview:_otherBtn];
        }

        
        
        CGFloat btnLeftSpace = 20;//btn到左边距
        CGFloat btn_y = _alertView.frame.size.height-43;
        if (cancelTitle && !otherBtnTitle) {
            _cancelBtn.tag=0;
            _cancelBtn.frame=CGRectMake(btnLeftSpace, btn_y, AlertView_W-btnLeftSpace*2, YYABtn_H);
            
        }else if (!cancelTitle && otherBtnTitle){
            _otherBtn.tag=0;
            _otherBtn.frame=CGRectMake(btnLeftSpace, btn_y, AlertView_W-btnLeftSpace*2, YYABtn_H);
            
        }else if (cancelTitle && otherBtnTitle){
            _cancelBtn.tag=0;
            _otherBtn.tag=1;
            CGFloat btnSpace = 20;//两个btn之间的间距
            CGFloat btn_w =(AlertView_W-btnLeftSpace*2-btnSpace)/2;
        
            _cancelBtn.frame=CGRectMake(btnLeftSpace, btn_y, btn_w, YYABtn_H);
            _otherBtn.frame=CGRectMake(_alertView.frame.size.width-btn_w-btnLeftSpace, btn_y, btn_w, YYABtn_H);
        }
        
    }
    
    return self;
    
}



//创建输入框
-(instancetype)initWithTitle:(NSString *)title placeholder:(NSString *)string cancelBtnTitle:(NSString *)cancelTitle otherBtnTitle:(NSString *)otherBtnTitle{
    if(self = [super init]){
        self.frame=MainScreenRect;
        self.backgroundColor=[UIColor colorWithWhite:.3 alpha:.7];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBorderAppear:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBorderDisappear:) name:UIKeyboardWillHideNotification object:nil];
        _alertView=[UIView new];
        _alertView.backgroundColor=[UIColor whiteColor];
        _alertView.layer.cornerRadius=6.0;
        _alertView.layer.masksToBounds=YES;
        _alertView.userInteractionEnabled=YES;
        
        
        _titleLab=[UILabel new];
        _titleLab.text=title;
        _titleLab.textAlignment=NSTextAlignmentCenter;
        _titleLab.textColor=[UIColor blackColor];
        _titleLab.font=YYADTitleFont;
        
        
        _inputFie = [UITextField new];
        _inputFie.textColor=[UIColor darkGrayColor];
        _inputFie.font=YYADMessageFont;
        _inputFie.textAlignment = NSTextAlignmentCenter;
        _inputFie.placeholder = string;
        _inputFie.layer.borderColor= [UIColor lightGrayColor].CGColor;
        _inputFie.layer.cornerRadius = 7;
        _inputFie.layer.borderWidth= 1.0f;
        _inputFie.returnKeyType =  UIReturnKeyDone;
        _inputFie.delegate = self;
        
        //计算_alertView的高度
        [self addSubview:_alertView];
        [_alertView addSubview:_titleLab];
        [_alertView addSubview:_inputFie];
        
        
        _titleLab.frame = CGRectMake(0, 10, AlertView_W, YYATitle_H);
        
        
        _inputFie.frame = CGRectMake(15, VIEW_MAXY(_titleLab)+15, AlertView_W-30, 35);
        
        _alertView.frame=CGRectMake(0, 0, AlertView_W, _inputFie.frame.size.height+YYATitle_H+YYABtn_H+50);
        _alertView.center=self.center;

        
        if (cancelTitle) {
            _cancelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            [_cancelBtn setTitle:cancelTitle forState:UIControlStateNormal];
            [_cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _cancelBtn.backgroundColor = RGBACOLOR(200, 200, 200, 1);
            _cancelBtn.titleLabel.font=YYADBtnTitleFont;
            _cancelBtn.layer.cornerRadius=3;
            _cancelBtn.layer.masksToBounds=YES;
            [_cancelBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_alertView addSubview:_cancelBtn];
        }
        
        if (otherBtnTitle) {
            _otherBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            [_otherBtn setTitle:otherBtnTitle forState:UIControlStateNormal];
            [_otherBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _otherBtn.titleLabel.font=YYADBtnTitleFont;
            _otherBtn.layer.cornerRadius=3;
            _otherBtn.layer.masksToBounds=YES;
            _otherBtn.backgroundColor = RGBACOLOR(15, 131, 255, 1);
            [_otherBtn addTarget:self action:@selector(inputSureClick:) forControlEvents:UIControlEventTouchUpInside];
            [_alertView addSubview:_otherBtn];
        }
        
        CGFloat btnLeftSpace = 20;//btn到左边距
        CGFloat btn_y = _alertView.frame.size.height-43;
        if (cancelTitle && !otherBtnTitle) {
            _cancelBtn.tag=0;
            _cancelBtn.frame=CGRectMake(btnLeftSpace, btn_y, AlertView_W-btnLeftSpace*2, YYABtn_H);
            
        }else if (!cancelTitle && otherBtnTitle){
            _otherBtn.tag=0;
            _otherBtn.frame=CGRectMake(btnLeftSpace, btn_y, AlertView_W-btnLeftSpace*2, YYABtn_H);
            
        }else if (cancelTitle && otherBtnTitle){
            _cancelBtn.tag=0;
            _otherBtn.tag=1;
            CGFloat btnSpace = 20;//两个btn之间的间距
            CGFloat btn_w =(AlertView_W-btnLeftSpace*2-btnSpace)/2;
            
            _cancelBtn.frame=CGRectMake(btnLeftSpace, btn_y, btn_w, YYABtn_H);
            _otherBtn.frame=CGRectMake(_alertView.frame.size.width-btn_w-btnLeftSpace, btn_y, btn_w, YYABtn_H);
        }
    }
    
    return self;
}



-(void)inputSureClick:(UIButton *)btn
{
    if (self.YYAlertInputClick) {
        self.YYAlertInputClick(self.inputFie.text);
    }
    [self dismissAlertView];
}


-(void)btnClick:(UIButton *)btn{
    
    if (self.clickBlock) {
        self.clickBlock(btn.tag);
    }
    
    if (!_dontDissmiss) {
        [self dismissAlertView];
    }
    
}

-(void)setDontDissmiss:(BOOL)dontDissmiss{
    _dontDissmiss=dontDissmiss;
}

-(void)showYYAlertView{

    _alertWindow=[[UIWindow alloc] initWithFrame:MainScreenRect];
    _alertWindow.windowLevel=UIWindowLevelAlert;
    [_alertWindow becomeKeyWindow];
    [_alertWindow makeKeyAndVisible];
    
    [_alertWindow addSubview:self];
    
    [self setShowAnimation];
    
}


-(void)dismissAlertView{
    [self removeFromSuperview];
    [_alertWindow resignKeyWindow];
}


-(void)setShowAnimation{
    
    switch (_animationStyle) {
            
        case YYAnimationDefault:
        {
            [UIView animateWithDuration:0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [_alertView.layer setValue:@(0) forKeyPath:@"transform.scale"];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.23 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    [_alertView.layer setValue:@(1.2) forKeyPath:@"transform.scale"];
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.09 delay:0.02 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        [_alertView.layer setValue:@(.9) forKeyPath:@"transform.scale"];
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.05 delay:0.02 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                            [_alertView.layer setValue:@(1.0) forKeyPath:@"transform.scale"];
                        } completion:^(BOOL finished) {
                            
                        }];
                    }];
                }];
            }];
        }
            break;
            
        case YYAnimationLeftShake:{
            
            CGPoint startPoint = CGPointMake(-AlertView_W, self.center.y);
            _alertView.layer.position=startPoint;
            
            //damping:阻尼，范围0-1，阻尼越接近于0，弹性效果越明显
            //velocity:弹性复位的速度
            [UIView animateWithDuration:.8 delay:0 usingSpringWithDamping:.5 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                _alertView.layer.position=self.center;
                
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
            
        case YYAnimationTopShake:{
            
            CGPoint startPoint = CGPointMake(self.center.x, -_alertView.frame.size.height);
            _alertView.layer.position=startPoint;
            
            //damping:阻尼，范围0-1，阻尼越接近于0，弹性效果越明显
            //velocity:弹性复位的速度
            [UIView animateWithDuration:.8 delay:0 usingSpringWithDamping:.5 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                _alertView.layer.position=self.center;
                
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
            
        case YYAnimationNO:{
            
        }
            
            break;
            
        default:
            break;
    }
    
}

-(void)setAnimationStyle:(YYShowAnimationStyle)animationStyle{
    _animationStyle=animationStyle;
}


- (CGFloat)getHighWithString:(NSString *)string withFont:(CGFloat )font width:(CGFloat)with
{
    
    if (string == nil || [string isKindOfClass:[NSNull class]]) {
        string = @"";
    }
    
    //设置 属性字典
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};
    
    CGRect rect = [string boundingRectWithSize:CGSizeMake(with, 100000000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
    
    return rect.size.height;
}

#pragma mark -- textFieldDelegate

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [_inputFie resignFirstResponder];
    return YES;
}

#pragma mark -- Notification

- (void) keyBorderAppear:(NSNotification *)notify {

    CGFloat alertViewMaxY = VIEW_MAXY(_alertView); //alertView 的最大的Y值
    NSDictionary *userInfo = notify.userInfo;
    CGRect keyBorderFrame = [[userInfo objectForKey:@"UIKeyboardFrameBeginUserInfoKey"] CGRectValue];
    CGFloat keyBorderH = keyBorderFrame.size.height;
    
    //判断键盘的高度是否遮挡整个alertView
    if ((alertViewMaxY + keyBorderH) >= HEIGHT_VIEW(self)) {
        
        [UIView animateWithDuration:0.25 animations:^{
            CGPoint alertCenter = _alertView.center;
            alertTempY = alertCenter;
            alertCenter.y = alertCenter.y - (alertViewMaxY + keyBorderH - HEIGHT_VIEW(self) >= 5 ? alertViewMaxY + keyBorderH - HEIGHT_VIEW(self) : 5 );
            _alertView.center = alertCenter;
        }];
    }
}

- (void) keyBorderDisappear:(NSNotification *)notify {

    [UIView animateWithDuration:0.25 animations:^{
        _alertView.center =self.center;
        
    }];
}

- (void) dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"delloc");
}

@end
