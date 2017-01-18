//
//  UploadInformationViewController.m
//  QRPay
//
//  Created by 黄露 on 2016/11/24.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "UploadInformationViewController.h"
#import "AddNewStoreBankNumViewController.h"

@interface UploadInformationViewController (){
    NSArray *subTitlesArr;                      //  所有cell 的title
    NSArray *placeholderArr;                    //  所有cell 里的textfield 的placeholder
    UploadInformationModel *informationModel;   //  信息model
}

@end

@implementation UploadInformationViewController

- (instancetype) init {
    if (self = [super init]) {
        self.tableViewStyle = UITableViewStyleGrouped;
        self.isShowSearchView = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.leftBarButtonItem = self.leftBarButton;
    self.titleLabel.text = @"新增商户";
    
    informationModel = [UploadInformationModel new];
    
    subTitlesArr = @[@[@"商户名称",@"经营地址"],@[@"手机号码",@"验证码",@"联系人",@"身份证号码"]];
    
    placeholderArr = @[@[@"请输入商户名称",@"请输入经营地址"],@[@"请输入手机号码",@"请输入验证码",@"请输入联系人",@"请输入身份证号码"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark -- tableViewDelegatee and dateSource
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *sectionArr = subTitlesArr[section];
    return sectionArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return subTitlesArr.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        
        if (indexPath.row  == 1 && indexPath.section == 1) {
            
            
            SendCodeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sendCell" forIndexPath:indexPath];
            cell.subTitles = subTitlesArr[indexPath.section][indexPath.row];
            cell.placeholderStr = placeholderArr[indexPath.section][indexPath.row];
            cell.btnStr = @"获取验证码";
            cell.tapSendBtnBlock = ^(NSString *phoneNum ,UIButton *btn) {
                NSLog(@"phoneNUm = %@",phoneNum);
                btn.enabled = NO;
                [btn setTitle:@"已点击" forState:UIControlStateDisabled];
            };
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
        
        else {
            
            
            
            UploadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"uploadCell" forIndexPath:indexPath];
            if (indexPath.section == 1 && indexPath.row == 0) {
                cell.keyBoardType = UIKeyboardTypeNumberPad;
            }
            cell.markTitle = subTitlesArr[indexPath.section][indexPath.row];
            cell.placeholderStr = placeholderArr[indexPath.section][indexPath.row];
            cell.isShowKeyboard = YES;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
            
        }
    }
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
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

- (void) nextBtnAction {
    
    NSIndexPath *indexPath = nil;
    
    NSMutableArray *informations = [NSMutableArray array];
    
    for (int i = 0; i < subTitlesArr.count ; i ++ ) {
        NSArray *rowArr = subTitlesArr[i];
        for (int row = 0; row < rowArr.count ; row ++) {
            indexPath = [NSIndexPath indexPathForRow:row inSection:i];
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            for (UIView *view in cell.contentView.subviews) {
                [view endEditing:YES];
            }
            
            if ([cell isKindOfClass:[UploadTableViewCell class]]) {
                UploadTableViewCell *upCell = (UploadTableViewCell *)cell;
                NSLog(@"celltext = %@",upCell.contentString);
                if (upCell.contentString) {
                    [informations addObject:upCell.contentString];
                }
                
            }
            
            if ([cell isKindOfClass:[SendCodeTableViewCell class]]) {
                SendCodeTableViewCell *sendCell = (SendCodeTableViewCell *)cell;
                NSLog(@"cellt\ext = %@",sendCell.contentString);
                if (sendCell.contentString) {
                    [informations addObject:sendCell.contentString];
                }
            }
        }
    }
    
    NSLog(@"information = %@",informations);
    
    AddNewStoreBankNumViewController *numVC = [[AddNewStoreBankNumViewController alloc] init];
    
    [self.navigationController pushViewController:numVC animated:YES]
    ;
}

@end
