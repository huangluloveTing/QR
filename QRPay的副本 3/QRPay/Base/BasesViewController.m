//
//  BasesViewController.m
//  ZDCraLoan
//
//  Created by yy on 16/7/11.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "BasesViewController.h"

@interface BasesViewController ()


@end

@implementation BasesViewController {
    UIImage *tempImage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    tempImage = [[UIImage alloc] init];
    
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.titleView = self.titleLabel;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 50)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"";
        
        _titleLabel.textColor = [UIColor whiteColor];
    }
    
    return _titleLabel;
}



- (UIBarButtonItem *)leftBarButton
{
    if (!_leftBarButton) {
        
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        leftButton.frame = CGRectMake(0, 0, 22 , 22);
        [leftButton setBackgroundImage:[UIImage imageNamed:@"xiangzuojiantou"] forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(returntoThePreviousPage) forControlEvents:UIControlEventTouchUpInside];
        
        _leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        
    }
    
    return _leftBarButton;
}


- (UIBarButtonItem *)rightBarButton
{
    if (!_rightBarButton) {
        
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        leftButton.frame = CGRectMake(0, 0, 22 , 22);
        [leftButton setBackgroundImage:[UIImage imageNamed:@"partnerRightBtn"] forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(rightBarButtonHandle) forControlEvents:UIControlEventTouchUpInside];
        
        _rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        
    }
    
    return _rightBarButton;
}



- (NullDatasView *)nullDataView
{
    if (!_nullDataView) {
        _nullDataView = [[NSBundle mainBundle]loadNibNamed:@"NullDatasView" owner:self options:nil][0];
        _nullDataView.frame = CGRectMake(0, 0,self.view.frame.size.width,self.view.frame.size.height);
        
    }
    
    return _nullDataView;
}



-(void)returntoThePreviousPage
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) rightBarButtonHandle {
    NSLog(@"tap Right");
}

- (void)chooseGetImageMethod {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"选择图片来源" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    WEAKSELF

    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf openCamera];
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [weakSelf openAlblum];
    }];
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertVC addAction:action1];
    [alertVC addAction:action2];
    [alertVC addAction:action3];
    
    [self presentViewController:alertVC animated:YES completion:^{
        
    }];
    
}

- (void) openAlblum {
    if ([self sourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
        
        UIImagePickerController *imagePickVC = [[UIImagePickerController alloc] init];
        
        imagePickVC.sourceType =  UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        imagePickVC.delegate = self;
        imagePickVC.allowsEditing = YES;
        
        [self presentViewController:imagePickVC animated:YES completion:^{
            NSLog(@"打开相机");
        }];
    
    }
}

- (void) openCamera {
    if ([self sourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *imagePickVC = [[UIImagePickerController alloc] init];
        
        imagePickVC.sourceType =  UIImagePickerControllerSourceTypeCamera;
        imagePickVC.delegate = self;
        imagePickVC.allowsEditing = YES;
        
        [self presentViewController:imagePickVC animated:YES completion:^{
            NSLog(@"打开相机");
        }];
        
    }
}

- (BOOL) sourceTypeAvailable:(UIImagePickerControllerSourceType)type {
    return [UIImagePickerController isSourceTypeAvailable:type];
    
    
}


#pragma mark -- PickViewControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
}

@end
