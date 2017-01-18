//
//  CustomPickViewController.h
//  QRPay
//
//  Created by 黄露 on 2016/11/25.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "BasesViewController.h"

@protocol selectedPickerViewDelegate <NSObject>

@required
- (void) selectedPickerViewWithTitle:(NSString *)title;

@end

@interface CustomPickViewController : BasesViewController<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic ,strong) UIPickerView *pickerView;
@property (nonatomic ,assign) id<selectedPickerViewDelegate> delegate;

@end
