//
//  OrdersViewController.m
//  QRPay
//
//  Created by yy on 16/9/18.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "OrdersViewController.h"
#import "YYTopNavigateionBtn.h"
#import "MJRefresh.h"
@interface OrdersViewController ()<YYTopNavigationBtnDelegate>
{
    NSString *payType;
    NSInteger currentPage;
    
}
@property (nonatomic , strong)UITableView *myTableView;
@property (nonatomic , strong)UIView *totalView;
@property (nonatomic , strong)UILabel *todayLable;
@property (nonatomic , strong)UILabel *monthLbale;
@property (nonatomic , strong)YYTopNavigateionBtn *navigationBtn;
@property (nonatomic , strong)UIView* bottomView;

@property (nonatomic, strong) NSMutableArray *dataArray;


@end
static CGFloat height = 50.;
@implementation OrdersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = @"订单记录";
    [self.view addSubview:self.totalView];
    [self.view addSubview:self.navigationBtn];
    [self.view addSubview:self.myTableView];
    self.dataArray = [NSMutableArray array];
    payType = @"wechat"; //wechat
    currentPage = 1;
    self.navigationItem.leftBarButtonItem = self.leftBarButton;
    
    [self setUpRefresh];

}


- (UIView *)bottomView
{
    if (!_bottomView) {
        
//        CGFloat height = 50.;
        CGFloat width = kDeviceWidth - 40.;
        
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, height)];
        _bottomView.backgroundColor = [UIColor clearColor];
        
        UILabel *leftline = [[UILabel alloc]initWithFrame:CGRectMake(20, height/2-0.5, width/3, 1)];
        leftline.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.3];
        [_bottomView addSubview: leftline ];
        
        UILabel *center = [[UILabel alloc]initWithFrame:CGRectMake(width/3 - 20 , height/2-10, width/3, 20)];
        center.font = [UIFont systemFontOfSize:12.];
        center.textColor = [UIColor colorWithWhite:0.1 alpha:0.4];
        center.text = @"我是有底线的";
        center.textAlignment = NSTextAlignmentCenter;
        
        center.center  =CGPointMake(kDeviceWidth / 2 , height / 2);
        [_bottomView addSubview: center ];
        
        UILabel *rightline = [[UILabel alloc]initWithFrame:CGRectMake(width/3 * 2 + 20, height/2-0.5, width/3, 1)];
        rightline.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.3];
        [_bottomView addSubview: rightline ];
        
        
        
        
    }
    
    return _bottomView;
}


- (void)getDataByPage
{
    
    [MBProgressHUD hideHUDForView:self.view.window animated:YES];
    [MBProgressHUD showMessag:@"" toView:self.view.window afterDelay:30.];
    
    WEAKSELF
    [netAPI getGeneralInfoInterfaceCode:@"orderQuery" Business:@{
                                                                 @"customerNo":[PayConfig nilStr:[[PayConfig getUserInfo] valueForKey:@"customerNo"]],
                                                                 @"currentPage": [NSString stringWithFormat:@"%ld",currentPage],
                                                                 @"type":   payType,
                                                                 @"pageSize":   @"10"
                                                                 } block:^(ReturnListModel *listing) {
                                                                     
                                                                     [weakSelf.myTableView.mj_header endRefreshing];
                                                                     [weakSelf.myTableView.mj_footer endRefreshing];
                                                                     [MBProgressHUD hideHUDForView:weakSelf.view.window animated:YES];
                                                                     
                                                                     
                                                                     
                                                                     if([listing.getErrorCode isEqualToString:@"00"]){
                                                                         
                                                                         
                                                                         if (currentPage == 1) {
                                                                             [weakSelf.self.dataArray removeAllObjects];
                                                                             [self.myTableView scrollsToTop];
                                                                         }
                                                                         
                                                                         
                                                                         weakSelf.todayLable.text = [PayConfig nilStr:[listing.getResponseDictionary objectForKey:@"todayAmount"]];
                                                                         weakSelf.monthLbale.text = [PayConfig nilStr:[listing.getResponseDictionary objectForKey:@"monthAmount"]];
                                                                         
                                                                         [weakSelf.dataArray addObjectsFromArray:[listing.getResponseDictionary objectForKey:@"list"]];
                                                                         
                                                                         [weakSelf.nullDataView removeFromSuperview];
                                                                         
                                                                         if (![weakSelf.myTableView.mj_footer superview]) {
                                                                             [weakSelf setFooterRefresh];
                                                                         }
                                                                         
                                                                         
                                                                     }else{
                                                                         
                                                                         [weakSelf.myTableView.mj_footer removeFromSuperview];
                                                                         
                                                                         if (currentPage != 1) {
                                                                             currentPage--;
                                                                         }
                                                                         
                                                                         if (weakSelf.dataArray.count == 0) {
                                                                             
                                                                             [weakSelf.myTableView addSubview:weakSelf.nullDataView];
                                                                             
                                                                         }else{
                                                                             
                                                                             [weakSelf.nullDataView removeFromSuperview];
                                                                         }
                                                                     }
                                                                     
                                                                     [weakSelf.myTableView reloadData];
                                                                     
        
    }];
}

-(UIView *)totalView {
    
    if (!_totalView) {
        _totalView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 65)];
        
        CGFloat widths = kDeviceWidth/2;
        
        _todayLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, widths, 25)];
        _todayLable.text = @"0.0";
        _todayLable.textAlignment = NSTextAlignmentCenter;
        _todayLable.font = [UIFont systemFontOfSize:19.0];
        _todayLable.textColor = [UIColor blackColor];
        [_totalView addSubview:_todayLable];
        
        UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(0, VIEW_MAXY(_todayLable)+5, widths, 15)];
        lab1.textAlignment = NSTextAlignmentCenter;
        lab1.text = @"今日交易额";
        lab1.textColor = [UIColor lightGrayColor];
        lab1.font = [UIFont systemFontOfSize:13.0];
        [_totalView addSubview:lab1];
        
        UILabel *lin = [[UILabel alloc]initWithFrame:CGRectMake(widths, 12.5, 1, 45)];
        lin.backgroundColor = [UIColor lightGrayColor];
        [_totalView addSubview:lin];
        
        
        _monthLbale = [[UILabel alloc]initWithFrame:CGRectMake(widths, 10, widths, 25)];
        _monthLbale.text = @"0.0";
        _monthLbale.textAlignment = NSTextAlignmentCenter;
        _monthLbale.font = [UIFont systemFontOfSize:19.0];
        _monthLbale.textColor = [UIColor blackColor];
        [_totalView addSubview:_monthLbale];
        
        UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(widths, VIEW_MAXY(_monthLbale)+5, widths, 15)];
        lab2.textAlignment = NSTextAlignmentCenter;
        lab2.text = @"本月交易额";
        lab2.textColor = [UIColor lightGrayColor];
        lab2.font = [UIFont systemFontOfSize:13.0];
        [_totalView addSubview:lab2];
        
        
        UILabel *lin2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 64.5, kDeviceWidth, 0.5)];
        lin2.backgroundColor = [UIColor lightGrayColor];
        [_totalView addSubview:lin2];
        
    }
    return _totalView;
    
}

-(YYTopNavigateionBtn *)navigationBtn
{
    if (!_navigationBtn) {
        NSArray *arr = @[@"微信",@"支付宝"];
        _navigationBtn = [[YYTopNavigateionBtn alloc]initWithFrame:CGRectMake(0, VIEW_MAXY(_totalView), kDeviceWidth, 40) withTitle:arr];
        _navigationBtn.delegate = self;
    }
    
    return _navigationBtn;
}

- (void)navigationBtnClick:(UIButton *)button
{
    if (button.frame.origin.x == 0) {
        payType = @"wechat";
        
    }else{
        
        payType = @"alipay";
    }
    
    
    currentPage = 1;
    [self getDataByPage];
    
}

-(UITableView *)myTableView{
    
    if (!_myTableView) {
        
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, VIEW_MAXY(_navigationBtn), kDeviceWidth, kDeviceHeight-164) style:UITableViewStyleGrouped];
        [_myTableView registerNib:[UINib nibWithNibName:@"OrdersTableViewCell" bundle:nil] forCellReuseIdentifier:@"OrdersTableViewCell"];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        
    }
    
    return _myTableView;
}
-(void)setUpRefresh
{
    WEAKSELF
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        currentPage= 1;
        [weakSelf getDataByPage];
    }];
    
    [self.myTableView.mj_header beginRefreshing];
}

- (void)setFooterRefresh
{
    WEAKSELF
    self.myTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        currentPage++;
        [weakSelf getDataByPage];
    }];
  
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 58;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrdersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrdersTableViewCell"];
    //    cell.CarModels = _dataArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self.dataArray.count) {
        
        NSDictionary *data = [self.dataArray objectAtIndex:indexPath.row];
        
        cell.titleLable.text = [payType isEqual:@"alipay"]  ? @"支付宝收款" : @"微信收款";;
        cell.moneyLable.text = [data valueForKey:@"amount"];
        cell.timeLable.text = [data valueForKey:@"payTime"];
    }
    
    
    
    return cell;
 
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return self.bottomView;
}


@end
