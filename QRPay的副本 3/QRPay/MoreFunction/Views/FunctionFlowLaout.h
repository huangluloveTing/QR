//
//  FunctionFlowLaout.h
//  QRPay
//
//  Created by 黄露 on 2016/11/17.
//  Copyright © 2016年 yy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FunctionFlowLaout : UICollectionViewFlowLayout

@property (nonatomic ,assign) NSInteger numsOfPerRow; //每行的个数
@property (nonatomic ,assign) CGFloat marginOfRow; //行间隙
@property (nonatomic ,assign) CGFloat marginOfCol; //列间隙

@end
