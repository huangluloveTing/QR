//
//  YYAlertsView.h
//  提示框寻常
//
//  Created by yy on 16/7/7.
//  Copyright © 2016年 yy. All rights reserved.
//
//控件的尺寸





//YYAlertsView *alert=[[YYAlertsView alloc] initWithTitle:@"提示" message:@"自定义alertview,可以自动适应文字内容." cancelBtnTitle:@"取消" otherBtnTitle:@"确定"];
//
//alert.clickBlock = ^(NSInteger clickIndex){
//    NSLog(@"点击index====%ld",clickIndex);
//    
//};
////alert.dontDissmiss=YES;
////设置动画类型(默认是缩放)
//alert.animationStyle=YYAnimationTopShake;
//[alert showYYAlertView];



#define WIDTH_VIEW(view) CGRectGetWidth(view.frame)
#define HEIGHT_VIEW(view) CGRectGetHeight(view.frame)
#define VIEW_MAXX(view) CGRectGetMaxX(view.frame)
#define VIEW_MAXY(view) CGRectGetMaxY(view.frame)
#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger , YYShowAnimationStyle) {
    YYAnimationDefault    = 0,
    YYAnimationLeftShake  ,
    YYAnimationTopShake   ,
    YYAnimationNO         ,
};



typedef void(^YYAlertClickIndexBlock)(NSInteger clickIndex);




@interface YYAlertsView : UIView

@property (nonatomic,copy)YYAlertClickIndexBlock clickBlock;

@property (nonatomic,assign)YYShowAnimationStyle animationStyle;

@property (nonatomic , strong)UITextField *inputFie;

@property (nonatomic , strong)void(^YYAlertInputClick)(NSString *input);


/**
 *  不隐藏，默认为NO。设置为YES时点击按钮alertView不会消失（适合在强制升级时使用）
 */
@property (nonatomic,assign)BOOL dontDissmiss;


/**
 *  初始化alert方法（根据内容自适应大小，目前只支持1个按钮或2个按钮）
 *
 *  @param title         标题
 *  @param message       内容（根据内容自适应大小）
 *  @param cancelTitle   取消按钮
 *  @param otherBtnTitle 其他按钮
 *  @param block         点击事件block
 *
 *  @return 返回alert对象
 */

-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelBtnTitle:(NSString *)cancelTitle otherBtnTitle:(NSString *)otherBtnTitle;




-(instancetype)initWithTitle:(NSString *)title placeholder:(NSString *)string cancelBtnTitle:(NSString *)cancelTitle otherBtnTitle:(NSString *)otherBtnTitle;



-(void)showYYAlertView;



@end
