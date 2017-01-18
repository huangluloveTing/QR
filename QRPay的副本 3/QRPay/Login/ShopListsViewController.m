//
//  ShopListsViewController.m
//  QRPay
//
//  Created by yy on 16/9/19.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "ShopListsViewController.h"
#import "ShopListTableViewCell.h"

@interface ShopListsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong)UITableView *myTableView;

@end

@implementation ShopListsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"商户列表";
    self.navigationItem.leftBarButtonItem = nil;
    [self.view addSubview:self.myTableView];
    // Do any additional setup after loading the view.
}




-(UITableView *)myTableView{
    if (!_myTableView) {
        
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64) style:UITableViewStyleGrouped];
        [_myTableView registerNib:[UINib nibWithNibName:@"ShopListTableViewCell" bundle:nil] forCellReuseIdentifier:@"ShopListTableViewCell"];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        
    }
    
    return _myTableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 30)];
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, kDeviceWidth-10, 20)];
    lable.font = [UIFont systemFontOfSize:13.0];
    lable.textColor = [UIColor darkGrayColor];
    [back addSubview:lable];
    lable.text = @"   请选择商户";
    
    return back;
}



-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 100;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footVC = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 100)];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, 40, kDeviceWidth-40, 40);
    btn.backgroundColor = RGBACOLOR(15, 131, 255, 1);
    btn.layer.cornerRadius = 6;
    [btn setTitle:@"立即进入" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(inputRightNowHandle) forControlEvents:UIControlEventTouchUpInside];
    [footVC addSubview:btn];
    
    return footVC;
    
}


-(void)inputRightNowHandle
{
    [self changeRootViewController];
}


- (void)changeRootViewController
{
    
    WEAKSELF
    
    [UIView animateWithDuration:.3 animations:^{
        
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        weakSelf.view.transform=CGAffineTransformMakeScale(.001f, .001f);
        
    } completion:^(BOOL finished) {
        
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        RootViewController*rootVC = [[RootViewController alloc]init];
        rootVC.selectedIndex = 0;
        window.rootViewController = rootVC;
        weakSelf.view.transform=CGAffineTransformMakeScale(1.f, 1.f);
        
    }];
}





-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopListTableViewCell"];
    //    cell.CarModels = _dataArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
@end
