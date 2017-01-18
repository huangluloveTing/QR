//
//  MypartnerListDetailViewController.m
//  QRPay
//
//  Created by 黄露 on 2016/11/29.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "MypartnerListDetailViewController.h"
#import "TitleAndContentView.h"

@interface MypartnerListDetailViewController () {
    NSArray *titlesArr;
}

@property (nonatomic ,strong) UIView *headerView;

@property (nonatomic ,strong) UIView *detailView;

@property (nonatomic ,strong) UILabel *rateLabel;

@end

@implementation MypartnerListDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = @"订单详情";
    self.navigationItem.leftBarButtonItem = self.leftBarButton;
    
    titlesArr = @[@"合伙人编号:",@"销售员编号:",@"商户手续费:",@"银行订单号:",@"金额:",@"支付时间:",@"状态:"];
    
    [self configViews];
}

- (void) configViews {
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_VIEW(self.view), 60)];
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20 , 10, 40, 40)];
    headImageView.contentMode = UIViewContentModeScaleToFill;
    headImageView.image = [UIImage imageNamed:@"partnerListDetail"];
    [self.headerView addSubview:headImageView];
    
    TitleAndContentView *titleContentView = [[TitleAndContentView alloc] initWithFrame:CGRectMake(VIEW_MAXX(headImageView) + 10, 0, WIDTH_VIEW(self.view) - VIEW_MAXX(headImageView) - 10, 40)];
    titleContentView.center = CGPointMake(titleContentView.center.x, headImageView.center.y);
    titleContentView.title = @"订单号:";
    titleContentView.contentString = self.listModel.orderId;
    titleContentView.titleFont = [UIFont systemFontOfSize:16 * PPWidth];
    titleContentView.contentFont = [UIFont systemFontOfSize:15 * PPWidth];
    titleContentView.contentColor = [UIColor lightGrayColor];
    [titleContentView toAdjustToFit]; //调整titleContentView 的title label 和contentLabel的frame
    [self.headerView addSubview:titleContentView];
    [self.view addSubview:self.headerView];
    
    UILabel *seperateLine1 = [[UILabel alloc] initWithFrame:CGRectMake(0, VIEW_MAXY(self.headerView), WIDTH_VIEW(self.view), 1)];
    seperateLine1.backgroundColor = TABLEVIEW_GROUPED_BGCOLOR;
    
    [self.view addSubview:seperateLine1];
    
    self.rateLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, VIEW_MAXY(seperateLine1), WIDTH_VIEW(self.view) - 20, 40)];
    self.rateLabel.text = [NSString stringWithFormat:@"%.2f",self.listModel.rate];
    self.rateLabel.textColor = [UIColor blackColor];
    self.rateLabel.font = [UIFont systemFontOfSize:19];
    
    [self.view addSubview:self.rateLabel];
    
    UILabel *seperateLine2 = [[UILabel alloc] initWithFrame:CGRectMake(0, VIEW_MAXY(self.rateLabel), WIDTH_VIEW(self.view), 1)];
    seperateLine2.backgroundColor = TABLEVIEW_GROUPED_BGCOLOR;
    
    [self.view addSubview:seperateLine2];
    
    self.detailView = [[UIView alloc] initWithFrame:CGRectMake(0, VIEW_MAXY(seperateLine2), WIDTH_VIEW(self.view), 20 * titlesArr.count)];
    
    [self.view addSubview:self.detailView];
    
    for (int i = 0; i < titlesArr.count; i ++ ) {
        TitleAndContentView *listView = [[TitleAndContentView alloc] initWithFrame:CGRectMake(20, i * 30 , WIDTH_VIEW(self.view) - 40, 30)];
        
        listView.title = titlesArr[i];
        
        switch (i) {
            case 0:
                listView.contentString = _listModel.partnerId;
                break;
                
            case 1:
                listView.contentString = _listModel.salerId;
                break;
                
            case 2:
                listView.contentString = [NSString stringWithFormat:@"%.2f", _listModel.rate];
                break;
                
            case 3:
                listView.contentString = _listModel.bankOrderId;
                break;
                
            case 4:
                listView.contentString = [NSString stringWithFormat:@"%.2f",_listModel.money];
                break;
                
            case 5:
                listView.contentString = _listModel.tradeTime;
                break;
                
            case 6:
                switch (_listModel.payResultStatus) {
                        /*
                         Pay_Success = 0,
                         Pay_Watting,
                         Pay_Failed,
                         Pay_Unknown
                         */
                    case Pay_Success:
                        listView.contentString = @"已支付";
                        break;
                        
                    case Pay_Watting:
                        listView.contentString = @"等待支付";
                        break;
                        
                    case Pay_Failed:
                        listView.contentString = @"支付失败";
                        break;
                        
                    case Pay_Unknown:
                        listView.contentString = @"未知";
                        break;
                        
                    default:
                        break;
                }
                break;
                
            default:
                break;
        }
        
        [self.detailView addSubview:listView];
    }
}

@end
