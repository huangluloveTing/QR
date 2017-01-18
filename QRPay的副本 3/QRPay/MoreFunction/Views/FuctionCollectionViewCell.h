//
//  FuctionCollectionViewCell.h
//  QRPay
//
//  Created by 黄露 on 2016/11/17.
//  Copyright © 2016年 yy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FunctionCellModel : NSObject

@property (nonatomic ,copy) NSString *title;
@property (nonatomic ,strong) UIImage *image;
@property (nonatomic ,copy) NSString *localUrl;


@end

//删除按钮的block
typedef void(^TapDeleteBtnBlock)();

@interface FuctionCollectionViewCell : UICollectionViewCell

@property (nonatomic ,strong) FunctionCellModel *model;

@property (nonatomic ,assign) BOOL isShowDeleteBtn;  //是否显示删除按钮

@property (nonatomic ,assign) TapDeleteBtnBlock tapDeletBtnBlock;

@end
