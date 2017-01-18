//
//  BindShopperOrPartnerViewController.m
//  QRPay
//
//  Created by 黄露 on 2016/12/1.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "BindShopperOrPartnerViewController.h"
#import "RootViewController.h"

#define VIEW_MARGIN (20 * PPWidth)

@interface BindShopperOrPartnerViewController ()<UITextFieldDelegate>

@property (nonatomic ,strong) UIButton *dismissBtn;

@property (nonatomic ,strong) UIImageView *logoImageView;

@property (nonatomic ,strong) UILabel *typeLabel;

@property (nonatomic ,strong) UILabel *typeNameLabel;

@property (nonatomic ,strong) UITextField *phoneTextField;

@property (nonatomic ,strong) UILabel *smsCheckLabel;

@property (nonatomic ,strong) UITextField *smsCheckTextField;

@property (nonatomic ,strong) UIButton *sendSmsBtn;

@property (nonatomic ,strong) UIButton *sureBtn;

@end

@implementation BindShopperOrPartnerViewController
{
    CGSize keyboardPoint;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    switch (self.actionType) {
        case action_bindPartner:
                self.view.layer.contents = (id)[UIImage imageNamed:@"partnerBindBg"].CGImage;
            break;
            
        case action_BindShopper:
            self.view.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"shoperBindBg"].CGImage);
            break;
            
        default:
            break;
    }
    
    _dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_dismissBtn setImage:[UIImage imageNamed:@"whiteback"] forState:UIControlStateNormal];
    [_dismissBtn addTarget:self action:@selector(gobackPreVC) forControlEvents:UIControlEventTouchUpInside];
    _dismissBtn.frame = CGRectMake(20, 25, 30, 30);
    [self.view addSubview:_dismissBtn];
    
    [self configViews];
    [PayConfig addKeyBorderObserveWithTarget:self andKeyborderAppearSEL:@selector(keyBoarderWillShow:) eyborderDisappearSEL:@selector(keyBoardWillHidden:)];
}

- (void) viewDidLayoutSubviews {
    
}

- (void) configViews {
    self.logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(35 * PPWidth, 70 * PPWidth, kDeviceWidth - 70 * PPWidth, 65 * PPWidth)];
    self.logoImageView.image = [UIImage imageNamed:@"app——login"];
    self.logoImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.logoImageView];
    
    NSString *typeName = [NSString string];
    
    switch (self.actionType) {
        case action_bindPartner:
            typeName = @"合伙人";
            break;
            
        case action_BindShopper:
            typeName = @"商户";
            
        default:
            break;
    }
    
    self.typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, VIEW_MAXY(self.logoImageView) + 50 * PPWidth, kDeviceWidth, 25 * PPWidth)];
    self.typeLabel.textColor = [UIColor whiteColor];
    self.typeLabel.textAlignment = NSTextAlignmentCenter;
    self.typeLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:20 * PPWidth];
    self.typeLabel.text = [NSString stringWithFormat:@"%@绑定",typeName];
    [self.view addSubview:self.typeLabel];
    
    self.typeNameLabel = [[UILabel alloc] init];
    self.typeNameLabel.textAlignment = NSTextAlignmentLeft;
    self.typeNameLabel.font = [UIFont systemFontOfSize:20 * PPWidth];
    self.typeNameLabel.text = [NSString stringWithFormat:@"%@电话:",typeName];
    CGSize typeSize = [self sizeWithText:self.typeNameLabel.text font:self.typeNameLabel.font];
    self.typeNameLabel.frame = CGRectMake(VIEW_MARGIN, VIEW_MAXY(self.typeLabel) + 50 * PPWidth, typeSize.width, 30 * PPWidth);
    self.typeNameLabel.textColor = [UIColor whiteColor];
    
    [self.view addSubview:self.typeNameLabel];
    
    self.phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(VIEW_MAXX(self.typeNameLabel) + 5, VIEW_MINY(self.typeNameLabel), kDeviceWidth - 2 * VIEW_MARGIN - WIDTH_VIEW(self.typeNameLabel) - 5, HEIGHT_VIEW(self.typeNameLabel))];
    self.phoneTextField.delegate = self;
    self.phoneTextField.textColor = [UIColor whiteColor];
    self.phoneTextField.placeholder = [NSString stringWithFormat:@"请输入%@电话",typeName];
    self.phoneTextField.font = [UIFont systemFontOfSize:18 * PPWidth];
    self.phoneTextField.textAlignment = NSTextAlignmentLeft;
    self.phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    self.phoneTextField.center = CGPointMake(self.phoneTextField.center.x, self.typeNameLabel.center.y);
    [self.view addSubview:self.phoneTextField];
    
    UILabel *seperateLine_1 = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_MIXX(self.typeNameLabel), VIEW_MAXY(self.typeNameLabel) + 1 , VIEW_MAXX(self.phoneTextField) - VIEW_MIXX(self.typeNameLabel), 1)];
    seperateLine_1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:seperateLine_1];
    
    self.smsCheckLabel = [[UILabel alloc] init];
    self.smsCheckLabel.text = @"验证码:";
    self.smsCheckLabel.textAlignment = NSTextAlignmentLeft;
    self.smsCheckLabel.textColor = [UIColor whiteColor];
    self.smsCheckLabel.font = [UIFont systemFontOfSize:20 * PPWidth];
    CGSize smsSize = [self sizeWithText:self.smsCheckLabel.text font:self.smsCheckLabel.font];
    self.smsCheckLabel.frame = CGRectMake(VIEW_MARGIN, VIEW_MAXY(seperateLine_1) + 50 * PPWidth, smsSize.width, 30 * PPWidth);
    [self.view addSubview:self.smsCheckLabel];
    
    self.sendSmsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    NSString *btnStr = @"获取验证码";
    [self.sendSmsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.sendSmsBtn setBackgroundImage:[UIImage imageNamed:@"smscheck"] forState:UIControlStateNormal];
    self.sendSmsBtn.titleLabel.font = [UIFont systemFontOfSize:16 * PPWidth];
    CGSize smsBtnSize = [self sizeWithText:btnStr font:self.sendSmsBtn.titleLabel.font];
    self.sendSmsBtn.frame = CGRectMake(kDeviceWidth - VIEW_MARGIN - smsBtnSize.width, VIEW_MINY(self.smsCheckLabel), smsBtnSize.width, 30 * PPWidth);
    [self.view addSubview:self.sendSmsBtn];
    self.sendSmsBtn.tag = 100;
    [self.sendSmsBtn addTarget:self action:@selector(submitBindAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.smsCheckTextField = [[UITextField alloc] initWithFrame:CGRectMake(VIEW_MAXX(self.smsCheckLabel) + 5, VIEW_MINY(self.smsCheckLabel), VIEW_MIXX(self.sendSmsBtn) - VIEW_MAXX(self.smsCheckLabel) - 5, 30 * PPWidth)];
    self.smsCheckTextField.font = [UIFont systemFontOfSize:18 * PPWidth];
    self.smsCheckTextField.textColor = [UIColor whiteColor];
    self.smsCheckTextField.textAlignment = NSTextAlignmentLeft;
    self.smsCheckTextField.placeholder = @"请获取验证码";
    self.smsCheckTextField.delegate = self;
    self.smsCheckTextField.center = CGPointMake(self.smsCheckTextField.center.x, self.smsCheckLabel.center.y);
    self.smsCheckTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [self.view addSubview:self.smsCheckTextField];
    
    UILabel *seperateLine_2 = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_MARGIN, VIEW_MAXY(self.smsCheckLabel) + 1, kDeviceWidth - 2 * VIEW_MARGIN, 1)];
    seperateLine_2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:seperateLine_2];
    
    self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sureBtn.frame = CGRectMake(100 * PPWidth, VIEW_MAXY(seperateLine_2) + 50 * PPWidth, kDeviceWidth - 200 * PPWidth, 55 * PPWidth);
    [self.sureBtn setImage:[UIImage imageNamed:@"sureBindHighlight"] forState:UIControlStateNormal];
    [self.sureBtn setImage:[UIImage imageNamed:@"sureBind"] forState:UIControlStateHighlighted];
    self.sureBtn.titleLabel.font = [UIFont systemFontOfSize:18 * PPWidth];
    [self.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:self.sureBtn];
    self.sureBtn.tag = 101;
    [self.sureBtn addTarget:self action:@selector(submitBindAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKeyBoarder)];
    [self.view addGestureRecognizer:tapGesture];
}

- (CGSize) sizeWithText:(NSString *)text font:(UIFont *)font {
    return [text sizeWithAttributes:@{NSFontAttributeName : font}];
}

#pragma mark -- dismissVC 
-(void) gobackPreVC {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- HiddenKeyBoard
- (void)hiddenKeyBoarder {
    [self.view endEditing:YES];
}

#pragma mark -- KeyBoarShowAndHidden
- (void)keyBoarderWillShow:(NSNotification *)notify {
    NSLog(@"notify = %@",notify.userInfo);
    
    keyboardPoint = [[notify.userInfo objectForKey:@"UIKeyboardFrameBeginUserInfoKey"] CGRectValue].size;
}

#pragma mark -- Operation Sessesion


- (void) submitBindAction:(UIButton *)sender {
    
    NSDictionary *dic = [NSDictionary dictionary];
    
    if (![PayConfig  isIntegerNumber:_phoneTextField.text]  || ![PayConfig isMobile:_phoneTextField.text]) {
        
        [MBProgressHUD showError:@"请输入正确的手机号" toView:self.view];
        return;
    }
    
    NSString *interFace = [NSString string];
    
    if (sender.tag == 100) {
        interFace = @"smsCheck";
        dic = @{@"phoneNo":self.phoneTextField.text,@"scope":@"CREATE_OPERATOR"};
        
        [self requestToServerceWithParams:dic andInterFace:interFace];
    }  else {
    
        
        switch (self.actionType) {
            case action_bindPartner:
                interFace = @"bindPartner";
                break;
                
            case action_BindShopper:
                interFace = @"bindCustomer";
                break;
                
            default:
                break;
        }
        
        dic = @{
                   @"username":self.phoneTextField.text,
                   @"appUsername":[[NSUserDefaults standardUserDefaults] valueForKey:@"phone"],
                   @"authCode":self.smsCheckTextField.text
               };
        
        [self requestToServerceWithParams:dic andInterFace:interFace];
    }
}

- (void) requestToServerceWithParams:(NSDictionary *)parames andInterFace:(NSString *)interface{
    
    [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    
    WEAKSELF
    
    [netAPI getGeneralInfoInterfaceCode:interface Business:parames block:^(ReturnListModel *listing) {
        
        if ([listing.getErrorCode isEqualToString:@"00"]) {
            
            if ([interface isEqualToString:@"operatorLogin"]) {
                
                [weakSelf dismissViewControllerAnimated:YES completion:^{
                    
                }];

            } else if ([interface isEqualToString:@"smsCheck"]){
                
            }
            
            else {
                
                NSString *password = [[NSUserDefaults standardUserDefaults] valueForKey:@"password"];
                NSString *user = [[NSUserDefaults standardUserDefaults] valueForKey:@"phone"];
                [self requestToServerceWithParams:[NSDictionary dictionaryWithObjectsAndKeys:@"",user,@"",password, nil] andInterFace:@"operatorLogin"];
            }
            
            [MBProgressHUD hideAllHUDsForView:weakSelf.view.window animated:YES];
            
        }else{
            
            [MBProgressHUD hideAllHUDsForView:weakSelf.view.window animated:YES];
            [MBProgressHUD showError:listing.getErrorMsg toView:weakSelf.view];
            
        }
        
    }];
}

- (void) keyBoardWillHidden:(NSNotification *)notify {
    NSLog(@"notify = %@",notify.userInfo);
}

- (void) dealloc {
    
    [PayConfig removeKeyBorderObserveWithTarget:self];
}

- (void) textFieldDidBeginEditing:(UITextField *)textField {
    
    CGRect textFieldFrame = self.view.frame;
    textFieldFrame.origin.y = 0 ;
    self.view.frame = textFieldFrame;
    
    CGPoint textPoint = textField.frame.origin;
    
    NSLog(@"point y = %f",textPoint.y);
    
    if (textPoint.y + textField.frame.size.height + keyboardPoint.height > kDeviceHeight) {
        
        [UIView animateWithDuration:0.25 animations:^{
            CGRect textFrame = self.view.frame;
            textFrame.origin.y -= (textPoint.y + textField.frame.size.height) + keyboardPoint.height - kDeviceHeight + 10;
            
            self.view.frame = textFrame;
        }];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [UIView animateWithDuration:0.25 animations:^{
        CGRect textFieldFrame = self.view.frame;
        textFieldFrame.origin.y = 0 ;
        self.view.frame = textFieldFrame;
    }];
}


@end
