//
//  MyPartnerDetailViewController.m
//  QRPay
//
//  Created by 黄露 on 2016/11/28.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "MyPartnerDetailViewController.h"
#import "MyPartnerDetailHeaderView.h"
#import "MyPartnerOrderListViewController.h"

@interface MyPartnerDetailViewController ()

@property (nonatomic ,strong) MyPartnerDetailHeaderView *headerView;

@end

@implementation MyPartnerDetailViewController

- (instancetype) init {
    if (self = [super init]) {
        self.tableViewStyle = UITableViewStyleGrouped;
        self.ishaveRefresh = YES;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = TABLEVIEW_GROUPED_BGCOLOR;
    self.fd_prefersNavigationBarHidden = YES;
    [self.view addSubview:self.headerView];
    CGRect tableFrame = self.tableView.frame;
    tableFrame.origin.y = VIEW_MAXY(self.headerView) + 10;
    tableFrame.size.height = CGRectGetHeight([UIScreen mainScreen].bounds) - HEIGHT_VIEW(self.headerView)-10;
    
    self.tableView.frame = tableFrame;
    
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
}

- (MyPartnerDetailHeaderView *) headerView {
    if (!_headerView) {
        _headerView = [[MyPartnerDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_VIEW(self.view), WIDTH_VIEW(self.view) /2 + 90)];
        _headerView.tradesArr = @[@"190",@"2340.00",@"56"];
        
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftBtn setBackgroundImage:[UIImage imageNamed:@"xiangzuojiantou"] forState:UIControlStateNormal];
        leftBtn.frame = CGRectMake(10, 30, 22, 22);
        [leftBtn addTarget:self action:@selector(LeftBtnPressAction) forControlEvents:UIControlEventTouchUpInside];
        [_headerView addSubview:leftBtn];
    }
    
    return _headerView;
}

#pragma mark -- UITableView Delegate and Datasource

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        MyShopperTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shopCell" forIndexPath:indexPath];
        
        cell.headerPlaceImage = [UIImage imageNamed:@"tab_user_h"];
        cell.shopName = @"小海玩具店";
        cell.registerTime = [PayConfig getCurrentDate];
        cell.totalAccount = @"";
        return cell;
    }
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MyPartnerOrderListViewController *listVC = [[MyPartnerOrderListViewController alloc] init];
    
    [self.navigationController pushViewController:listVC animated:YES];
}

- (void) LeftBtnPressAction {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
