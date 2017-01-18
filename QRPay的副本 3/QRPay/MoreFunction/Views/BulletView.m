//
//  BulletView.m
//  QRPay
//
//  Created by 黄露 on 2016/11/17.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "BulletView.h"

@interface BulletView ()

//弹幕的model数组
@property (nonatomic ,strong) NSArray<BulletViewModel *> *bulletTitles;
@property (nonatomic ,strong) UIImageView *noteImageView;

@end

@implementation BulletView {
    NSArray *bulletLabels; //弹幕数组
    
    CGFloat bulletMoveSpeed; //弹幕速度
    
    NSTimer *timer; //定时发射弹幕
    
    NSInteger currentBulletIndex; //弹幕开始，获取当前的弹幕数组的index
}

#pragma  mark -- INIT Method
- (instancetype) initWithFrame:(CGRect)frame andTitles:(NSArray *)bulletTitles {
    
    if (self = [super initWithFrame:frame]) {
        
        bulletMoveSpeed = 5.0f;
        
        self.bulletTitles = bulletTitles;
        
        [self creatTitleLabels];
    }
    
    return self;
}

#pragma mark -- private Method
- (void) creatTimer {
    timer = [NSTimer scheduledTimerWithTimeInterval:bulletMoveSpeed + 1 target:self selector:@selector(startShootBullet) userInfo:nil repeats:YES];
}

- (void) creatTitleLabels {
    
    NSMutableArray *labels = [NSMutableArray array];
    
    if (self.bulletTitles && self.bulletTitles.count > 0) {
        
        for (BulletViewModel *model in self.bulletTitles) {
            NSString *message = model.message;
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.text = message;
            label.textColor = [UIColor lightGrayColor];
            label.font = [UIFont systemFontOfSize:14 * PPWidth];
            [labels addObject:label];
        }
        
        bulletLabels = [NSArray arrayWithArray:labels];
        
        for (UILabel *label in bulletLabels) {
            
            CGSize size = [self sizeForLabel:label];
            CGFloat y = (self.bounds.size.height - size.height) / 2;
            label.frame = CGRectMake(self.bounds.size.width, y, size.width, size.height);
            
            [self addSubview:label];
        }
        
        [self addSubview:self.noteImageView];
    }
}

- (void) startShootBullet {
    
    if (currentBulletIndex >= bulletLabels.count) {
        currentBulletIndex = 0;
    }
    
    [self startShootBullet:currentBulletIndex];
}

- (void) startShootBullet:(NSInteger) bulletNum {
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:bulletMoveSpeed delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        UILabel *label = bulletLabels[bulletNum];
        
        CGRect frame = label.frame;
        
        frame.origin.x = -weakSelf.bounds.size.width;
        
        label.frame = frame;
        
    } completion:^(BOOL finished) {
        
        UILabel *label = bulletLabels[bulletNum];
        
        CGRect frame = label.frame;
        
        frame.origin.x = self.bounds.size.width;
        
        label.frame = frame;
        
        if (finished) {
            currentBulletIndex += 1;
        }
    }];
}

//- (void) startShootBullet:(NSInteger) bulletNum {
//
//    UILabel *label = bulletLabels[bulletNum];
//
//    CGRect startstlabelframe = label.frame;
//    CGRect endLabelFrame = startstlabelframe;
//    endLabelFrame.origin.x = -self.bounds.size.width;
//    
//    //创建动画对象
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
//    
//    //设置属性，周期时长
//    [animation setDuration:bulletMoveSpeed];
//    NSValue *startframe = [NSValue valueWithCGRect:startstlabelframe];
//    NSValue *endframe = [NSValue valueWithCGRect:endLabelFrame];
//    
//    //抖动角度
//    animation.fromValue = startframe;
//    animation.toValue = endframe;
//    
//    //重复次数，无限大
//    animation.repeatCount = 1;
//    //恢复原样
//    animation.autoreverses = NO;
//    //锚点设置为图片中心，绕中心抖动
//  
//    [label.layer addAnimation:animation forKey:@"posiztion"];
//    
//    currentBulletIndex ++;
//}

- (CGSize) sizeForLabel:(UILabel *) label {
    
    CGSize size =[label.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14 * PPWidth]}];
    
    return size;
}

#pragma mark -- Public Method

- (void) startShoot {
    currentBulletIndex = 0;
    [self startShootBullet:0];
    [self creatTimer];
}

- (void) stopShoot {

    [timer invalidate];
}

#pragma mark -- Property 

- (UIImageView *) noteImageView {
    if (!_noteImageView) {
        
        _noteImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetHeight(self.frame) + 10 * PPWidth, CGRectGetHeight(self.frame))];
        
        _noteImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        _noteImageView.backgroundColor = [UIColor whiteColor];
    }
    
    return _noteImageView;
}

- (void) setNoteImage:(UIImage *)noteImage {
    if (noteImage) {
        
        self.noteImageView.image = noteImage;
    }
}

- (void) setMoveSpeed:(CGFloat)moveSpeed {
    
    if (moveSpeed) {
        bulletMoveSpeed = moveSpeed;
    }
}

- (void) setTitleColor:(UIColor *)titleColor {
    if (titleColor) {
        
        for (UILabel *label in bulletLabels) {
            label.textColor = titleColor;
        }
    }
}

- (void) setTitleFont:(UIFont *)titleFont {
    if (titleFont) {
        for (UILabel *label in bulletLabels) {
            label.font = titleFont;
            CGSize size = [self sizeForLabel:label];
            CGFloat y = (self.bounds.size.height - size.height) / 2;
            label.frame = CGRectMake(self.bounds.size.width, y, size.width, size.height);
            
            [self addSubview:label];
        }
    }
}

- (void) setBorderWith:(CGFloat)borderWith {
    if (borderWith) {
        self.layer.borderWidth = borderWith;
    }
}

- (void) setBorderColor:(UIColor *)borderColor {
    if (borderColor) {
        self.layer.borderColor = borderColor.CGColor;
    }
}

@end

@implementation BulletViewModel

@end
