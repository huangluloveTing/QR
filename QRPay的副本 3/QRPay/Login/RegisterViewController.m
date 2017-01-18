//
//  RegisterViewController.m
//  EasyPay
//
//  Created by osx on 15/11/2.
//  Copyright © 2015年 Leione. All rights reserved.
//

#import "RegisterViewController.h"
@interface RegisterViewController ()<UITextFieldDelegate,UITextViewDelegate>
{
    int seconds;
    NSTimer *timer;
    NSString *interface;
    NSString *tempCode;
}

@property (strong, nonatomic) IBOutlet UIScrollView *backView;

@property (strong, nonatomic) IBOutlet UITextField *phoneTextFiled;
@property (strong, nonatomic) IBOutlet UITextField *verificationCode;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextFiled;
//@property (strong, nonatomic) IBOutlet UITextField *confirmPassword;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;

@property (nonatomic ,strong) NSString *scopeString;

@property (strong, nonatomic) IBOutlet UIButton *codeButton;





@end

@implementation RegisterViewController


- (void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
     [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.fd_prefersNavigationBarHidden = YES;
    
}

- (void)viewDidLoad {
    // Do any additional setup after loading the view from its nib.
    self.fd_prefersNavigationBarHidden = YES;

    
    [super viewDidLoad];
    [self configThisView];
    
    switch (self.source) {
        case 1:
            _scopeString = @"CREATE_OPERATOR";
            break;
            
        case 2:
            _scopeString = @"FORGET_PASSWORD";
            break;
            
        default:
            break;
    }
    
    seconds = 60;
    self.navigationItem.leftBarButtonItem = self.leftBarButton;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGuestureAction)];
    
    [self.backView addGestureRecognizer:tap];
    self.backView.delegate = self;
}

- (void)configThisView
{
//    self.motionView.image = [UIImage imageNamed:@"denglujm"];
//    self.view.layer.contents = (id)[UIImage imageNamed: [UPConfig getLoginBackGroundImage]].CGImage;

    
    _backView.bounces = NO;
    _backView.backgroundColor = RGBCOLOR(40, 126, 251);
    self.navigationItem.leftBarButtonItem = self.leftBarButton;
    _backView.contentSize = CGSizeMake(kDeviceWidth, kDeviceHeight);
    
    _submitButton.layer.masksToBounds = YES;
    _submitButton.layer.cornerRadius = 5;

 
    self.titleLabel.text = @"忘记密码";
        
    
    [self.submitButton setTitle:@"确定" forState:UIControlStateNormal];

    self.phoneTextFiled.delegate = self;
    self.verificationCode.delegate =self;
    self.passwordTextFiled.delegate = self;
}

-(void)initTimer
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.codeButton.userInteractionEnabled=NO;
        [self.codeButton setTitle:[NSString stringWithFormat:@"%d秒",seconds] forState:UIControlStateNormal];
    
    });
    
    NSTimeInterval timeInterval =1.0 ;
    
    if (timer) {
        [timer invalidate];
    }
    
    //定时器
    timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(timing:) userInfo:nil repeats:YES];
    
    
    [timer setFireDate:[NSDate distantPast]];
    [[NSRunLoop currentRunLoop] run];
}



- (void)timing:(NSTimer *)time
{
    seconds--;
    [self performSelectorOnMainThread:@selector(showTime) withObject:nil waitUntilDone:NO];
}

- (void)showTime
{
    [self.codeButton setTitle:[NSString stringWithFormat:@"%d秒",seconds] forState:UIControlStateNormal];
    
    if (seconds==0) {
        [timer invalidate];
        seconds=60;
        
        self.codeButton.userInteractionEnabled=YES;
        [self.codeButton setTitle:[NSString stringWithFormat:@"获取验证码"] forState:UIControlStateNormal];
    }
    
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    
    if ([_phoneTextFiled isFirstResponder]) {
        
        [_verificationCode becomeFirstResponder];
        
    }else if ([_verificationCode isFirstResponder]){
        
        [_passwordTextFiled becomeFirstResponder];
        
    }else if ([_passwordTextFiled isFirstResponder]){
        
        [textField resignFirstResponder];
        
    }
    
    return YES;
    
}

- (UILabel *)configTextFiledLeftViewWithTitle:(NSString *)string
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 25)];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:19.0];
    label.text = string;
    
    return label;
}

- (IBAction)xianShiPwdButton:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    UIImage *image = sender.selected ? [UIImage imageNamed:@"yanjing_select"] : [UIImage imageNamed:@"yanjing"];
    
    [sender setImage:image forState:UIControlStateNormal];
    self.passwordTextFiled.secureTextEntry = !sender.selected;
  
}


- (IBAction)submit:(UIButton *)sender
{
   
   

    if (![PayConfig isIntegerNumber:_phoneTextFiled.text] || _phoneTextFiled.text.length < 10) {

        
        [MBProgressHUD showError:@"请输入正确的手机号！" toView:self.view];
        
        return;
    }
    
    
    if (![PayConfig isIntegerNumber:_verificationCode.text] || ![tempCode isEqualToString:_verificationCode.text]){
        
        [MBProgressHUD showError:@"验证码错误,请重新输入!" toView:self.view];
        
        return;
    }

    
    if (_passwordTextFiled.text.length < 6){
        
        [MBProgressHUD showError:@"密码不能小于6位数!" toView:self.view];
        return;
    }
    
    [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    
    NSDictionary *dicc = @{@"username":_phoneTextFiled.text,@"password":_passwordTextFiled.text,@"authCode":tempCode};
    
    WEAKSELF
    [netAPI getGeneralInfoInterfaceCode:@"operatorRegister" Business:dicc block:^(ReturnListModel *listing) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view.window animated:YES];
        
        if ([listing.getErrorCode isEqualToString:@"00"]) {
            
            [MBProgressHUD showSuccess:@"操作成功,即将返回登录" toView:weakSelf.view];
            [weakSelf performSelector:@selector(returnto:) withObject:nil afterDelay:2.0];
            
        }else{
            
            [MBProgressHUD showError:listing.getErrorMsg toView:weakSelf.view];
        }
    }];
}


- (IBAction)returnto:(id)sender {
    
    
    if ([timer isValid]) {
        [timer invalidate];
    }
    
    [NSThread cancelPreviousPerformRequestsWithTarget:self];
    [self.navigationController popViewControllerAnimated:YES];
}





- (IBAction)getVerificationCode:(id)sender {
    
    if (![PayConfig  isIntegerNumber:_phoneTextFiled.text] || _phoneTextFiled.text.length < 10) {

        [MBProgressHUD showError:@"请输入正确的手机号！" toView:self.view];
        
    }else{
        
        [self lanuchVerification];
        
    }
}

- (void)lanuchVerification
{
    
    WEAKSELF
    NSDictionary *dic = @{@"phoneNo":self.phoneTextFiled.text,@"scope":self.scopeString};
   
    [netAPI getGeneralInfoInterfaceCode:@"smsCheck" Business:dic block:^(ReturnListModel *listing) {
        
        if ([listing.getErrorCode isEqualToString:@"00"]) {
            tempCode = [listing.getResponseDictionary objectForKey:@"randomCode"];
            
             [NSThread detachNewThreadSelector:@selector(initTimer) toTarget:weakSelf withObject:nil];
            [MBProgressHUD showSuccess:@"发送成功！" toView:weakSelf.view];
            
        }else{
            
            [MBProgressHUD showError:listing.getErrorMsg toView:weakSelf.view];
        }
    }];
}


#pragma mark -- UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    CGFloat margin = kDeviceHeight -  (textField.frame.origin.y + textField.frame.size.height);
    
    CGPoint offset = margin  > 256 ? CGPointMake(0, -20) : CGPointMake(0, 256 - margin + 10);
    WEAKSELF
    [UIView animateWithDuration:.3 animations:^{
        weakSelf.backView.contentOffset = offset;
    }];
    
    
    return YES;
}

- (void) textFieldDidEndEditing:(UITextField *)textField {
    WEAKSELF
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.backView.contentOffset = CGPointMake(0, -20);
    }];
}

- (void)tapGuestureAction {
    [self.view endEditing:YES];
}

@end
