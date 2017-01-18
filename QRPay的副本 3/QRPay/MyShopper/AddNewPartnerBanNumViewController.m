//
//  AddNewPartnerBanNumViewController.m
//  QRPay
//
//  Created by 黄露 on 2016/11/28.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "AddNewPartnerBanNumViewController.h"

#import "TableViewFooterTipsView.h"

@interface AddNewPartnerBanNumViewController ()

@end

@implementation AddNewPartnerBanNumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = @"新增合伙人";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_VIEW(self.view), 200)];
    footer.backgroundColor = [UIColor clearColor];
    
    TableViewFooterTipsView *tipsView = [[TableViewFooterTipsView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_VIEW(footer), 120)];
    
    tipsView.backgroundColor = [UIColor clearColor];
    
    [footer addSubview:tipsView];
    
    UIButton *footBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    footBtn.frame = CGRectMake(10, VIEW_MAXY(tipsView), WIDTH_VIEW(footer) - 20, 40);
    
    footBtn.layer.cornerRadius = 5;
    
    footBtn.backgroundColor = [UIColor blueColor];
    [footBtn setTitle:@"提交" forState:UIControlStateNormal];
    
    [footBtn addTarget:self action:@selector(submitBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [footer addSubview:footBtn];
    
    return footer;
}

- (void) submitBtnAction {
    NSLog(@"submit");
}

@end
