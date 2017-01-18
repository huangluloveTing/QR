//
//  GuiderView.m
//  QRPay
//
//  Created by 黄露 on 2016/11/19.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "NewGuiderView.h"

@interface NewGuiderView () <UIScrollViewDelegate>

@property (nonatomic ,strong) UIScrollView *mainView;  //显示图片的ScrollView

@property (nonatomic ,strong) UIButton *openBtn;        //离开按钮

@property (nonatomic ,strong) UIWindow *window;

@property (nonatomic ,strong) NSTimer *timer;           //自动播放计时器

@property (nonatomic ,strong) UIPageControl *pageControl;

@end

@implementation NewGuiderView

-(instancetype) init {
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
    }
    
    return self;
}

- (void) layoutSubviews {
    [self addSubview:self.mainView];
    [self addSubview:self.pageControl];
}

- (UIScrollView *) mainView {
    if (!_mainView) {
        _mainView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _mainView.showsVerticalScrollIndicator = NO;
        _mainView.showsHorizontalScrollIndicator = NO;
        _mainView.backgroundColor = [UIColor whiteColor];
        _mainView.pagingEnabled = YES;
        _mainView.bounces = NO;
        _mainView.bouncesZoom = NO;
        _mainView.delegate = self;
    }
    
    return _mainView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width / 2, 40)];
        _pageControl.center = CGPointMake(self.center.x, self.bounds.size.height - 50);
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _pageControl.pageIndicatorTintColor = [UIColor blueColor];
        _pageControl.numberOfPages = 4;
    }
    
    return _pageControl;
}

- (UIButton *)openBtn {
    if (!_openBtn) {
        _openBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _openBtn.frame = CGRectMake(0, 0, 100, 40);
        _openBtn.center = self.center;
        [_openBtn setTitle:@"致富之旅" forState:UIControlStateNormal];
        [_openBtn setBackgroundColor:[UIColor redColor]];
        [_openBtn addTarget:self action:@selector(tapOpenBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _openBtn;
}


- (void) setImages:(NSArray<UIImage *> *)images {
    _images = images;
    self.pageControl.numberOfPages = images.count;
    if (images.count > 0) {
        for (int i = 0; i < images.count; i ++) {
            UIImage *image = [images objectAtIndex:i];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height)];
            imageView.image = image;
            imageView.contentMode = UIViewContentModeScaleToFill;
            [self.mainView addSubview:imageView];
            imageView.userInteractionEnabled = YES;
            
            if (i == images.count - 1) {
                [imageView addSubview:self.openBtn];
            }
        }
        
        self.mainView.contentSize = CGSizeMake(self.bounds.size.width * images.count, self.bounds.size.height);
        self.mainView.contentOffset = CGPointMake(0, 0);
    }
}

- (void) setIsShowPageControl:(BOOL)isShowPageControl {
    self.pageControl.hidden = !isShowPageControl;
}

- (void) setDuration:(CGFloat)duration {
    
}

- (void) setBtnBgColor:(UIColor *)btnBgColor {
    self.openBtn.backgroundColor = btnBgColor;
}

- (void) setBtnTitleColor:(UIColor *)btnTitleColor {
    [self.openBtn setTitleColor:btnTitleColor forState:UIControlStateNormal];
}

- (void) setOpenBtnTitle:(NSString *)openBtnTitle {
    [self.openBtn setTitle:openBtnTitle forState:UIControlStateNormal];
}

- (void) setBtnBgImage:(UIImage *)btnBgImage {
    [self.openBtn setBackgroundImage:btnBgImage forState:UIControlStateNormal];
}

- (void) setBtnborderRudius:(CGFloat)btnborderRudius {
    self.openBtn.layer.cornerRadius = btnborderRudius;
}

- (void) setOpenBtnCenterPoint:(CGPoint)openBtnCenterPoint {
    self.openBtn.center = openBtnCenterPoint;
}

- (void) tapOpenBtnAction {
    NSLog(@"点击进入主页面的按钮。-- 》 离开新手导航页");
    [self animationToDismiss];
}

- (void) animationToDismiss {
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.frame;
        frame.origin.x = -self.bounds.size.width;
        self.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.window resignKeyWindow];
    }];
}


#pragma mark -- Public Method

- (void) showLaunchView {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.windowLevel = UIWindowLevelAlert;
    [self.window becomeKeyWindow];
    [self.window makeKeyAndVisible];
    [self.window addSubview:self];
}

#pragma mark -- UIScrollViewDelegate
- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetX = scrollView.contentOffset.x;
    
    int num = round(offsetX / self.bounds.size.width ); //四舍五入取整数
    
    self.pageControl.currentPage = num;
}

- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    if (offset.x == scrollView.contentSize.width - scrollView.bounds.size.width) {
        [self animationToDismiss];
    }
}

@end
