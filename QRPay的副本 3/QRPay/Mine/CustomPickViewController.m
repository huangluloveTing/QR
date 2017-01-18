//
//  CustomPickViewController.m
//  QRPay
//
//  Created by 黄露 on 2016/11/25.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "CustomPickViewController.h"
#import "CustomPresentationController.h"

#define TOPHEIGHT (40)

@interface CustomPickViewController ()<UIViewControllerTransitioningDelegate> {
    NSArray *dataSource1;
    NSArray *dataSource2;
}

@property (nonatomic ,strong) UIView *topView;

@end

@implementation CustomPickViewController

- (instancetype) init {
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dataSource1 = @[@"四川",@"广东",@"福建",@"甘肃",@"陕西"];
    dataSource2 = @[
                    @[@"成都",@"巴中",@"自贡"],
                    @[@"潮州",@"东莞",@"广州"],
                    @[@"福州",@"厦门",@"厦大"],
                    @[@"莫高窟",@"敦煌",@"兰州"],
                    @[@"汉中",@"西安",@"咸阳"]
                    ];
    
    [self.view addSubview:self.topView];
    [self.view addSubview:self.pickerView];
    [self.pickerView selectRow:2 inComponent:0 animated:YES];
}

- (UIPickerView *)pickerView {
    if (!_pickerView ) {
        _pickerView  = [[UIPickerView alloc] initWithFrame:CGRectMake(0, TOPHEIGHT *PPWidth, WIDTH_VIEW(self.view), 200 * PPWidth)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        
        _pickerView.showsSelectionIndicator = YES;
        
    }
    return _pickerView;
}

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_VIEW(self.view), TOPHEIGHT *PPWidth)];
        
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
        [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        leftBtn.frame = CGRectMake(10, 5, 50, HEIGHT_VIEW(_topView) - 10);
        [leftBtn addTarget:self action:@selector(tapCancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_topView addSubview:leftBtn];
        
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightBtn setTitle:@"完成" forState:UIControlStateNormal];
        [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        rightBtn.frame = CGRectMake(WIDTH_VIEW(_topView) - 60, 5, 50, HEIGHT_VIEW(_topView) - 10);
        [rightBtn addTarget:self action:@selector(tapSureBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_topView addSubview:rightBtn];
        
        _topView.backgroundColor = RGBCOLOR(40, 126, 251);
    }
    
    return _topView;
}

#pragma mark -- Btn Action

- (void) tapCancelBtnAction {
    
    if (self.delegate && [self.delegate performSelector:@selector(selectedPickerViewWithTitle:) withObject:@""]) {
        
        [self.delegate selectedPickerViewWithTitle:@""];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) tapSureBtnAction {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- PickView DataSource an Delegate
- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (component == 0) {
        return dataSource1.count;
    }
    NSArray *subTitles = dataSource2[[self.pickerView selectedRowInComponent:0]];
    return subTitles.count;
}

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (CGFloat) pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    return WIDTH_VIEW(self.view) / 2 - 20;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (component == 0) {
        return dataSource1[row];
    }
    
    else {
        return dataSource2[[self.pickerView selectedRowInComponent:0]][row];
    }
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0) {
        [self.pickerView selectRow:row inComponent:0 animated:YES];
        [self.pickerView reloadComponent:1];
    }
    
    NSInteger index1 = [self.pickerView selectedRowInComponent:0];
    
    NSString *str1 = dataSource1[index1];
    
    NSInteger index2 = [self.pickerView selectedRowInComponent:1];
    NSString *str2 = dataSource2[index1][index2];
    
    NSString *title = [NSString stringWithFormat:@"%@        %@" , str1 , str2];
    
    if (self.delegate && [self.delegate performSelector:@selector(selectedPickerViewWithTitle:) withObject:title]) {
        
        [self.delegate selectedPickerViewWithTitle:title];
    }
    
}

- (UIPresentationController *) presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    
    if (presented == self) {
        CustomPresentationController *customPresentationVC = [[CustomPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
        
        customPresentationVC.PressBackgroundViewBlock = ^() {
            [self dismissViewControllerAnimated:YES completion:nil];
        };
        
        return customPresentationVC;
    }
    return nil;
}

@end
