//
//  FuctionCollectionViewCell.m
//  QRPay
//
//  Created by 黄露 on 2016/11/17.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "FuctionCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface FuctionCollectionViewCell ()

@property (nonatomic ,strong) UIImageView *imagaView;
@property (nonatomic ,strong) UILabel *titleLabel;
@property (nonatomic ,strong) UIButton *deletBtn;

@end

@implementation FuctionCollectionViewCell

- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1]; 
//        self.layer.borderColor = [[UIColor lightGrayColor]CGColor];
//        self.layer.borderWidth = 0.5;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
    }
    
    return self;
}

- (void) layoutSubviews {
    [self.contentView addSubview:self.imagaView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.deletBtn];
    [self addSeporateLineWithColor:RGBCOLOR(218, 218, 218) andWidth:0.5];

}

#pragma mark -- Private Property 

- (void) addSeporateLineWithColor:(UIColor *)lineColor andWidth:(CGFloat)width {
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_VIEW(self.contentView) - width, 0, width, HEIGHT_VIEW(self.contentView))];
    label2.backgroundColor = lineColor;
    [self.contentView addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, HEIGHT_VIEW(self.contentView) - width, WIDTH_VIEW(self.contentView), width)];
    label3.backgroundColor = lineColor;
    [self.contentView addSubview:label3];
}

-(UIImageView *) imagaView {
    if (!_imagaView) {
        _imagaView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.contentView.bounds) / 2 , CGRectGetWidth(self.contentView.bounds) /  2)];
        
        _imagaView.center = CGPointMake(self.contentView.center.x, self.contentView.center.y - 10);
        
        _imagaView.contentMode = UIViewContentModeScaleAspectFill;
    }
    
    return _imagaView;
}

-(UILabel *) titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , CGRectGetWidth(self.contentView.frame), 30)];
        _titleLabel.center = CGPointMake(self.imagaView.center.x, VIEW_MAXY(self.imagaView) + 5 * PPWidth + HEIGHT_VIEW(_titleLabel) / 2);
        _titleLabel.textColor = [UIColor lightGrayColor];
        _titleLabel.font = [UIFont systemFontOfSize:15 * PPWidth];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _titleLabel;
}

- (UIButton *) deletBtn {
    if (!_deletBtn) {
        _deletBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deletBtn.frame = CGRectMake(CGRectGetMinX(self.imagaView.frame) - 5, CGRectGetMinY(self.imagaView.frame) - 5, 10, 10);
        _deletBtn.backgroundColor = [UIColor redColor];
        _deletBtn.layer.cornerRadius = 2;
        _deletBtn.hidden = YES;
        [_deletBtn addTarget:self action:@selector(tapDeleteBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _deletBtn;
}

#pragma mark -- Property Set Method

- (void) setModel:(FunctionCellModel *)model {
    if (model) {
//        self.imagaView.image = model.image;
        self.titleLabel.text = model.title;
        self.imagaView.image = model.image;
    }
}

- (void) setIsShowDeleteBtn:(BOOL)isShowDeleteBtn {
    
    
    self.deletBtn.hidden = !isShowDeleteBtn;
    
    if (isShowDeleteBtn) {
        [self shakeContentView];
        return;
    }
    
    [self changeScale:1];
}

#pragma mark -- Private Method

- (void) tapDeleteBtnAction {
    if (self.tapDeletBtnBlock) {
        self.tapDeletBtnBlock();
    }
}

- (void) changeScale:(CGFloat)scale {
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.transform = CGAffineTransformMakeScale(scale, scale);
    }];
}

//cell 的摇动动画
- (void) shakeContentView {
    //创建动画对象,绕Z轴旋转
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    //设置属性，周期时长
    [animation setDuration:0.5];
    
    //抖动角度
    animation.fromValue = @(-M_1_PI/5);
    animation.toValue = @(M_1_PI/5);
    //重复次数，无限大
    animation.repeatCount = HUGE_VAL;
    //恢复原样
    animation.autoreverses = YES;
    //锚点设置为图片中心，绕中心抖动
    self.contentView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    
    [self.contentView.layer addAnimation:animation forKey:@"rotation"];
    
    [self changeScale:0.85];
}

@end


#pragma mark --  CellModel

@implementation FunctionCellModel

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.title forKey:@"title"] ;
    [aCoder encodeObject:self.image forKey:@"iconName"];
    [aCoder encodeObject:self.localUrl forKey:@"localUrl"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init] ;
    if(self)
    {
        self.title = [aDecoder decodeObjectForKey:@"title"] ;
        self.image = [aDecoder decodeObjectForKey:@"iconName"] ;
        self.localUrl = [aDecoder decodeObjectForKey:@"localUrl"] ;
    }
    return self ;
}

- (void) setTitle:(NSString *)title {
    if (title) {
        _title = title;
    }
}

- (void) setImage:(UIImage *)image {
    if (image) {
        _image = image;
    }
}

- (void) setLocalUrl:(NSString *)localUrl {
    if (localUrl) {
        _localUrl = localUrl;
    }
}

@end
