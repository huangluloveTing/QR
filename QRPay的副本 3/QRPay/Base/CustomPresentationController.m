//
//  CustomPresentationController.m
//  QRPay
//
//  Created by 黄露 on 2016/11/23.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "CustomPresentationController.h"

@interface CustomPresentationController ()

@property (nonatomic ,strong) UIView *behindView;

@end

@implementation CustomPresentationController {
//    CGRect presentedOriginFrame;  //presentedView 原始位置
}

- (instancetype) initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController  {
    if (self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController]) {
    
    }
    
    return self;
}

- (void) presentationTransitionWillBegin {
    [self.containerView addSubview:self.behindView];
    
//    self.presentedView.backgroundColor = [UIColor blueColor];
    id<UIViewControllerTransitionCoordinator> coordinator = self.presentingViewController.transitionCoordinator;
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.behindView.alpha = 1;
        self.behindView.frame = self.containerView.bounds;
        
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
        [UIView animateWithDuration:5.0f animations:^{
            NSLog(@"Will Presentation end");
            self.presentedView.alpha = 1;
            
        }];
        
    }];
}

- (void) presentationTransitionDidEnd:(BOOL)completed {
    if (!completed) {
        [self.behindView removeFromSuperview];
    }
}

- (void) dismissalTransitionWillBegin {
    id<UIViewControllerTransitionCoordinator> coordinator = self.presentingViewController.transitionCoordinator;
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.behindView.alpha = 0;
        
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
    }];
}

- (void) dismissalTransitionDidEnd:(BOOL)completed {
    if (completed) {
        [self.behindView removeFromSuperview];
    }
}

- (CGRect) frameOfPresentedViewInContainerView {
    
    return CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds) - 200 * PPWidth, CGRectGetWidth([UIScreen mainScreen].bounds), 200 * PPWidth);
}


//- (void) setDirection:(CustomPrentedViewAppearDirection)direction {
//    _direction = direction;
//    [self animationWithDirection:direction];
//}

#pragma mark -- Private SetMethod

- (void) animationWithDirection:(CustomPrentedViewAppearDirection)direction {
    /*
    fromTopLeftToRight = 0,     //  从左到右
    fromBottomToTop,            //  从底部到上部
    fromTopRightToLeft,         //  从右边到左边
    fromBottomLeftToTopRight,   //  从左边底部到右上部
    fromShadeToLight
     */
    
//    CGFloat x = [UIScreen mainScreen].bounds.size.width;
//    CGFloat y = [UIScreen mainScreen].bounds.size.height;
//    
//    NSLog(@"framey = %f w= %f",frameY,_presentedViewFrame.size.width);
//    switch (direction) {
//        case fromTopRightToLeft:
//        {
//            
//            presentedOriginFrame = CGRectMake(x, frameY, self.presentedViewFrame.size.width, self.presentedViewFrame.size.height);
//        }
//            break;
//            
//        case fromBottomToTop:
//        {
//            presentedOriginFrame = CGRectMake(frameX, y, self.presentedViewFrame.size.width, self.presentedViewFrame.size.height);
//        }
//            break;
//
//            
//        case fromTopLeftToRight:
//        {
//            presentedOriginFrame = CGRectMake(-x, frameY, self.presentedViewFrame.size.width, self.presentedViewFrame.size.height);
//        }
//            break;
//
//            
//        case fromBottomRightToTopLeft:
//        {
//            presentedOriginFrame = CGRectMake(x, y, self.presentedViewFrame.size.width, self.presentedViewFrame.size.height);
//        }
//            break;
//
//            
//        case fromShadeToLight:
//        {
//            presentedOriginFrame = self.presentedViewFrame;
//            self.presentedView.alpha = 0;
//        }
//            break;
//
//            
//        default:
//            break;
//    }
}

- (UIView *)behindView {
    if (!_behindView) {
        
        _behindView = [[UIView alloc] initWithFrame:CGRectZero];
        _behindView.center = self.containerView.center;
        _behindView.backgroundColor = [UIColor clearColor];
        _behindView.alpha = 0;
        _behindView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressBehindViewAction)];
        
        [_behindView addGestureRecognizer:tap];
    }
    
    return _behindView;
}

#pragma mark -- Private Method
- (void) pressBehindViewAction {
    
    [UIView animateWithDuration:0.25 animations:^{
        
        CGRect frame = self.presentedView.frame;
        frame.origin.y = self.containerView.frame.size.height;
        self.presentedView.frame = frame;
        
    } completion:^(BOOL finished) {
        
        if (self.PressBackgroundViewBlock) {
            self.PressBackgroundViewBlock();
        }
    }];
}

@end
