//
//  MyShareFeeViewController.m
//  QRPay
//
//  Created by 黄露 on 2016/11/28.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "MyShareFeeViewController.h"
#import "MyShareFeeModel.h"

@interface MyShareFeeViewController ()

@end

@implementation MyShareFeeViewController {
    NSMutableArray *datas;
}

- (instancetype) init {
    if (self = [super init]) {
        self.tableViewStyle = UITableViewStyleGrouped;
        self.ishaveRefresh = YES;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = @"我的分润";
    
    datas = [NSMutableArray array];
    for (int i = 0; i < 3 ; i ++) {
        MyShareFeeModel *model = [MyShareFeeModel new];
        model.headImage = [UIImage imageNamed:@"xuanze"];
        model.nameStr = [NSString stringWithFormat:@"这是名称 %d",i];
        model.timeStr = [PayConfig getCurrentDate];
        model.percent = 0.34;
        
        [datas addObject:model];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark -- TableView Delegate and Datasource

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        MyShareFeeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sharefee" forIndexPath:indexPath];
        
        MyShareFeeModel *model = datas[indexPath.row];
        
        cell.headImage = model.headImage;
        cell.nameStr = model.nameStr;
        cell.timeStr = model.timeStr;
        cell.sharePercent = model.percent;
        
        return cell;
    }
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.1f;
}

@end
