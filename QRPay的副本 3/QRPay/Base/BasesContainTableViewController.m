//
//  BasesContainTableViewController.m
//  QRPay
//
//  Created by 黄露 on 2016/11/24.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "BasesContainTableViewController.h"

@interface BasesContainTableViewController ()

@end

@implementation BasesContainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
    self.navigationItem.leftBarButtonItem = self.leftBarButton;
    
    if (self.isShowSearchView) {
        [self.view addSubview:self.searchBarView];
        return;
    }
    
    [self.view addSubview:self.searchBarView];
    
}


#pragma mark -- Property 

- (UITableView *) tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:self.tableViewStyle];
        if (!self.isShowSearchView) {
            _tableView.frame = CGRectMake(0, 0, WIDTH_VIEW(self.view), HEIGHT_VIEW(self.view) - 64);
        }else {
            _tableView.frame = CGRectMake(0, VIEW_MAXY(self.searchBarView), WIDTH_VIEW(self.view), HEIGHT_VIEW(self.view) - VIEW_MAXY(self.searchBarView) - 64);
        }
        
        if (self.ishaveRefresh) {
            _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                NSLog(@"刷新");
                
                [_tableView.mj_header endRefreshing];
            }];
        }
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UploadTableViewCell class] forCellReuseIdentifier:@"uploadCell"];
        [_tableView registerClass:[SendCodeTableViewCell class] forCellReuseIdentifier:@"sendCell"];
        [_tableView registerClass:[UploadIdImageTableViewCell class] forCellReuseIdentifier:@"uploadImage"];
        [_tableView registerClass:[MyPartnerTableViewCell class] forCellReuseIdentifier:@"myshopper"];
        [_tableView registerClass:[MyShopperTableViewCell class] forCellReuseIdentifier:@"shopCell"];
        [_tableView registerClass:[MyShareFeeTableViewCell class] forCellReuseIdentifier:@"sharefee"];
    }
    
    return _tableView;
}

- (UISearchBar *)searchBarView {
    if (!_searchBarView) {
        _searchBarView = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, WIDTH_VIEW(self.view), 40)];
        _searchBarView.delegate = self;
        _searchBarView.barStyle = UIBarStyleDefault;
        _searchBarView.showsCancelButton = YES;
        _searchBarView.hidden = !self.isShowSearchView;
        _searchBarView.tintColor = [UIColor lightGrayColor];
    }
    
    return _searchBarView;
}

#pragma mark -- UITableViewDelegate and DateSource
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"cell"];
        cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    }
    return cell;
}

- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark -- UISearchDelegate

@end
