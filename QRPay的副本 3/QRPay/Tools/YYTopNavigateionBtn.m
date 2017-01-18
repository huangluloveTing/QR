//
//  YYTopNavigateionBtn.m
//  QRCodePay
//
//  Created by yy on 16/5/30.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "YYTopNavigateionBtn.h"
#import "UIButton+LXMImagePosition.h"

@implementation YYTopNavigateionBtn
{
    UIButton *tempBtn;
}

-(id)initWithFrame:(CGRect)frame withTitle:(NSArray *)titleArr{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self creatSubView:titleArr];
    }
    return self;
}

-(void)creatSubView:(NSArray *)titleArr
{
    
    
    CGFloat with = self.frame.size.width/2;
    

    
    
    for(int i = 0 ; i<2; i++){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(with*i, 0, with, self.frame.size.height-1);
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15.0];


        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btn setTitleColor:RGBACOLOR(15, 131, 255, 1) forState:UIControlStateSelected];
        
        
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -10/2, 0, 10/2);
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10/2, 0, -10/2);
        
        [btn setImagePosition:LXMImagePositionLeft spacing:10];
        
        
        if (i == 0) {
            btn.selected = YES;
            tempBtn = btn;
        }
        
        
        btn.tag = i;
        [btn addTarget:self action:@selector(btnHandle:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
    }
    
    
//    UILabel *lin = [[UILabel alloc]initWithFrame:CGRectMake(0, 39.5, self.frame.size.width, 0.5)];
//    lin.backgroundColor = [UIColor lightGrayColor];
//    [self addSubview:lin];
    
    self.lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 39, with, 1)];
    _lable.backgroundColor = RGBACOLOR(15, 131, 255, 1);
    [self addSubview:_lable];
    
    
//    for (int i = 0; i<titleArr.count+1; i++) {
//        UIView *lin = [[UIView alloc]initWithFrame:CGRectMake(with*i, 5, 1, self.frame.size.height-10)];
//        lin.backgroundColor = RGBACOLOR(233, 233, 233, 1);
//        [self addSubview:lin];
//    }
    
}



-(void)btnHandle:(UIButton *)button
{
    
    if (button != tempBtn) {
        
        tempBtn.selected = NO;
        button.selected = YES;
        tempBtn = button;
        
        [UIView animateWithDuration:.1 animations:^{
            self.lable.center = CGPointMake(button.center.x, self.lable.center.y);
        }];
        if ([_delegate respondsToSelector:@selector(navigationBtnClick:)]) {
            [_delegate navigationBtnClick:button];
        }
        
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
