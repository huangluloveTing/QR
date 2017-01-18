//
//  YYNumberKeyboard.m
//  QRPay
//
//  Created by yy on 16/9/18.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "YYNumberKeyboard.h"


@interface YYNumberKeyboard()

@property (weak, nonatomic) IBOutlet UIView *keyboardView;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIButton *zfbBtn;
@property (weak, nonatomic) IBOutlet UIButton *wxBtn;

@end


@implementation YYNumberKeyboard



-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.resultStr = @"￥0.00";
        
    }
    return self;
}

/*
 1000->0
 1001->1
 1002->2
 1003->3
 1004->4
 1005->5
 1006->6
 1007->7
 1008->8
 1009->9
 1010->.
 1011->00
 1012->删除
 1013->支付宝
 1014->微信

 */



- (IBAction)keyboardViewActionHandle:(UIButton *)sender {
    
    
    NSInteger tag = sender.tag-1000;
    NSString *money = [ self.resultStr substringFromIndex:1];

    switch (tag)
    {
        case 10:
        {
            // 小数点
             _clickPoint = YES;
            
        }
            break;
        case 11:
        {
            // 00
            [self dataHandlingForZeroFigure:-1 currentMoney:money];

            
        }
            break;
        case 12:
        {
            // 删除
            [self deleteFigureWithCurrentMoney:money];

        }
            break;
        case 13:
        {
            // 支付宝
            if ([_delegate respondsToSelector:@selector(getSureBtnTypeString:)]) {
                [_delegate getSureBtnTypeString:@"alipay"];
            }
            return;
            
        }
            break;
            
        case 14:
        {
            //微信
            if ([_delegate respondsToSelector:@selector(getSureBtnTypeString:)]) {
                [_delegate getSureBtnTypeString:@"wechat"];
            }
            return;
            
        }
            break;
            
        case 0:{
            //处理0
            [self dataHandlingForZeroFigure:0 currentMoney:money];

        }
            break;
        default:
            
            [self dataHandlingForNormalFigure:tag currentMoney:money];

            break;
    }

    
    if ([_delegate respondsToSelector:@selector(getResultMoneyString:)]) {
        [_delegate getResultMoneyString:self.resultStr];
    }
    
    
    NSLog(@"------%@",self.resultStr);
}


//处理1--9数字
- (void)dataHandlingForNormalFigure:(NSInteger )figure currentMoney:(NSString *)money
{
    
    NSArray *figureArray = [money componentsSeparatedByString:@"."];
    
    
    if (!_clickPoint) {
        
        if (((NSString *)[figureArray firstObject]).length == 6) {
            return;
        }
        
        long  currentMoney = [[figureArray firstObject] integerValue] * 10 + figure;
        
        self.resultStr = [NSString stringWithFormat:@"￥%ld.%@",currentMoney,[figureArray lastObject]];
        
    }else{
        
        if (((NSString *)[figureArray lastObject]).length == 2) {
            
            
            if ([[figureArray lastObject] integerValue] != 0) {
                
                return;
                
            }else{
                self.resultStr = [NSString stringWithFormat:@"￥%@.%ld",[figureArray firstObject],(long)figure];
            }
            
            
        }else{
            
            self.resultStr = [NSString stringWithFormat:@"￥%@.%@%ld",[figureArray firstObject],[figureArray lastObject],(long)figure];
            
        }
    }
}

//处理0
-(void)dataHandlingForZeroFigure:(NSInteger )figure currentMoney:(NSString* )money
{
    
    NSArray *figureArray = [money componentsSeparatedByString:@"."];
    
    if (_clickPoint) {
        
        if (((NSString *)[figureArray lastObject]).length == 2) {
            
            
            if ([[figureArray lastObject] integerValue] != 0) {
                
                
                if (figure == -1) {
                    self.resultStr = [NSString stringWithFormat:@"￥%@.00",[figureArray firstObject]];
                }
                return;
                
            }else{
                
                if (figure == -1) {
                    
                    self.resultStr = [NSString stringWithFormat:@"￥%@.00",[figureArray firstObject]];
                    
                }else{
                    
                    self.resultStr = [NSString stringWithFormat:@"￥%@.%ld",[figureArray firstObject],figure];
                }
            }
            
            
        }else if(((NSString *)[figureArray lastObject]).length == 1 ){
            
            if (figure == -1) {
                figure = 0;
            }
            self.resultStr= [NSString stringWithFormat:@"￥%@.%@%ld",[figureArray firstObject],[figureArray lastObject],figure];
        }
        
        
    }else{
        
        if (((NSString *)[figureArray firstObject]).length == 6) {
            return;
        }
        
        if (((NSString *)[figureArray lastObject]).length == 1) {
            
            self.resultStr = [NSString stringWithFormat:@"￥%@.%@%ld",[figureArray firstObject],[figureArray lastObject],figure];
            
        }else{
            
            NSInteger currentCount = figure == 0 ? 10 : 100;
            
            
            if (((NSString *)[figureArray firstObject]).length == 5) {
                currentCount = 10;
            }
            
            
            long  currentMoney = [[figureArray firstObject] integerValue] * currentCount;
            
            self.resultStr = [NSString stringWithFormat:@"￥%ld.%@",currentMoney,[figureArray lastObject]];
            
        }
        
    }
}


//处理删除
- (void)deleteFigureWithCurrentMoney:(NSString *)money
{
    NSArray *figureArray = [money componentsSeparatedByString:@"."];
    
    if (_clickPoint) {
        
        if ([[figureArray lastObject] integerValue] == 0) {
            
            _clickPoint = NO;
            
        }else if ([[figureArray lastObject] integerValue] <10){
            
            self.resultStr = [NSString stringWithFormat:@"￥%@.00",[figureArray firstObject]];
            
        }else if ([[figureArray lastObject] integerValue] > 10){
            
            self.resultStr = [NSString stringWithFormat:@"￥%@.%ld",[figureArray firstObject],[[figureArray lastObject] integerValue] / 10];
        }
        
    }else{
        
        long  currentMoney = [[figureArray firstObject] integerValue] / 10 ;
        
        self.resultStr = [NSString stringWithFormat:@"￥%ld.00",currentMoney];
        
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
