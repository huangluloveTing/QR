//
//  MyInfoViewController.m
//  QRPay
//
//  Created by yy on 16/9/20.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "MyInfoViewController.h"

#import "UploadTableViewCell.h"

@interface MyInfoViewController ()


{
    NSArray *itemArray;//存放项目标题
    NSDictionary *dataDic;//存放数据
}

@property (nonatomic, strong) UIButton *photoButton;

@property (nonatomic,strong)UITableView *myTableView;



@end

@implementation MyInfoViewController



- (UIButton *)photoButton
{
    if (!_photoButton) {
        
        _photoButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _photoButton.frame = CGRectMake(kDeviceWidth-80, 5, 50, 50);
        _photoButton.layer.masksToBounds = YES;
        _photoButton.layer.cornerRadius = 25;
        [_photoButton addTarget:self action:@selector(uploadUserHeadPhoto) forControlEvents:UIControlEventTouchUpInside];
        
        [_photoButton setBackgroundImage:[UIImage imageNamed:@"icon.jpg"] forState:UIControlStateNormal];
        
    }
    return _photoButton;
}



-(void)uploadUserHeadPhoto
{
    //上传图片
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = @"我的信息";
    
    self.navigationItem.leftBarButtonItem = self.leftBarButton;
    
    itemArray = @[@[@{@"商户编号":@"customerNo"},
                    @{@"商户名":@"customerName"},
                    @{@"状态":@"status"},
                    @{@"开通时间":@"openTime"}],
                  @[@{@"联系人":@"linkMan"},
                    @{@"联系电话":@"phoneNo"},
                    @{@"开户支行":@"openBankName"},
                    @{@"结算银行卡":@"bankAccountNo"}]];

    
    [self.view addSubview:self.myTableView];
}


- (UITableView *)myTableView
{
    if (!_myTableView) {
        
        _myTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.dataSource = self;
        _myTableView.delegate = self;
        _myTableView.bounces = NO;
        [_myTableView registerNib:[UINib nibWithNibName:@"DebitTableViewCell" bundle:nil] forCellReuseIdentifier:@"DebitTableViewCell"];
        [_myTableView registerClass:[UploadTableViewCell class] forCellReuseIdentifier:@"upload"];
    }
    
    return _myTableView;
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return itemArray.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    NSArray *array = [itemArray objectAtIndex:section];
    
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DebitTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DebitTableViewCell" forIndexPath:indexPath];
    
    NSArray *array = itemArray[indexPath.section];
    
    
    NSString *titl = [array[indexPath.row] allKeys][0];
    cell.subbjectLabel.text = titl;
    cell.valueTextField.userInteractionEnabled = NO;
    
    {
        
        cell.valueTextField.text = [PayConfig nilStr:[[PayConfig getUserInfo] valueForKey:[array[indexPath.row] valueForKey:titl]]];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50.;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
//    if (section == 2) {
//        return 120;
//    }
    return 1.;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DebitTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSLog(@"text = %@ %@",cell.subbjectLabel.text,cell.valueTextField.text);
}

@end
