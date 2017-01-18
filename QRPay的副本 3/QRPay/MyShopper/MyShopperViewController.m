//
//  MyShopperViewController.m
//  QRPay
//
//  Created by 黄露 on 2016/11/26.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "MyShopperViewController.h"


#import "PayConfig.h"

@interface MyShopperViewController ()

@end

@implementation MyShopperViewController

- (instancetype) init {
    if (self = [super init]) {
        self.tableViewStyle = UITableViewStyleGrouped;
        self.isShowSearchView = NO;
        self.ishaveRefresh = YES;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.frame = CGRectMake(0, VIEW_MAXY(self.chooseBtnView), WIDTH_VIEW(self.tableView), HEIGHT_VIEW(self.tableView) - VIEW_MAXY(self.chooseBtnView));
    
    [self.view addSubview:self.chooseBtnView];
    self.navigationItem.leftBarButtonItem = self.leftBarButton;
    self.titleLabel.text = @"我的商户";
}

- (MyShopperChooseBtnView *) chooseBtnView {
    if (!_chooseBtnView) {
        _chooseBtnView = [[MyShopperChooseBtnView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_VIEW(self.view), 35) andTitles:@[@"已开通",@"审核中",@"拒绝"]];
        
        _chooseBtnView.tapedChooseBtnBlock = ^(NSInteger tag) {
            NSLog(@"tag : %ld",tag);
        };
    }
    
    return _chooseBtnView;
}


#pragma mark -- UITableView Delegate and Datasource

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
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


@end
