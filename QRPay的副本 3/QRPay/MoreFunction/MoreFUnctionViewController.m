//
//  MoreFUnctionViewController.m
//  QRPay
//
//  Created by 黄露 on 2016/11/17.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "MoreFUnctionViewController.h"
#import "FunctionFlowLaout.h"
#import "FuctionCollectionViewCell.h"
#import "BannerView.h"
#import "MyBusinessDetailView.h"
#import "PayConfig.h"
#import "Constant.h"
#import "OrdersViewController.h"
#import "MyBusinessDetailView.h"


#import "UploadInformationViewController.h"
#import "MyShopperViewController.h"
#import "AddNewPartnerViewController.h"
#import "MyPartnerViewController.h"
#import "MyShareFeeViewController.h"
#import "NotesShowViewController.h"

#define PADDING (10 * PPWidth)   //视图之间的间隙

@interface MoreFUnctionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSArray *bannerModels;
    
    NSArray *titlesArr;
}
@property (nonatomic ,strong) UICollectionView *moreFunctionCollectionView;
@property (nonatomic ,strong) BannerView *bannerView;
@property (nonatomic ,strong) MyBusinessDetailView *MyBusinessView;
@property (nonatomic ,assign) BOOL isShakeCell;
@property (nonatomic ,strong) UILongPressGestureRecognizer *dragGesture; //拖动手势
@property (nonatomic ,strong) UILongPressGestureRecognizer *shakeGesture; 
@end

@implementation MoreFUnctionViewController {
    NSMutableArray *collectionArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    _isShakeCell = NO;
    
    titlesArr = @[
                  @"开通商户",
                  @"我的商户",
                  @"消息提醒",
                  @"新增伙伴",
                  @"我的合伙人",
                  @"我的分润",
                  @"我的账单",
                  @"我的客服"
                  ];
    
    self.titleLabel.text = @"功能";
    
    
    UILabel *seperateLine = [[UILabel alloc] initWithFrame:CGRectMake( 0, CGRectGetMinY(self.moreFunctionCollectionView.frame) - 0.5, WIDTH_VIEW(self.view), 0.5)];
    seperateLine.backgroundColor = RGBCOLOR(218, 218, 218);
    [self.view addSubview:seperateLine];
    
    [self.view addSubview:self.bannerView];
    [self.view addSubview:self.MyBusinessView];
    [self.view addSubview:self.moreFunctionCollectionView];
    
    [self loadCellData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog(@"view appear");
//    [self.bulletView startShoot];
    
    self.isShakeCell = NO;
    
    [self.moreFunctionCollectionView reloadData];
}

- (void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    NSLog(@"view dismiss");
    
}

#pragma mark -- Init data 

- (NSArray *) loadData {
    NSMutableArray *modelDatas = [NSMutableArray array];
    for (int i = 0 ;  i < 4 ; i ++) {
        BannerViewModel *model = [BannerViewModel new];
        
        model.title = @"这是我的banner";
        model.placeholderImage = [UIImage imageNamed:@"wei"];
        model.destinationUrl = [NSString stringWithFormat:@"https://www.baidu.com %d" ,i];
        model.imageUrl = @"http://img.aiimg.com/uploads/allimg/140619/280082-140619144134.jpg";
        [modelDatas addObject:model];
    }
    
    bannerModels = [NSArray arrayWithArray:modelDatas];
    
    return bannerModels;
}

//- (NSArray *) loadBulletViewData {
//    
//    NSMutableArray *datas = [NSMutableArray array];
//    
//    for (int i = 0; i < 4 ; i ++) {
//        BulletViewModel *model = [BulletViewModel new];
//        
//        model.message = [NSString stringWithFormat:@"这是第%d条消息",i];
//        
//        [datas addObject:model];
//    }
//    
//    return [NSArray arrayWithArray:datas];
//}

- (void) loadCellData {
    
    NSMutableArray *cellDatas = [NSMutableArray array];
//    if ([PayConfig getDataWithKey:TITILEKEY]) {
//        collectionArr = [NSMutableArray arrayWithArray:[PayConfig getDataWithKey:TITILEKEY]];
//        return;
//    }
    for (int i = 0; i < 8; i ++) {
        FunctionCellModel *model = [FunctionCellModel new];
        
        model.image = [UIImage imageNamed:[NSString stringWithFormat:@"morefuction_%d",i]];
        model.title = titlesArr[i];
        model.localUrl = @"http://pic11.nipic.com/20101210/145234_171809096827_2.png";
        
        [cellDatas addObject:model];
        
        
    }
    
    collectionArr = [NSMutableArray arrayWithArray:cellDatas];
    
//    [PayConfig saveConfigWithKey:TITILEKEY andData:collectionArr];
    
    [self.moreFunctionCollectionView reloadData];
}

#pragma mark -- Init

- (BannerView *)bannerView {
    if (!_bannerView ) {
        _bannerView = [[BannerView alloc] initWithFrame:CGRectMake(0, 0.01, CGRectGetWidth(self.view.frame), CGRectGetWidth(self.view.frame) * 0.563)];
        _bannerView.models = [self loadData];
        _bannerView.pageControlPlace = pageControlPlaceInBottomCenter;
        _bannerView.pageControlIndicatorColor = [UIColor lightGrayColor];
        _bannerView.pageControlCurrentIndicatorColor = [UIColor redColor];
        _bannerView.titlePlace = TitleInRight;
        _bannerView.tapBannerImage = ^(NSString *destUrl) {
            NSLog(@"desURl= %@",destUrl )
        };
    }
    
    return _bannerView;
}

- (MyBusinessDetailView *) MyBusinessView {
    if (!_MyBusinessView) {
        _MyBusinessView = [[MyBusinessDetailView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.bannerView.frame), CGRectGetWidth(self.view.frame), 45 )];
        
        _MyBusinessView.trades = @[@"100",@"635353582.00",@"7878"];
    }

    return _MyBusinessView;
}

- (UICollectionView *) moreFunctionCollectionView {
    if (!_moreFunctionCollectionView) {
        FunctionFlowLaout *layout = [[FunctionFlowLaout alloc] init];
        layout.numsOfPerRow = 4;
        layout.marginOfCol = 0;
        layout.marginOfRow = 0;
        _moreFunctionCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.MyBusinessView.frame) + PADDING, WIDTH_VIEW(self.view) + 0.5, HEIGHT_VIEW(self.view)) collectionViewLayout:layout];
        _moreFunctionCollectionView.backgroundColor = [UIColor whiteColor];
        _moreFunctionCollectionView.bouncesZoom = NO;
        _moreFunctionCollectionView.scrollEnabled = NO;
        _moreFunctionCollectionView.delegate = self;
        _moreFunctionCollectionView.dataSource = self;
        [_moreFunctionCollectionView registerClass:[FuctionCollectionViewCell class] forCellWithReuseIdentifier:@"collectCell"];
        _moreFunctionCollectionView.userInteractionEnabled = YES;
        UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handlelongGesture:)];
        
        [_moreFunctionCollectionView addGestureRecognizer:longGesture];
    }
    
    return _moreFunctionCollectionView;
}

#pragma mark -- Gesture  Action -----> longGesture

- (void)handlelongGesture:(UILongPressGestureRecognizer *)longGesture {
    //判断手势状态
    switch (longGesture.state) {
        case UIGestureRecognizerStateBegan:{
            //判断手势落点位置是否在路径上
//            NSIndexPath *indexPath = [self.moreFunctionCollectionView indexPathForItemAtPoint:[longGesture locationInView:self.moreFunctionCollectionView]];
//            if (indexPath.row >= 0) {//第一个不可移动  个人限制
//                [self.moreFunctionCollectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
//            }else{
//                break;
//            }
//            self.isShakeCell = YES;
            
//            [self.moreFunctionCollectionView reloadData];
        }
            break;
        case UIGestureRecognizerStateChanged:{
//            NSIndexPath* indexPath = [self.moreFunctionCollectionView indexPathForItemAtPoint:[longGesture locationInView:self.moreFunctionCollectionView]];
////            if(indexPath.row<1){
////                break;//第一个不可移动  个人限制
////            }
//            //移动过程当中随时更新cell位置
//            [self.moreFunctionCollectionView updateInteractiveMovementTargetPosition:[longGesture locationInView:self.moreFunctionCollectionView]];
//            break;
        }
        case UIGestureRecognizerStateEnded:
            //移动结束后关闭cell移动
//            [self.moreFunctionCollectionView endInteractiveMovement];

            break;
        default:
//            [self.moreFunctionCollectionView endInteractiveMovement];
            
            //            [_vibrate cancelInteractiveMovement];
            break;
    }
}

#pragma mark -- UICollectionView Delegate And DataSource

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return collectionArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FuctionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectCell" forIndexPath:indexPath];
    
    if (indexPath.item != collectionArr.count) {
        
        FunctionCellModel *model = [collectionArr objectAtIndex:indexPath.row];
        
        cell.isShowDeleteBtn = _isShakeCell;
        cell.tapDeletBtnBlock = ^() {
            NSLog(@"tapDeleteBtn");
        };
        
        cell.model = model;
    }

    return cell;
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.item) {
            
            //            开通商户
        case 0:
        {
            UploadInformationViewController *containTableVC = [[UploadInformationViewController alloc] init];
            
            containTableVC.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:containTableVC animated:YES];
        }
            break;
            
            
            //            我的商户
        case 1:
        {
            MyShopperViewController *shopperVC = [[MyShopperViewController alloc] init];
            shopperVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:shopperVC animated:YES];
        }
            break;
            
            
            //            消息提醒
        case 2:
        {
            NotesShowViewController *notesVC = [[NotesShowViewController alloc] init];
            
            notesVC.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:notesVC animated:YES];
           
        }
            break;
            
            
            //        新增伙伴
        case 3:
        {
            AddNewPartnerViewController *addNewPartVC = [[AddNewPartnerViewController  alloc] init];
            
            addNewPartVC.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:addNewPartVC animated:YES];
        }
            break;
            
            //        我的合伙人
        case 4:
        {
            MyPartnerViewController *partnerVC = [[MyPartnerViewController alloc] init];
            partnerVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:partnerVC animated:YES];
        }
            break;
            
            //        我的分润
        case 5:
        {
            MyShareFeeViewController *shreFeeVC = [[MyShareFeeViewController alloc] init];
            
            shreFeeVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:shreFeeVC animated:YES];
        }
            break;
            
            //            我的账单
        case 6:
        {
            OrdersViewController *orderVC = [[OrdersViewController alloc] init];
            
            [self.navigationController pushViewController:orderVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}

- (BOOL) collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void) collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    //取出源item数据
    id objc = [collectionArr objectAtIndex:sourceIndexPath.item];
    //从资源数组中移除该数据
    [collectionArr removeObject:objc];
    //将数据插入到资源数组中的目标位置上
    [collectionArr insertObject:objc atIndex:destinationIndexPath.item];
    
    [self.moreFunctionCollectionView reloadData];
}

@end
