//
//  MYPartnerOrderListViewController.m
//  QRPay
//
//  Created by 黄露 on 2016/11/29.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "MyPartnerOrderListViewController.h"
#import "MyPartnerOrderListTableViewCell.h"
#import "MypartnerListDetailViewController.h"

@interface MyPartnerOrderListViewController ()

@end

@implementation MyPartnerOrderListViewController

- (instancetype) init {
    if (self =[super init]) {
        self.tableViewStyle = UITableViewStyleGrouped;
        
        [self.tableView registerClass:[MyPartnerOrderListTableViewCell class] forCellReuseIdentifier:@"orderList"];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        NSLog(@"refresh");
        [self.tableView.mj_header endRefreshing];
    }];
    
    self.titleLabel.text = @"订单列表";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- TableView Delegate and Datasource

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.1f;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        MyPartnerOrderListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderList" forIndexPath:indexPath];
        
        cell.orderId = @"JJH87682642462946296";
        cell.orderTime = [PayConfig getCurrentDate];
        cell.percent = 0.25;
        
        return cell;
    }
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MypartnerListDetailViewController *listDetailVC = [[MypartnerListDetailViewController alloc] init];
    
    MyPartnerListModel *model = [MyPartnerListModel new];
    
    model.orderId = @"HJG767698698698768699689";
    model.partnerId = @"007";
    model.salerId = @"009";
    model.rate = 0.34;
    model.bankOrderId = @"696926295678892JH";
    model.money = 120.5;
    model.tradeTime = [PayConfig getCurrentDate];
    model.payResultStatus = Pay_Success;
    listDetailVC.listModel = model;
    
    [self.navigationController pushViewController:listDetailVC animated:YES];
}


@end
