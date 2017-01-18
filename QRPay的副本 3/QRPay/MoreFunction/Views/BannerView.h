//
//  BannerView.h
//  QRPay
//
//  Created by 黄露 on 2016/11/17.
//  Copyright © 2016年 yy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , pageControlPlace){
    pageControlPlaceInTopLeft = 0,
    pageControlPlaceInTopCentr,
    pageControlPlaceInTopRight,
    pageControlPlaceInCenter,
    pageControlPlaceInBottomLeft,
    pageControlPlaceInBottomCenter,
    pageControlPlaceInbottomRight
};

typedef NS_ENUM(NSInteger , TitlePlace){
    titleInLeft = 0,
    titleInCenter,
    TitleInRight
};

@interface BannerViewModel : NSObject

/**
 * bannerView 上的model
 *
 * @param   title               图片对应的标题
 * @param   placeholderImage    没有网络图片的站位图片
 * @param   destinationUrl      点击图片的目标URL
 * @param   imageUrl            图片的URL
 */
@property (nonatomic ,copy) NSString *title;
@property (nonatomic ,strong) UIImage *placeholderImage;
@property (nonatomic ,copy) NSString *destinationUrl;
@property (nonatomic ,copy) NSString *imageUrl;

@end


@interface BannerView : UIView

//pageControl 的颜色
@property (nonatomic ,strong) UIColor *pageControlIndicatorColor;

//pageControl 当前页码的颜色
@property (nonatomic ,strong) UIColor *pageControlCurrentIndicatorColor;

//pageControl 的位置
@property (nonatomic ,assign) pageControlPlace pageControlPlace;

//title 的颜色
@property (nonatomic ,strong) UIColor *titleColor;

//title的font-Size
@property (nonatomic ,assign) CGFloat titleFontSize;

//title 的位置 ----> 目前只支持左边，中间，右边
@property (nonatomic ,assign) TitlePlace titlePlace;

//轮播图片的间隙
@property (nonatomic ,assign) NSTimeInterval duration;

@property (nonatomic ,strong) NSArray<BannerViewModel *> *models; //bannerView 的model

@property (nonatomic ,assign) void (^tapBannerImage)(NSString *);

@property (nonatomic ,assign) BOOL isShowPageControl; //是否显示pageControl
@property (nonatomic ,assign) BOOL isShowTitleLabel;  //是否显示title

@end
