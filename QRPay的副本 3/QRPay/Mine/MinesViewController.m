//
//  MinesViewController.m
//  QRPay
//
//  Created by yy on 16/9/20.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "MinesViewController.h"
#import "ToSetGestureTableViewController.h"


#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDKUI.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>

#import "SendCodeTableViewCell.h"

@interface MinesViewController ()
{
    CGFloat headerHeight;
    NSArray *itemArray;
    NSArray *dataArray;
}

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic , strong) MineHeaderView *herdarviews;


@end

@implementation MinesViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    
    headerHeight = 190;
    itemArray = @[
                  @[@"手势锁",@"清理缓存",@"致电客服"],
                  @[@"用户须知",@"帮助中心",@"关于我们"],
                  @[[@"版本信息 V" stringByAppendingString:VERSION], @"分享注册"]
                  ];
    
    dataArray = @[
                  @[@"gesture",@"cleanhc",@"phonecall"],
                  @[@"yonghuxuzhi",@"helper",@"aboutus"],
                  @[@"banben",@"fenxiang"]
                ];
    
    [self.view addSubview:self.myTableView];

}



-(UITableView *)myTableView{
    if (!_myTableView) {
        
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-49) style:UITableViewStyleGrouped];
        _myTableView.contentInset = UIEdgeInsetsMake(headerHeight, 0, 0, 0);//设置tableview的contentInset属性
        _myTableView.showsVerticalScrollIndicator = NO;
        
        [_myTableView registerNib:[UINib nibWithNibName:@"MineTableViewCell" bundle:nil] forCellReuseIdentifier:@"MineTableViewCell"];
        [_myTableView registerClass:[SendCodeTableViewCell class] forCellReuseIdentifier:@"send"];
        _myTableView.showsHorizontalScrollIndicator = NO;
        
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        [_myTableView addSubview:self.herdarviews];
        
    }
    
    return _myTableView;
}


-(MineHeaderView *)herdarviews
{
    if (!_herdarviews) {
        CGRect bounds = CGRectMake(0, -headerHeight, kDeviceWidth, headerHeight);
        _herdarviews = [[MineHeaderView alloc] initWithFrame:bounds];
        _herdarviews.layer.masksToBounds = YES;
        _herdarviews.userInteractionEnabled = YES;
        _herdarviews.clipsToBounds = YES;
        _herdarviews.autoresizesSubviews = YES;
        _herdarviews.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        _herdarviews.image = [UIImage imageNamed:@"bottomImage"];
        _herdarviews.contentMode = UIViewContentModeScaleAspectFill;
        WEAKSELF
        _herdarviews.clickHeaderImageHandle = ^(){
            MyInfoViewController *vc = [[MyInfoViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:vc animated:YES];
            
        };
        
        
    }
    return _herdarviews;
}



#pragma mark =======uitableviewdelegate  uitabledatasource=========
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return itemArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == itemArray.count) {
        return 1;
        
    }
    else {
    
        NSArray *ARR = [NSArray arrayWithArray:itemArray[section]];
        return ARR.count;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0){
        return 0.01;
    }else{
        return 10;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == itemArray.count - 1) {
        return 60;
    }else{
        return 0.01;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == itemArray.count - 1) {
        UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 60)];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(20, 30, kDeviceWidth-40, 40);
        btn.backgroundColor = RGBACOLOR(15, 131, 255, 1);
        btn.layer.cornerRadius = 6;
        btn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [btn setTitle:@"退  出" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(quiteHandle) forControlEvents:UIControlEventTouchUpInside];
        [back addSubview:btn];
        
        return back;
    }else{
        return nil;
    }
}


//退出操作
-(void)quiteHandle
{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定退出当前帐号？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSUserDefaults *mySetting = [NSUserDefaults standardUserDefaults];
        [mySetting removeObjectForKey:@"USER_INFO"];
        [mySetting synchronize];
        
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        UINavigationController*loginNC = [[UINavigationController alloc]initWithRootViewController:loginVC];
        window.rootViewController = loginNC;
    }];
    
    [alertVc addAction:action1];
    [alertVc addAction:action2];
    
    [self presentViewController:alertVc animated:YES completion:nil];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineTableViewCell"];
    
    cell.titleLable.text = itemArray[indexPath.section][indexPath.row];

    cell.titleImage.image = [UIImage imageNamed:dataArray[indexPath.section][indexPath.row]];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offset_Y = scrollView.contentOffset.y;
    //    CGFloat alpha = (offset_Y + 40)/100.0f;
    //    self.backView.backgroundColor = [self.backColor colorWithAlphaComponent:alpha];
    CGFloat offsetH = headerHeight + offset_Y;
    if (offset_Y < -headerHeight) {
        //放大比例
        CGRect frame = _herdarviews.frame;
        frame.size.height = headerHeight - offsetH;//下拉后图片的高度应变大
        frame.origin.y = -headerHeight + offsetH;//
        _herdarviews.frame = frame;
    }
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 1) {
                //清理缓存
                [self clearCaces];
                
            }else if(indexPath.row == 2){
                
                //致电客服
//                UIWebView * callWebview = [[UIWebView alloc] init];
//                [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", [UPConfig getTelephone]]]]];
//                [self.view addSubview:callWebview];

                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",[UPConfig getTelephone]]]];
                
            }else if (indexPath.row == 0) {
                ToSetGestureTableViewController *guesture = [[ToSetGestureTableViewController alloc] init];
                guesture.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:guesture animated:YES];
            }
            
            break;
            
        case 1:
            if (indexPath.row == 0) {
//                AboutUSViewController *vc = [[AboutUSViewController alloc]init];
//                vc.hidesBottomBarWhenPushed = YES;
//                [self.navigationController pushViewController:vc animated:YES];
            }
            break;
            
        case 2:
            
            if (indexPath.row == 1) {
                
                NSMutableDictionary *params = [NSMutableDictionary dictionary];
                
                UIImage *image = [UIImage imageNamed:@"morefuction_2"];
                
                
                [params SSDKSetupShareParamsByText:@"分享" images:image url:[NSURL URLWithString:@""] title:@"title" type:SSDKContentTypeAuto];
                
                [params SSDKSetupWeChatParamsByText:@"微信分享" title:@"title" url:[NSURL URLWithString:@""] thumbImage:image image:image musicFileURL:nil extInfo:nil fileData:nil emoticonData:nil type:SSDKContentTypeAuto forPlatformSubType:SSDKPlatformSubTypeWechatSession];
                
                [ShareSDK share:SSDKPlatformSubTypeWechatSession parameters:params onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
                    switch (state) {
                        case SSDKResponseStateSuccess:
                            NSLog(@"success");
                            break;
                            
                        default:
                            break;
                    }
                }];
            }
            
        default:
            break;
    }
    
}


- (void)clearCaces
{
    
    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"本次将清理%.2fM缓存,是否继续?",[PayConfig getCachesSize]] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self sureClearCaches];
    }];
    
    [alertView addAction:action1];
    [alertView addAction:action2];
                                     
    [self presentViewController:alertView animated:YES completion:^{
        
    }];
    
}


- (void) sureClearCaches
{

    [PayConfig clearCaches];
        
}

- (void) showSharedUIWithParams:(NSMutableDictionary *)params {
    
    [SSUIShareActionSheetStyle setActionSheetColor:[UIColor whiteColor]];
    [SSUIShareActionSheetStyle setActionSheetBackgroundColor:[TABLEVIEW_GROUPED_BGCOLOR colorWithAlphaComponent:0.7]];
    [SSUIShareActionSheetStyle setCancelButtonLabelColor:[UIColor blueColor]];
    
    [SSUIShareActionSheetStyle setItemNameColor:[UIColor blackColor]];
    
    [ShareSDK showShareActionSheet:self.view  items:@[@(SSDKPlatformSubTypeWechatTimeline),@(SSDKPlatformSubTypeWechatSession),@(SSDKPlatformTypeWechat)] shareParams:params onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
        
        switch (state) {
            case SSDKResponseStateBegin:
                NSLog(@"begin");
                break;
                
            case SSDKResponseStateSuccess:
                NSLog(@"sucess");
                break;
                
            case SSDKResponseStateFail:
                NSLog(@"failed");
                break;
                
            case SSDKResponseStateCancel:
                NSLog(@"cancel");
                break;
                
            default:
                break;
        }
    }];
}

@end
