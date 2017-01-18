//
//  NotesDetailViewController.m
//  QRPay
//
//  Created by 黄露 on 2016/11/29.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "NotesDetailViewController.h"

@interface NotesDetailViewController ()

@property (nonatomic ,strong) UIScrollView *scrolView;

@property (nonatomic ,strong) UILabel *mainTitleLabel;

@property (nonatomic ,strong) UILabel *timeLabel;

@property (nonatomic ,strong) UILabel *contentLabel;

@end

@implementation NotesDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"公告详情";
    self.navigationItem.leftBarButtonItem = self.leftBarButton;
    
    [self.view addSubview:self.scrolView];
    [self.scrolView addSubview:self.mainTitleLabel];
    [self.scrolView addSubview:self.timeLabel];
    [self.scrolView addSubview:self.contentLabel];
    self.view.backgroundColor = TABLEVIEW_GROUPED_BGCOLOR;
}

- (CGSize) sizeWithString:(NSString *)str andFont:(UIFont *)font constrainsSize:(CGSize)constrainsSize {
    
    NSMutableParagraphStyle *paragraphstyle=[[NSMutableParagraphStyle alloc]init];
    
    paragraphstyle.lineBreakMode=NSLineBreakByCharWrapping;
    
    CGRect rect = [str boundingRectWithSize:constrainsSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphstyle.copy} context:nil];
    
    NSLog(@"w = %f   h = %f",rect.size.width ,rect.size.height);
    
    return rect.size;
}

- (UILabel *)mainTitleLabel {
    if (!_mainTitleLabel) {
        _mainTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _mainTitleLabel.text = self.notesTitle;
        _mainTitleLabel.font = [UIFont systemFontOfSize:22 * PPWidth];
        _mainTitleLabel.textColor = [UIColor blackColor];
        _mainTitleLabel.numberOfLines = 0;
        _mainTitleLabel.textAlignment = NSTextAlignmentCenter;
        CGSize size = [self sizeWithString:self.notesTitle andFont:_mainTitleLabel.font constrainsSize:CGSizeMake(WIDTH_VIEW(self.view), 1000)];
        _mainTitleLabel.frame = CGRectMake(0, 5, WIDTH_VIEW(self.view), size.height);
    }
    
    return _mainTitleLabel;
}

-(UILabel *)timeLabel {
    if (!_timeLabel) {
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.numberOfLines = 0;
        _timeLabel.textColor = [UIColor blackColor];
        _timeLabel.font = [UIFont systemFontOfSize:16 * PPWidth];
        _timeLabel.text = self.notesTime;
        CGSize size = [self sizeWithString:_timeLabel.text andFont:_timeLabel.font constrainsSize:CGSizeMake(WIDTH_VIEW(self.view), 1000)];
        
        _timeLabel.frame = CGRectMake(0, VIEW_MAXY(self.mainTitleLabel) + 5, WIDTH_VIEW(self.view), size.height + 1);
        
        UILabel *bottomLine = [[UILabel alloc] initWithFrame:CGRectMake(10, HEIGHT_VIEW(_timeLabel) - 1, WIDTH_VIEW(_timeLabel) - 20, 1)];
        
        bottomLine.backgroundColor = TABLEVIEW_GROUPED_BGCOLOR;
        [_timeLabel addSubview:bottomLine];
    }
    
    return _timeLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.numberOfLines = 0;
        _contentLabel.textColor = [UIColor blackColor];
        _contentLabel.font = [UIFont systemFontOfSize:16 * PPWidth];
        _contentLabel.text = self.contentString;
        CGSize size = [self sizeWithString:_contentLabel.text andFont:_contentLabel.font constrainsSize:CGSizeMake(WIDTH_VIEW(self.view), 1000)];
        _contentLabel.frame = CGRectMake(0, VIEW_MAXY(self.timeLabel) + 5, WIDTH_VIEW(self.view), size.height);
        _contentLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    return _contentLabel;
}

- (UIScrollView *) scrolView {
    if (!_scrolView) {
        
        CGFloat scrollView_H = HEIGHT_VIEW(self.mainTitleLabel) + HEIGHT_VIEW(self.timeLabel) + HEIGHT_VIEW(self.contentLabel) + 20;
        
        NSLog(@"h = %f",scrollView_H);
        
        CGFloat contentSize_H = scrollView_H;
        
        scrollView_H = scrollView_H > HEIGHT_VIEW(self.view) - 64 - 10 ? HEIGHT_VIEW(self.view) - 64 - 10: scrollView_H;
        
        _scrolView = [[UIScrollView alloc] initWithFrame:CGRectMake( 0, 10, WIDTH_VIEW(self.view), scrollView_H)];
        _scrolView.backgroundColor = [UIColor whiteColor];
        _scrolView.contentSize = CGSizeMake(WIDTH_VIEW(self.view), contentSize_H);
    }
    
    return _scrolView;
}

@end
