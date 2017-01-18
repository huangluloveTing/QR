//
//  ViewController.m
//  QRPay
//
//  Created by yy on 16/9/18.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@property (nonatomic , strong)UIImageView *imageViews;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    QRCodeCreatView *vc = [[QRCodeCreatView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.width)];
    vc.size = 1024;
    vc.URLString = @"www.baidu.com";
    [vc startCreat];
    [self.view addSubview:vc];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
