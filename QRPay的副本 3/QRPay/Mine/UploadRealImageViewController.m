//
//  UploadRealImageViewController.m
//  QRPay
//
//  Created by 黄露 on 2016/11/25.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "UploadRealImageViewController.h"
#import "TableViewFooterTipsView.h"

@interface UploadRealImageViewController (){
    NSArray *cameraTitlesArr;
    NSArray *imageNameArr;
    __block UploadIdImageTableViewCell *tapedCell;
}

@end

@implementation UploadRealImageViewController

- (instancetype) init {
    if (self = [super init]) {
        self.tableViewStyle = UITableViewStyleGrouped;
        self.isShowSearchView = NO;
        cameraTitlesArr = [NSArray array];
        cameraTitlesArr = @[@"点击上传身份证正面",@"点击上传身份证背面",@"点击上传经营场所图片"];
        imageNameArr = @[@"Idcard1",@"Idcard2",@"shopImage"];
        tapedCell = [[UploadIdImageTableViewCell alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = self.leftBarButton;
    self.titleLabel.text = @"新增商户";
}

#pragma mark -- UITableViewDelegate and datasource
- (NSInteger ) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return cameraTitlesArr.count;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        
        UploadIdImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"uploadImage" forIndexPath:indexPath];
        
        cell.btnTitle = cameraTitlesArr[indexPath.row];
        
        cell.styleImage = [UIImage imageNamed:imageNameArr[indexPath.row]];
        
        cell.cameraImage = [UIImage imageNamed:@"camera"];
        WEAKSELF
        [cell setTapCameraBtnBlock:^(UploadIdImageTableViewCell *blockCell, UIImageView *realImageView) {
            
            [weakSelf chooseGetImageMethod];
            
            tapedCell = blockCell;
        }];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01f;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 120 * PPWidth;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_VIEW(self.view), 200)];
    footer.backgroundColor = [UIColor clearColor];
    
    TableViewFooterTipsView *tipsView = [[TableViewFooterTipsView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_VIEW(footer), 120)];
    
    tipsView.backgroundColor = [UIColor clearColor];
    tipsView.contentStr = @"请确保上传照片准确、清晰\n经营场所照片应该包含商户主营业务信息，门头或收银台";
    tipsView.fontsize = 14 * PPWidth;
    
    [footer addSubview:tipsView];
    
    UIButton *footBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    footBtn.frame = CGRectMake(10, VIEW_MAXY(tipsView), WIDTH_VIEW(footer) - 20, 40);
    
    footBtn.layer.cornerRadius = 5;
    
    footBtn.backgroundColor = [UIColor blueColor];
    [footBtn setTitle:@"提交信息" forState:UIControlStateNormal];
    
    [footBtn addTarget:self action:@selector(submitRealImageView) forControlEvents:UIControlEventTouchUpInside];
    
    [footer addSubview:footBtn];
    
    return footer;
}

- (void) submitRealImageView {
    
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo  {
    
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    tapedCell.styleImage = image;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
