//
//  MineHeaderView.m
//  ZDCraLoan
//
//  Created by yy on 16/7/12.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "MineHeaderView.h"

@implementation MineHeaderView




-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self creatView];
    }
    return self;
}


-(void)creatView
{
    //信息内容
    CGRect icon_frame = CGRectMake((kDeviceWidth-80)/2, self.bounds.size.height-150, 80, 80);
    UIImageView *icon = [[UIImageView alloc] initWithFrame:icon_frame];
//    icon.backgroundColor = [UIColor clearColor];
    icon.image = [UIImage imageNamed:@"icon.jpg"];
    icon.layer.cornerRadius = 80/2.0f;
    icon.layer.masksToBounds = YES;
    icon.layer.borderWidth = 1.0f;
    icon.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    
    icon.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHeaderHandle)];
    [icon addGestureRecognizer:tap];
    
    
    
    
    icon.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self addSubview:icon];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, VIEW_MAXY(icon)+10, kDeviceWidth, 20)];
    
    label.text = [[PayConfig getUserInfo] valueForKey:@"customerName"];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:15];
    label.numberOfLines = 0;
    label.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    
    [self addSubview:label];
    
}



-(void)tapHeaderHandle
{
    if (self.clickHeaderImageHandle) {
        self.clickHeaderImageHandle();
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
