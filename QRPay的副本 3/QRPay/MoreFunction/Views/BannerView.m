//
//  BannerView.m
//  QRPay
//
//  Created by 黄露 on 2016/11/17.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "BannerView.h"
#import "UIImageView+WebCache.h"

#define SCRW (self.bounds.size.width) //scrollView 的宽度
#define INTERVAL (5)

@interface BannerView ()<UIScrollViewDelegate>

@property (nonatomic ,strong) UIPageControl *pageControl;
@property (nonatomic ,strong) UIScrollView *scrollView;
@property (nonatomic ,strong) NSTimer *timer;

@end

@implementation BannerView {
    NSArray *allTitleLabels; //保存所有titleLabel ，用于修改其中的属性
}

- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        NSLog(@"frame.h = %f",frame.size.height);
        
        
    }
    return self;
}

- (void) layoutSubviews {
    
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
    self.pageControl.frame = CGRectMake(0, 0, 200, 20);
    self.pageControl.center = CGPointMake(SCRW / 2, CGRectGetMaxY(self.scrollView.frame) - 15);
}

#pragma mark -- INIT private property

- (void) setPageControlIndicatorColor:(UIColor *)pageControlIndicatorColor {
    if (pageControlIndicatorColor) {
        self.pageControl.pageIndicatorTintColor = pageControlIndicatorColor;
    }
}

- (void) setPageControlCurrentIndicatorColor:(UIColor *)pageControlCurrentIndicatorColor {
    
    if (pageControlCurrentIndicatorColor ) {
        self.pageControl.currentPageIndicatorTintColor = pageControlCurrentIndicatorColor;
    }
}

- (void) setTitleColor:(UIColor *)titleColor {
    if (titleColor) {
        for (UILabel *label in allTitleLabels) {
            label.textColor = titleColor;
        }
    }
}

- (void) setTitleFontSize:(CGFloat)titleFontSize {
    if (titleFontSize) {
        for (UILabel *label in allTitleLabels) {
            label.font = [UIFont systemFontOfSize:titleFontSize];
        }
    }
}

- (void) setTitlePlace:(TitlePlace)titlePlace {
    if (titlePlace) {
        switch (titlePlace) {
            case titleInLeft:
            {
                for (UILabel *label in allTitleLabels) {
                    label.textAlignment = NSTextAlignmentLeft;
                }
                break;
            }
                
            case titleInCenter:
            {
                for (UILabel *label in allTitleLabels) {
                    label.textAlignment = NSTextAlignmentCenter;
                }
                break;
            }
                
            case TitleInRight:
            {
                for (UILabel *label in allTitleLabels) {
                    label.textAlignment = NSTextAlignmentRight;
                }
                break;
            }
                
            default:
                break;
        }
    }
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        [_pageControl addTarget:self action:@selector(pageControlAction:) forControlEvents:UIControlEventTouchUpInside];
        _pageControl.numberOfPages = self.models.count;
    }
    return _pageControl;
}

- (UIScrollView *) scrollView {
    if (!_scrollView ) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0.01, WIDTH_VIEW(self), HEIGHT_VIEW(self) - 0.02)];
        
        _scrollView.showsVerticalScrollIndicator = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
    }
    
    return _scrollView;
}


#pragma mark -- Public property

- (void) setModels:(NSArray<BannerViewModel *> *)models {
    
    _models = models;
    
    NSMutableArray *tempTitlealbels = [NSMutableArray array];
        
    if (models && models.count > 0) {

        for (int i = 0; i < models.count; i ++) {
            
            BannerViewModel *model = models[i];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * SCRW, 0, SCRW, CGRectGetHeight(self.scrollView.frame))];
            imageView.userInteractionEnabled = YES;
            imageView.tag = 100 + i;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageAction:)];
            
            [imageView addGestureRecognizer:tapGesture];
            
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            
            if (model.imageUrl) {
                [imageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:model.placeholderImage];
            }
            
            else {
                imageView.image = model.placeholderImage;
            }
            
            [self.scrollView addSubview:imageView];
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(imageView.frame) - 40, SCRW - 20, 30)];
            
            NSLog(@"imageMaxy = %f,minY = %f",VIEW_MAXY(imageView),CGRectGetMinY(imageView.frame));
            
            titleLabel.text = model.title;
            titleLabel.font = [UIFont systemFontOfSize:16];
            titleLabel.textColor = [UIColor darkGrayColor];
            
            [imageView addSubview:titleLabel];
            
            [tempTitlealbels addObject:titleLabel];
        }
        
        allTitleLabels = [NSArray arrayWithArray:tempTitlealbels];
        self.scrollView.contentSize = CGSizeMake(SCRW * models.count, HEIGHT_VIEW(self.scrollView));
        
        NSLog(@"contentSize : w = %f , h = %f , inset : x = %f,y = %f, offset : x = %f , y = %f",self.scrollView.contentSize.width,self.scrollView.contentSize.height,self.scrollView.contentInset.top,self.scrollView.contentInset.bottom,self.scrollView.contentOffset.x,self.scrollView.contentOffset.y);
        
        [self setNeedsLayout];
        
        self.pageControl.numberOfPages = models.count;
        
        [self addTimerWithtimeInterval:INTERVAL];
    }

}

- (void) setDuration:(NSTimeInterval)duration {
    if (duration) {
        [self removeTimer];
        
        [self addTimerWithtimeInterval:duration];
    }
}

- (void) setPageControlPlace:(pageControlPlace)pageControlPlace {
    CGFloat pageControlWidth = self.pageControl.frame.size.width;
    CGFloat pageControlHeight = self.pageControl.frame.size.height;
    CGFloat centerX = self.scrollView.frame.size.width / 2;
    CGFloat centerY = self.scrollView.frame.size.height / 2;
    
    if (pageControlPlace) {
        switch (pageControlPlace) {
            case pageControlPlaceInTopLeft:
            {
                self.pageControl.center = CGPointMake(pageControlWidth / 2, pageControlHeight / 2);
                break;
            }
                
            case pageControlPlaceInTopCentr:
            {
                self.pageControl.center = CGPointMake(centerX, pageControlHeight / 2);
                break;
            }
                
            case pageControlPlaceInTopRight:
            {
                self.pageControl.center = CGPointMake(centerX * 2 - pageControlWidth / 2, pageControlHeight / 2);
                break;
            }
                
            case pageControlPlaceInCenter:
            {
                self.pageControl.center = CGPointMake(centerX, centerY);
                break;
            }
                
            case pageControlPlaceInBottomLeft:
            {
                self.pageControl.center = CGPointMake(pageControlWidth / 2 , centerY * 2 - pageControlHeight / 2);
                break;
            }
                
            case pageControlPlaceInBottomCenter:
            {
                self.pageControl.center = CGPointMake(centerX, centerY * 2 - pageControlHeight / 2);
                break;
            }
                
            case pageControlPlaceInbottomRight:
            {
                self.pageControl.center = CGPointMake(centerX * 2 - pageControlWidth / 2, centerY * 2 - pageControlHeight / 2 );
                break;
            }
                
            default:
                break;
        }
    }
}

- (void) setIsShowTitleLabel:(BOOL)isShowTitleLabel {
    
    for (UILabel *label in allTitleLabels) {
        label.hidden = !isShowTitleLabel;
    }
}

- (void) setIsShowPageControl:(BOOL)isShowPageControl {
    self.pageControl.hidden = !isShowPageControl;
}

#pragma mark -- private Method

- (void)tapImageAction:(UITapGestureRecognizer *)sender {
    UIImageView *imageView = (UIImageView *)sender.view;
    
    NSInteger tag = imageView.tag - 100;
    
    NSString *destUrl = ((BannerViewModel *)self.models[tag]).destinationUrl;
    
    if (self.tapBannerImage) {
        self.tapBannerImage(destUrl);
    }
}

- (void)pageControlAction:(UIPageControl *)sender {
    [self pageControlMoveToNextNum:sender.currentPage];
}

- (void)addTimerWithtimeInterval:(NSTimeInterval)interval {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
}

- (void) removeTimer {
    [self.timer invalidate];
}

- (void) timerAction {
    
    NSInteger index = self.pageControl.currentPage + 1;
    
    [self pageControlMoveToNextNum:index];
}

- (void) pageControlMoveToNextNum:(NSInteger ) num {
    if (num >= self.models.count) {
        num = 0 ;
    }
    
    CGFloat offsetX = num * SCRW;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.scrollView.contentOffset = CGPointMake(offsetX, 0);
    }];
}

#pragma mark -- UIScrollView Delegate
- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetX = self.scrollView.contentOffset.x;

    int num = round(offsetX / SCRW ); //四舍五入取整数
    
    self.pageControl.currentPage = num;
}

- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self removeTimer];
}

- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (self.duration) {
        [self addTimerWithtimeInterval:self.duration];
        
        return;
    }
    
    [self addTimerWithtimeInterval:INTERVAL];
}

@end


@implementation BannerViewModel

@end
