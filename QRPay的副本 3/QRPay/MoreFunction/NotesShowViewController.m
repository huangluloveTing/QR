//
//  NotesShowViewController.m
//  QRPay
//
//  Created by 黄露 on 2016/11/28.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "NotesShowViewController.h"
#import "NotesDetailViewController.h"

@interface NotesShowViewController ()

@end

@implementation NotesShowViewController

- (instancetype) init {
    if (self =[super init]) {
        self.tableViewStyle = UITableViewStyleGrouped;
        self.ishaveRefresh = YES;
    }
    
    return self;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.titleLabel.text = @"公告消息";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"notescell"];
        
        cell.imageView.image = [UIImage imageNamed:@"repoter"];
        cell.textLabel.text = [NSString stringWithFormat:@"这是一条消息 %ld",indexPath.row];
        cell.detailTextLabel.text = [PayConfig getCurrentDate];
        cell.detailTextLabel.textColor = [UIColor lightGrayColor];
        
        return cell;
    }
    
    return cell;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NotesDetailViewController *detailVC = [[NotesDetailViewController alloc] init];
    
    detailVC.notesTitle = @"标题";
    detailVC.notesTime = [PayConfig getCurrentDate];
    detailVC.contentString = @"\t刚看了四个婚礼开始鼓励考生高考历史格拉斯哥和卡拉斯科回过神来看过还是立刻赶回来上课赶回来上课赶回来上课韩国卢卡申科供货商联合公司联合公司扩大联合国流口水的脚后跟 i 是个 i 额 u 一饿一饿。 哈佛回来发哈酸辣粉好好疯了卡回来后刚看了四个婚礼开始鼓励考生高考历史格拉斯哥和卡拉斯科回过神来看过还是立刻赶回来上课赶回来上课赶回来上课韩国卢卡申科供货商联合公司联合公司扩大联合国流口水的脚后";
    
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
