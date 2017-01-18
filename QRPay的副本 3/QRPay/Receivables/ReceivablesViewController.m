//
//  ReceivablesViewController.m
//  QRPay
//
//  Created by yy on 16/9/18.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "ReceivablesViewController.h"
#import "ShopListsViewController.h"
#import "PayViewController.h"
#import "ReceivablesHeaderView.h"
#import "PayConfig.h"
#import "QRContainerView.h"

#import "MyTouchId.h"
#import "ScanQRViewController.h"
#import "BindShopperOrPartnerViewController.h"


@interface ReceivablesViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic , strong)YYNumberKeyboard *numboards;

@property (nonatomic , strong)ReceivablesHeaderView *topView;

@property (nonatomic ,strong) QRContainerView *containerView;
@end

@implementation ReceivablesViewController

#pragma  mark -- Ovveride Method
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    self.titleLabel.text = @"收款";

    [self.view addSubview:self.numboards];
    [self.view addSubview:self.topView];

}

- (NSArray *) loaddatas {
    NSMutableArray *modelDatas = [NSMutableArray array];
    for (int i = 0 ;  i < 4 ; i ++) {
        
        UIImage *placeholderImage = [UIImage imageNamed:@"wei"];
        
        [modelDatas addObject:placeholderImage];
    }
    
    return [NSArray arrayWithArray:modelDatas];
}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSString *tipsTitles = [NSString stringWithFormat:@"  日期：%@          收款卡：%@",[PayConfig getCurrentDate],[PayConfig nilStr: [[PayConfig getUserInfo] valueForKey:@"bankAccountNo"] ]];
    
    self.topView.tipsTitle = tipsTitles;
}

#pragma mark -- Private Method

- (void)chooseShopList
{
    
    ShopListsViewController *vc = [[ShopListsViewController alloc]init];
    UINavigationController *slVC = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.navigationController presentViewController:slVC animated:YES completion:nil];
}

#pragma mark -- Private property GetMethod

-(ReceivablesHeaderView *)topView
{
    if (!_topView) {
        CGFloat heightt = kDeviceWidth*280/320+64;
        
        _topView = [[ReceivablesHeaderView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-heightt-49)];
        WEAKSELF
        _topView.AddClickIndexBlock = ^(){
            [weakSelf addRemarkBtnHandel];
        };
        
        _topView.tapAboutQRBtnBlock = ^(CGPoint point) {
            NSLog(@"tap top");
            
//            CGPoint covertPoint = [weakSelf.topView convertPoint:point toView:weakSelf.view];
//            ChooseReceiveTypeViewController *chooseVC = [[ChooseReceiveTypeViewController alloc] init];
//            
//            CGRect frame = CGRectMake(covertPoint.x , covertPoint.y + 64, 120, 120 / 4 * 3);
//            NSLog(@"x=%f,y=%f,width = %f,height= %f",frame.origin.x,frame.origin.y,frame.size.width,frame.size.height);
//            chooseVC.presentedFrame = CGRectMake(covertPoint.x , covertPoint.y + 64, 120, 120 / 4 * 3);
//            chooseVC.models = [weakSelf getQRModels];
//            
//            [weakSelf presentViewController:chooseVC animated:YES completion:nil];
            
//            MyTouchId *VC = [[MyTouchId alloc] init];
//            
//            [VC comfirmTouchId];
            
            ScanQRViewController *scanQRVC = [[ScanQRViewController alloc] init];
            
            scanQRVC.hidesBottomBarWhenPushed = YES;
            
            [weakSelf.navigationController pushViewController:scanQRVC animated:YES];
        };
    }
    return _topView;
}

- (QRContainerView *)containerView {
    if (!_containerView) {
        _containerView = [[QRContainerView alloc] initWithFrame:CGRectMake(0, 0, 120, 110) andModels:[self getQRModels]];
        
        _containerView.backgroundColor = [UIColor whiteColor];
    }
    
    return _containerView;
}

-(YYNumberKeyboard *)numboards
{
    if (!_numboards) {
        
        _numboards = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([YYNumberKeyboard class]) owner:self options:nil].lastObject;
        CGFloat heightt = kDeviceWidth*280/320+64;
        _numboards.resultStr = @"￥0.00";
        _numboards.clickPoint = NO;
        _numboards.delegate = self;
        _numboards.layer.borderWidth = 1;
        _numboards.layer.borderColor = RGBACOLOR(200, 200, 200, 200).CGColor;
        _numboards.frame =CGRectMake(-1, kDeviceHeight-49-heightt, kDeviceWidth+2, heightt);
    }
    return _numboards;
}


#pragma mark -- init Data

- (NSArray *) getQRModels {
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < 3; i ++ ) {
        CustomModel *model = [CustomModel new];
        
        model.title = [NSString stringWithFormat:@"这是%d第个title",i];
        model.image = [UIImage imageNamed:@"qrdemo"];
        
        [arr addObject:model];
    }
    
    return [NSArray arrayWithArray:arr];
}

#pragma mark -- Private method

//添加收款备注
-(void)addRemarkBtnHandel
{
    NSLog(@"添加收款备注");
    YYAlertsView *vc = [[YYAlertsView alloc]initWithTitle:@"提示" placeholder:@"请输入收款备注" cancelBtnTitle:@"取消" otherBtnTitle:@"确定"];
    [vc showYYAlertView];
    
    vc.YYAlertInputClick = ^(NSString *notes){

        _topView.remarkLable.text = notes;
        
    };
}

//添加maskView
- (void) addMaskViewInWindow {
    
}

#pragma mark ---  YYNumberKeyboardDelegate ---

-(void)getResultMoneyString:(NSString *)moneyStr
{
    _topView.moneyLable.text = moneyStr;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
 
    
}
-(void)getSureBtnTypeString:(NSString *)typeStr
{
     NSString *money = nil;
    
    NSString *typeMaxAmount =  [typeStr isEqual:@"alipay"]  ? @"maxAmountAlipay" :@"maxAmountWechat";
    NSString *typeMinAmount =  [typeStr isEqual:@"alipay"]  ? @"minAmountAlipay" :@"minAmountWechat";
    
    if ([PayConfig getUserAuthority] == 6 || [PayConfig getUserAuthority] == 7) {
        if (_topView.moneyLable.text) {
            
            money= [_topView.moneyLable.text substringFromIndex:1];
            
            CGFloat maxAmount  = [[[PayConfig getUserInfo] valueForKey:typeMaxAmount] floatValue];
            CGFloat minAmount  = [[[PayConfig getUserInfo] valueForKey:typeMinAmount] floatValue];
            
            NSLog(@"max = %f,min = %f",maxAmount,minAmount);
            
            if ([money floatValue] <= minAmount) {
                
                [[[UIAlertView alloc] initWithTitle:@"提醒" message:@"输入的金额过小" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
                
            }else if([money floatValue] > maxAmount){
                
                [[[UIAlertView alloc] initWithTitle:@"提醒" message:@"输入的金额过大" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
                
            }else{
                WEAKSELF
                
                [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
                [netAPI getGeneralInfoInterfaceCode:@"orderCreate" Business:@{
                                                                              @"customerNo":[PayConfig nilStr:[[PayConfig getUserInfo] valueForKey:@"customerNo"]],
                                                                              @"amount": [NSString stringWithFormat:@"%.f",[money floatValue] * 100],
                                                                              @"type":   typeStr}
                 
                                              block:^(ReturnListModel *listing) {
                                                  
                                                  [MBProgressHUD hideAllHUDsForView:self.view.window animated:YES];
                                                  
                                                  
                                                  if ([listing.getErrorCode isEqual:@"00"]) {
                                                      
                                                      PayViewController *vc = [[PayViewController alloc]init];
                                                      vc.hidesBottomBarWhenPushed = YES;
                                                      vc.titleLabel.text = [typeStr isEqual:@"alipay"]  ? @"支付宝支付" : @"微信支付";
                                                      vc.moneyString  = _topView.moneyLable.text;
                                                      vc.typeString = typeStr;
                                                      vc.payUrl =  [listing.getResponseDictionary valueForKey:@"codeUrl"];
                                                      vc.orderid =  [listing.getResponseDictionary valueForKey:@"orderId"];
                                                      vc.remarkString = weakSelf.topView.remarkLable.text;
                                                      [weakSelf.navigationController pushViewController:vc animated:YES];
                                                      
                                                  }else{
                                                      
                                                      [MBProgressHUD showError:listing.getErrorMsg toView:weakSelf.view];
                                                      
                                                  }
                                                  
                                              }];
            }
        }
    }
    
    else {
        
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"你还没有绑定商户\n是否去绑定已有商户？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action_cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertAction *action_register = [UIAlertAction actionWithTitle:@"去绑定商户" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"绑定商户");
            BindShopperOrPartnerViewController *bindVC = [[BindShopperOrPartnerViewController alloc] init];
            bindVC.actionType = action_BindShopper;
            [self presentViewController:bindVC animated:YES completion:^{
                
            }];
            
        }];
        
        [alertVC addAction:action_cancel];
        [alertVC addAction:action_register];
        
        [self presentViewController:alertVC animated:YES completion:^{
            
        }];
    }

    
}





@end
