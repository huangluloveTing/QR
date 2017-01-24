//
//  LoginViewController.m
//  EasyPay
//
//  Created by Leione on 15/9/25.
//  Copyright (c) 2015年 Leione. All rights reserved.
//



#import "RegisterViewController.h"
#import "LoginViewController.h"
#import "RootViewController.h"

#import "AppDelegate.h"
#import "PayConfig.h"
#import "UserDefaults.h"

#import "ShopListsViewController.h"



@interface LoginViewController ()<UITextFieldDelegate,UIScrollViewDelegate>


@property (strong, nonatomic) IBOutlet UIScrollView *backView;
@property (strong, nonatomic) IBOutlet UITextField *phoneTextField;
@property (strong, nonatomic) IBOutlet UITextField *passWordTextField;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UIButton *remenberPassword;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    
//    self.view.layer.contents = (id)[UIImage imageNamed: [UPConfig getLoginBackGroundImage]].CGImage;

    self.view.backgroundColor = RGBCOLOR(40, 126, 251);
    
    [self configRegisterButton];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGuestureAction)];
    
    [self.backView addGestureRecognizer:tap];
    self.backView.delegate = self;
    
    self.remenberPassword.layer.cornerRadius = 7;
    
    self.remenberPassword.layer.borderColor = TABLEVIEW_GROUPED_BGCOLOR.CGColor;
    
    self.remenberPassword.layer.borderWidth = 1;

    self.remenberPassword.layer.masksToBounds = YES;
}

- (void)configRegisterButton
{
//    [self configRegister:@"忘记密码?"];
//    self.tipslable.hidden = YES;
//    [self configRegister:@"注册/忘记密码?"];
}
- (void)configRegister:(NSString *)title{
    [self.registerButton setTitle:title forState:UIControlStateNormal];
}

- (void)viewWillAppear:(BOOL)animated
{
    
    if ([PayConfig  getUserPhone]) {
        
        _phoneTextField.text = [PayConfig  getUserPhone];
        
        [self performSelector:@selector(configKeyboard) withObject:nil afterDelay:1.0];
    }
    
    if ([PayConfig isSavePassword]) {
        _passWordTextField.text = [PayConfig getPassword];
        [self.remenberPassword setBackgroundImage:[UIImage imageNamed:@"savepasswordImage"] forState:UIControlStateNormal];
    }
    
    [self.navigationController.navigationBar setHidden:YES];
    
    [super viewWillAppear:animated];
}

- (void)configKeyboard
{
//    if ([PayConfig  getUserPhone]) {
//        
//        [_passWordTextField becomeFirstResponder];
//        
//    }else{
//        
//        [_phoneTextField becomeFirstResponder];
//    }
}

//记住密码
- (IBAction)rememberPassword:(UIButton *)sender {
    
    NSLog(@"remember password");
    
    sender.selected = ![PayConfig isSavePassword];
    
    
    
    if ([PayConfig isSavePassword]) {
        [UserDefaults saveValue:@"0" withKey:@"savapassword"];
    } else {
        [UserDefaults saveValue:@"1" withKey:@"savapassword"];
    }
    
    NSLog(@"[PayConfig isSavePassword] = %d",[PayConfig isSavePassword]);
    
    UIImage *image = [PayConfig isSavePassword] ? [UIImage imageNamed:@"savepasswordImage"] : [UIImage imageNamed:@""];
    
    [sender setBackgroundImage:image forState:UIControlStateNormal];
}

- (IBAction)xianShiPwdButton:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    UIImage *image = sender.selected ? [UIImage imageNamed:@"yanjing_select"] : [UIImage imageNamed:@"yanjing"];
    
    [sender setImage:image forState:UIControlStateNormal];
    self.passWordTextField.secureTextEntry = !sender.selected;
}

- (IBAction)login:(UIButton *)sender
{
    
    if ([_phoneTextField isFirstResponder]) {
        
        [_phoneTextField resignFirstResponder];
        
    }else if ([_passWordTextField isFirstResponder]){
        
        [_passWordTextField resignFirstResponder];
        
    }
    
    
    if (![PayConfig  isIntegerNumber:_phoneTextField.text]  ||  _phoneTextField.text.length < 8) {
        
        [MBProgressHUD showError:@"请输入正确的账号！" toView:self.view];
        return;
    }
    
    if ([PayConfig nilStr:_passWordTextField.text].length < 6) {
        
        [MBProgressHUD showError:@"用户名或密码错误" toView:self.view];
        
        return;
    }

    
    [self launchLogin];

    
    
}

- (void)launchLogin
{
    
    [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    
    WEAKSELF
    [netAPI getGeneralInfoInterfaceCode:@"operatorLogin" Business:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",_phoneTextField.text],@"username",[NSString stringWithFormat:@"%@",_passWordTextField.text],@"password",nil] block:^(ReturnListModel *listing) {
        
        if ([listing.getErrorCode isEqualToString:@"00"]) {
            
            NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults removeObjectForKey:APP_USERINFO_KEY];
            
            [userDefaults setObject:[PayConfig  dictionaryToJson:listing.getResponseDictionary] forKey:APP_USERINFO_KEY];
            
            [userDefaults setObject:_phoneTextField.text forKey:@"phone"];
            
            if ([PayConfig isSavePassword]) {
                [userDefaults setObject:_passWordTextField.text forKey:@"password"];
            }

            [userDefaults synchronize];
    
            [weakSelf changeRootViewController];
            
        }else{
            
            [MBProgressHUD hideAllHUDsForView:weakSelf.view.window animated:YES];
            [MBProgressHUD showError:listing.getErrorMsg toView:weakSelf.view];
            
        }
        
    }];



}


- (void)changeRootViewController
{
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    RootViewController*rootVC = [[RootViewController alloc]init];
    rootVC.selectedIndex = 0;
    window.rootViewController = rootVC;
}

- (IBAction)registerUser:(id)sender {
    RegisterViewController *registerVC = [[RegisterViewController alloc]init];
    
    registerVC.source = 2;
    
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (IBAction)forgetPassword:(UIButton *)sender
{
    RegisterViewController *registerVC = [[RegisterViewController alloc]init];
    
    registerVC.source = 1;
    
    [self.navigationController pushViewController:registerVC animated:YES];
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    CGFloat margin = kDeviceHeight -  (_passWordTextField.frame.origin.y + _passWordTextField.frame.size.height);
    
    CGPoint offset = margin  > 256 ? CGPointMake(0, -20) : CGPointMake(0, 256 - margin + 10);
    WEAKSELF
    [UIView animateWithDuration:.3 animations:^{
        weakSelf.backView.contentOffset = offset;
    }];
    
    
    return YES;
}

- (void)tapGuestureAction {
    [self.view endEditing:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    WEAKSELF
    [UIView animateWithDuration:.3 animations:^{
        weakSelf.backView.contentOffset = CGPointMake(0, -20);
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{

    if ([textField isEqual:self.phoneTextField]) {
        
        [self.passWordTextField becomeFirstResponder];
        
    }else if ([textField isEqual:self.passWordTextField]){
        
        [textField resignFirstResponder];
        
        [self login:nil];
        
    }
    
    return YES;
}

@end
