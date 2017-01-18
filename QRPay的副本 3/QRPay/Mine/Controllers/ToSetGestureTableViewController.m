//
//  ToSetGestureTableViewController.m
//  QRPay
//
//  Created by 黄露 on 2016/11/24.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "ToSetGestureTableViewController.h"
#import "ToSetGestureTableViewCell.h"
#import "SetGestureLockViewController.h"

@interface ToSetGestureTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UITableView *tableView;

@end

@implementation ToSetGestureTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = @"手势锁";
    self.navigationItem.leftBarButtonItem = self.leftBarButton;

    [self.view addSubview:self.tableView];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.tableView reloadData];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
         [_tableView registerClass:[ToSetGestureTableViewCell class] forCellReuseIdentifier:@"tosetguesture"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    
    return _tableView;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    if(!cell) {
        ToSetGestureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tosetguesture" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSLog(@"passwordSetupStatus = %d",[DBGuestureLock passwordSetupStatus])
        cell.switchView.on = [DBGuestureLock passwordSetupStatus];
        
        WEAKSELF
        [cell setSwitchValueChangeBlock:^(UISwitch *switchBtn) {
            
            if (!switchBtn.on) {
                SetGestureLockViewController *guestureVC = [[SetGestureLockViewController alloc] init];
                
                guestureVC.setType = ToClearGuesture;
                
                [weakSelf.navigationController pushViewController:guestureVC animated:YES];
            }
            else {
                SetGestureLockViewController *guestureVC = [[SetGestureLockViewController alloc] init];
                
                guestureVC.setType = ToSetGuesture;
                
                [weakSelf.navigationController pushViewController:guestureVC animated:YES];
            }
        }];
        return cell;
        
    }
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 20;
}

@end
