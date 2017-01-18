//
//  AddNewStoreBankNumViewController.m
//  QRPay
//
//  Created by 黄露 on 2016/11/25.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "AddNewStoreBankNumViewController.h"
#import "TableViewFooterTipsView.h"
#import "UploadRealImageViewController.h"
#import "CustomPickViewController.h"

@interface AddNewStoreBankNumViewController ()<selectedPickerViewDelegate>{
    NSArray *bankInformations;
    NSArray *placeholderArr;
    UploadTableViewCell *tempTapedCell;
}

@end

@implementation AddNewStoreBankNumViewController

- (instancetype) init {
    if (self = [super init]) {
        self.tableViewStyle = UITableViewStyleGrouped;
        self.isShowSearchView = NO;
//        self.tableView.tableFooterView = [[UIView alloc] init];
        tempTapedCell = [UploadTableViewCell new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = self.leftBarButton;
    self.titleLabel.text = @"新增商户";
    bankInformations = @[@"开户银行",@"所在地区",@"开户支行",@"开户名",@"银行卡号"];
    placeholderArr = @[@"点击选择开户行",@"请输入所在地区",@"请输入开户支行",@"请输入开户名",@"请输入银行卡号"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- tableViewDelegate and Datasource


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return bankInformations.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        UploadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"uploadCell" forIndexPath:indexPath];
        cell.markTitle = bankInformations[indexPath.row];
        cell.placeholderStr = placeholderArr[indexPath.row];
        WEAKSELF
        if (indexPath.row < 3) {
            cell.isShowKeyboard = NO;
            cell.PressTextFieldBlock = ^(UploadTableViewCell *loadCell) {
                
                tempTapedCell = loadCell;
                
                CustomPickViewController *pickVC = [[CustomPickViewController alloc] init];
                
                pickVC.delegate = self;
                
                [weakSelf presentViewController:pickVC animated:YES completion:^{
                    
                }];
            };
        }
        
        else {
            cell.isShowKeyboard = YES;
        }
        if (indexPath.row == bankInformations.count - 1) {
            cell.keyBoardType = UIKeyboardTypeNumberPad;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
   
    
    return cell;
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
    [footBtn setTitle:@"下一步" forState:UIControlStateNormal];
    
    [footBtn addTarget:self action:@selector(toUploadRealImage) forControlEvents:UIControlEventTouchUpInside];
    
    [footer addSubview:footBtn];
    
    return footer;
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 210;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

#pragma mark -- Custom selectedPickerViewDelegate

- (void) selectedPickerViewWithTitle:(NSString *)title {
    
    if (title) {
        tempTapedCell.contentString = title;
    }
}

- (void) toUploadRealImage {
    
    UploadRealImageViewController *uploadImageVC = [[UploadRealImageViewController alloc] init];
    
    [self.navigationController pushViewController:uploadImageVC animated:YES];
}


@end
