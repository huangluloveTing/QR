//
//  BasesViewController.h
//  ZDCraLoan
//
//  Created by yy on 16/7/11.
//  Copyright © 2016年 yy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NullDatasView.h"
@interface BasesViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UIBarButtonItem *leftBarButton;

@property (nonatomic,strong) UIBarButtonItem *rightBarButton;

@property (nonatomic , strong)NullDatasView *nullDataView;

-(void)returntoThePreviousPage;

- (void) rightBarButtonHandle;

- (void)chooseGetImageMethod;

//打开相机
- (void) openCamera;

//打开相册
- (void) openAlblum;






@end
