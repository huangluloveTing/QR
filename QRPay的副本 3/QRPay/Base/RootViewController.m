//
//  RootViewController.m
//  ZDCraLoan
//
//  Created by yy on 16/7/11.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    UIColor *titleHighlightedColor = RGBACOLOR(0, 128, 255, 1);
    UIColor *titleColor = RGBACOLOR(83, 83, 83, 1);
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       titleColor, NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       titleHighlightedColor, NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateSelected];
    
    
    
    
    
    
   ReceivablesViewController *oneVC = [[ReceivablesViewController alloc]init];
    UINavigationController *convenienceNaVC = [[UINavigationController alloc]initWithRootViewController:oneVC];
    convenienceNaVC.navigationItem.title = @"收款";
    UIImage *normalImage1 = [[UIImage imageNamed:@"tab_home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectImage1 = [[UIImage imageNamed:@"tab_home_h"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    convenienceNaVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"收款" image:normalImage1 selectedImage:selectImage1];
    
    
    
    MoreFUnctionViewController *twoVC = [[MoreFUnctionViewController alloc]init];
    UINavigationController *carNaVC = [[UINavigationController alloc]initWithRootViewController:twoVC];
    carNaVC.navigationItem.title = @"功能";
    UIImage *normalImage2 = [[UIImage imageNamed:@"function"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectImage2 = [[UIImage imageNamed:@"click_function_2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    carNaVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"功能" image:normalImage2 selectedImage:selectImage2];
    
    MinesViewController *threeVC = [[MinesViewController alloc]init];
    UINavigationController *mineNaVC = [[UINavigationController alloc]initWithRootViewController:threeVC];
    mineNaVC.navigationItem.title = @"我的";
    UIImage *normalImage3 = [[UIImage imageNamed:@"tab_user"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectImage3 = [[UIImage imageNamed:@"tab_user_h"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    mineNaVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的" image:normalImage3 selectedImage:selectImage3];

    
    
    
    self.viewControllers = @[convenienceNaVC,carNaVC,mineNaVC];
    self.selectedIndex = 0;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
