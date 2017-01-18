//
//  PayViewController.m
//  QRPay
//
//  Created by yy on 16/9/19.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "PayViewController.h"
#import "CircleDownCounter.h"

@interface PayViewController ()<UIAlertViewDelegate>
{
    BOOL isCanSave;
}
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UILabel *moneyLable;
@property (weak, nonatomic) IBOutlet UILabel *remarkLable;
@property (weak, nonatomic) IBOutlet UIImageView *QRImage;
@property (weak, nonatomic) IBOutlet UILabel *supportLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (strong ,nonatomic) UIAlertView *alertViews;
@property (strong ,nonatomic) UIButton *navButton;
@property (strong ,nonatomic) UIAlertController *alertActions;

@end

@implementation PayViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.leftBarButtonItem = self.leftBarButton;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.navButton];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(starSthowCircleDown) name:UIApplicationDidBecomeActiveNotification object:nil];
    isCanSave = YES;
    
    
    [self configView];
    
}


- (UIButton *)navButton
{
    if (!_navButton) {
        
        _navButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _navButton.frame = CGRectMake(0, 0,35, 35);
        [_navButton setBackgroundColor:[UIColor clearColor]];
        [_navButton addTarget:self action:@selector(checkOrderByOrderid) forControlEvents:UIControlEventTouchUpInside];
        
        [CircleDownCounter showCircleDownWithSeconds:10.0f
                                              onView:self.navButton
                                            withSize:CGSizeMake(30, 30)
                                             andType:CircleDownCounterTypeIntegerIncre];
        
    }
    
    return _navButton;
}

- (UIAlertView *)alertViews
{
    if (!_alertViews) {
     
        _alertViews = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
    }
    
    return _alertViews;
}



- (UIAlertController *)alertActions
{
    if (!_alertActions) {
        _alertActions = [UIAlertController alertControllerWithTitle:@"二维码操作" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        
        [_alertActions addAction:[UIAlertAction actionWithTitle:@"保存到相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            UIImage *qrImage = [self screenshotByQRView];
            UIImageWriteToSavedPhotosAlbum(qrImage, nil, nil, nil);
            [MBProgressHUD showSuccess:@"成功" toView:self.view];
            [self starSthowCircleDown];
            
        }]];
        if ([self.typeString isEqual:@"alipay"]) {
            
            [_alertActions addAction:[UIAlertAction actionWithTitle:@"使用支付包打开" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.payUrl]];
                
            }]];
        }
        
        [_alertActions addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self starSthowCircleDown];
        }]];
               
    }
    
    return _alertActions;
}

- (void)starSthowCircleDown
{
    [self performSelector:@selector(checkOrderByOrderid) withObject:nil afterDelay:10];
    
    [CircleDownCounter showCircleDownWithSeconds:11.0f
                                          onView:self.navButton
                                        withSize:CGSizeMake(35, 35)
                                         andType:CircleDownCounterTypeIntegerIncre];
}

- (void)stopSthowCircleDown
{
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(checkOrderByOrderid) object:nil];
    [CircleDownCounter removeCircleViewFromView:self.navButton];
}

- (void)checkOrderByOrderid
{
    WEAKSELF
    
    [netAPI getGeneralInfoInterfaceCode:@"orderDetail" Business:@{@"orderId" : self.orderid,
                                                                  @"type":   self.typeString} block:^(ReturnListModel *listing) {
        
                                                                      if ([listing.getErrorCode isEqual:@"00"]) {
                                                                          
                                                                          NSString *statusType = [listing .getResponseDictionary valueForKey:@"statusType"] ;
                                                                          
                                                                          if ([statusType isEqual:@"WAITPAY"]) {
                                                                    
                                                                              
                                                                              [self starSthowCircleDown];
                                                                             
                                                                          }else {
                                                                              
                                                                              [weakSelf stopSthowCircleDown];
                                                                              
                                                                              if ([statusType isEqual:@"SUCCESS"]){
                                                                                  
                                                                                  weakSelf.alertViews.message = @"订单支付成功";
                                                                                  
                                                                              }else if ([statusType isEqual:@"CLOSED"]){
                                                                                  weakSelf.alertViews.message = @"订单未支付,已关闭";
                                                                                  
                                                                                  
                                                                              }else if ([statusType isEqual:@"PAYERROR"]){
                                                                                  weakSelf.alertViews.message = @"订单支付失败";
                                                                                  
                                                                              }
                                                                              
                                                                              [weakSelf.alertViews show];
                                                                          }
                                                                          
                                                                        
                                                                          
                                                                      }else{
                                                                          
                                                                          [MBProgressHUD showError:listing.getErrorMsg toView:self.view];
                                                                          
                                                                      }
                                                                      
        
        
        
    }];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)savaQRCodeImage:(UILongPressGestureRecognizer *)sender
{
    [self stopSthowCircleDown];
    
  if (sender.state == UIGestureRecognizerStateBegan) {
        
        if (isCanSave) {
            
            isCanSave = NO;
            
            [self.navigationController presentViewController:self.alertActions animated:YES completion:nil];
            
            isCanSave = YES;
        }
    }
}

- (UIImage *)screenshotByQRView
{
    self.QRImage.layer.cornerRadius = 0;
    
    UIGraphicsBeginImageContextWithOptions(self.QRImage.frame.size, YES, 0.0);
    [self.QRImage.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.QRImage.layer.cornerRadius = 10;
    
    return image;
}

- (void)configView
{
    [self getQRImage];
    
    
    self.supportLabel.text = [[PayConfig nilStr:[[PayConfig getUserInfo] valueForKey:@"companyName"]] stringByAppendingString:@"提供技术支持服务"];//
    self.phoneLabel.text = [@"客服电话：" stringByAppendingString:[PayConfig nilStr:[[PayConfig getUserInfo] valueForKey:@"servicePhone"]]];//

    if ([_typeString isEqualToString:@"wechat"]) {
        
        
        
        self.logoImage.image = [UIImage imageNamed:@"weixinpaylogo"];
        self.logoImage.frame = CGRectMake(self.logoImage.frame.origin.x, self.logoImage.frame.origin.y, self.logoImage.frame.size.width, self.logoImage.frame.size.width / 182 * 49);
        
        self.remarkLable.text = @"使用微信扫一扫或长按保存相册";
        
    }else{
        
        self.logoImage.image = [UIImage imageNamed:@"alipaylogo"];
        self.logoImage.frame = CGRectMake(self.logoImage.frame.origin.x, self.logoImage.frame.origin.y, self.logoImage.frame.size.width, self.logoImage.frame.size.width / 182 * 64);
        self.remarkLable.text = @"使用支付宝扫一扫或长按打开/保存到相册";
    }
    
    
    self.moneyLable.text  = self.moneyString;
  
}
-(void)getQRImage{
    
    QRCodeCreatView *qrcodeVC = [[QRCodeCreatView alloc]init];
    qrcodeVC.size = 500;
    qrcodeVC.URLString = self.payUrl;
    self.QRImage.image = [qrcodeVC getImgae];
}

- (void)returntoThePreviousPage
{
    [self stopSthowCircleDown];
    [super returntoThePreviousPage];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self stopSthowCircleDown];
    [super viewDidDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self starSthowCircleDown];
    [super viewDidAppear:animated];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
