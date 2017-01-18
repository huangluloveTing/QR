//
//  MyPartnerViewController.m
//  QRPay
//
//  Created by 黄露 on 2016/11/28.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "MyPartnerViewController.h"
#import "MyPartnerModel.h"
#import "AddNewPartnerViewController.h"

#import "MyPartnerDetailViewController.h"

@interface MyPartnerViewController ()
{
    NSMutableArray *models;
}

@end

@implementation MyPartnerViewController

- (instancetype) init {
    if (self = [super init]) {
        self.isShowSearchView = NO;
        self.tableViewStyle = UITableViewStyleGrouped;
        self.ishaveRefresh = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = @"我的合伙人";
    
    self.navigationItem.rightBarButtonItem = self.rightBarButton;
    
    models = [NSMutableArray array];
    
    for (int i = 0 ; i < 10 ; i ++) {
        /**
         
         @property (nonatomic ,copy) NSString *partnerName;
         
         @property (nonatomic ,copy) NSString *partnerPhone;
         
         @property (nonatomic ,assign) CGFloat yesterdayTradeCount;
         
         @property (nonatomic ,assign) NSInteger newShopper;
         */
        MyPartnerModel *model = [MyPartnerModel new];
        model.partnerName = [NSString stringWithFormat:@"商户%d",i];
        model.partnerPhone = [NSString stringWithFormat:@"%d" ,arc4random() % 100000];
        
        model.yesterdayTradeCount = arc4random() % 100;
        model.newShopper = arc4random() % 130;
        
        [models addObject:model];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- TableView Delegate and Datasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        MyPartnerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myshopper" forIndexPath:indexPath];
        
        MyPartnerModel *model = models[indexPath.row];
        
        cell.partnerName = model.partnerName;
        cell.partnerPhone = model.partnerPhone;
        cell.yesterdayTradeCount = model.yesterdayTradeCount;
        cell.newShopper = model.newShopper;
        
        return cell;
    }
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MyPartnerDetailViewController *detailVC = [[MyPartnerDetailViewController alloc] init];
    
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (NSInteger ) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return models.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1f;
}

- (void) rightBarButtonHandle {
    AddNewPartnerViewController *addParnetVC = [[AddNewPartnerViewController alloc] init];
    
    [self.navigationController pushViewController:addParnetVC animated:YES];
}



@end
