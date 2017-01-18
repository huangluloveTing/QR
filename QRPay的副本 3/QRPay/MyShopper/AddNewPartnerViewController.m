//
//  AddNewPartnerViewController.m
//  QRPay
//
//  Created by 黄露 on 2016/11/28.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "AddNewPartnerViewController.h"

#import "AddNewPartnerBanNumViewController.h"

@interface AddNewPartnerViewController (){
    NSArray *subTitles;
    NSArray *placeholderArr;
}

@end

@implementation AddNewPartnerViewController

- (instancetype) init {
    if (self = [super init]) {
        self.isShowSearchView = NO;
        self.ishaveRefresh = NO;
        self.tableViewStyle = UITableViewStyleGrouped;
        subTitles = @[@[@"姓名",@"分润百分比",@"手机号码",@"身份证号码"],@[@"输入密码",@"确认密码"]];
        
        placeholderArr = @[@[@"请输入合伙人姓名",@"请输入分润百分比1——100",@"请输入手机号码",@"请输入身份证号码"],@[@"请输入合伙人密码",@"再次输入密码"]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = @"新增合伙人";
}

#pragma mark -- TableView Delegate and Datasource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return subTitles.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *sections = subTitles[section];
    
    return sections.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        
            
        UploadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"uploadCell" forIndexPath:indexPath];
        cell.markTitle = subTitles[indexPath.section][indexPath.row];
        cell.placeholderStr = placeholderArr[indexPath.section][indexPath.row];
        cell.isShowKeyboard = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.section == 0) {
            if (indexPath.row == 2) {
                cell.keyBoardType = UIKeyboardTypeNumberPad;
            }
        }
        
        return cell;
    }
    
    return cell;
}


- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;
}

- (void) nextBtnAction {
    
//    NSIndexPath *indexPath = nil;
    
    NSMutableArray *informations = [NSMutableArray array];
    
//    for (int i = 0; i < subTitlesArr.count ; i ++ ) {
//        NSArray *rowArr = subTitlesArr[i];
//        for (int row = 0; row < rowArr.count ; row ++) {
//            indexPath = [NSIndexPath indexPathForRow:row inSection:i];
//            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
//            for (UIView *view in cell.contentView.subviews) {
//                [view endEditing:YES];
//            }
//            
//            if ([cell isKindOfClass:[UploadTableViewCell class]]) {
//                UploadTableViewCell *upCell = (UploadTableViewCell *)cell;
//                NSLog(@"celltext = %@",upCell.contentString);
//                if (upCell.contentString) {
//                    [informations addObject:upCell.contentString];
//                }
//                
//            }
//            
//            if ([cell isKindOfClass:[SendCodeTableViewCell class]]) {
//                SendCodeTableViewCell *sendCell = (SendCodeTableViewCell *)cell;
//                NSLog(@"cellt\ext = %@",sendCell.contentString);
//                if (sendCell.contentString) {
//                    [informations addObject:sendCell.contentString];
//                }
//            }
//        }
//    }
    
    NSLog(@"information = %@",informations);
    
    AddNewPartnerBanNumViewController *numVC = [[AddNewPartnerBanNumViewController alloc] init];
    [self.navigationController pushViewController:numVC animated:YES];
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 1) {
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_VIEW(self.view), 100)];
        
        UIButton  *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        nextBtn.backgroundColor = [UIColor blueColor];
        [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        nextBtn.layer.cornerRadius = 5;
        nextBtn.titleLabel.font = [UIFont systemFontOfSize:20 * PPWidth];
        
        nextBtn.frame = CGRectMake(10, HEIGHT_VIEW(footerView) - 30, WIDTH_VIEW(footerView) - 20, 40);
        
        [footerView addSubview:nextBtn];
        
        [nextBtn addTarget:self action:@selector(nextBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
        return footerView;
    }
    
    return nil;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (section == 1) {
        return 100;
    }
    return 0.1f;
}

@end
