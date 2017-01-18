//
//  BasesContainTableViewController.h
//  QRPay
//
//  Created by 黄露 on 2016/11/24.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "BasesViewController.h"
#import "UploadTableViewCell.h"
#import "SendCodeTableViewCell.h"
#import "UploadInformationModel.h"
#import "UploadIdImageTableViewCell.h"
#import "MyPartnerTableViewCell.h"
#import "MyShopperTableViewCell.h"
#import "MyShareFeeTableViewCell.h"
#import "MJRefresh.h"

@interface BasesContainTableViewController : BasesViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UIScrollViewDelegate>

//搜索条
@property (nonatomic ,strong) UISearchBar *searchBarView;

//tableView
@property (nonatomic ,strong) UITableView *tableView;

//是否显示搜索条
@property (nonatomic ,assign) BOOL isShowSearchView;

//是否有刷新控件
@property (nonatomic ,assign) BOOL ishaveRefresh;

//table的样式
@property (nonatomic ,assign) UITableViewStyle tableViewStyle;

@end
