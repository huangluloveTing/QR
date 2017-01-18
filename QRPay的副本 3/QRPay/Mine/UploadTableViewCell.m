//
//  UploadTableViewCell.m
//  QRPay
//
//  Created by 黄露 on 2016/11/22.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "UploadTableViewCell.h"


@interface UploadTableViewCell ()<UITextFieldDelegate>

@property (nonatomic ,strong) UILabel *markLabel;
@property (nonatomic ,strong) UITextField *contentTextField;
@property (nonatomic ,strong) UILabel *bottomLine;


@end
@implementation UploadTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
    }
    
    return self;
}

- (void) layoutSubviews {
    
    [self.contentView addSubview:self.markLabel];
    [self.contentView addSubview:self.contentTextField];
    [self.contentView addSubview:self.bottomLine];
    
}

- (UILabel *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UILabel alloc] initWithFrame:CGRectMake(10, VIEW_MAXY(self.contentView) - 0.5, WIDTH_VIEW(self.contentView) - 20, 0.5)];
        _bottomLine.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    }
    return _bottomLine;
}

- (UILabel *)markLabel {
    if (!_markLabel) {
        _markLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _markLabel.font = [UIFont systemFontOfSize:14 * PPWidth];
        _markLabel.textColor = [UIColor blackColor];
        _markLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    return _markLabel;
}

- (UITextField *) contentTextField {
    if (!_contentTextField) {
        _contentTextField = [[UITextField alloc] initWithFrame:CGRectMake(VIEW_MAXX(self.markLabel) , 0, WIDTH_VIEW(self.contentView) - VIEW_MAXX(self.markLabel) - 10, HEIGHT_VIEW(self.contentView))];
        _contentTextField.textColor = [UIColor lightGrayColor];
        _contentTextField.font = [UIFont systemFontOfSize:14 * PPWidth];
        _contentTextField.textAlignment = NSTextAlignmentRight;
        _contentTextField.delegate = self;
        _contentTextField.returnKeyType = UIReturnKeyDone;
        _contentTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    
    return _contentTextField;
}

- (void) setMarkTitle:(NSString *)markTitle {
    if (markTitle) {
        
        self.markLabel.text = markTitle;
        
        CGSize labelSize = [self.markLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14 * PPWidth]}];
        
        self.markLabel.frame = CGRectMake(10, 0, labelSize.width, HEIGHT_VIEW(self.contentView));
        
        [self layoutIfNeeded];
    }
}

- (void) setContentString:(NSString *)contentString {
    _contentString = contentString;
    self.contentTextField.text = contentString;
    
}

- (void) setIsShowKeyboard:(BOOL)isShowKeyboard {
    _isShowKeyboard = isShowKeyboard;
}

- (void) setPlaceholderStr:(NSString *)placeholderStr {
    self.contentTextField.placeholder = placeholderStr;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (!_isShowKeyboard) {
    
        if (self.PressTextFieldBlock) {
            self.PressTextFieldBlock(self);
        }
    }
    
    return _isShowKeyboard;
}

- (void) textFieldDidEndEditing:(UITextField *)textField {
    self.contentString = textField.text;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    
    [_contentTextField resignFirstResponder];
    return YES;
}

- (void) setKeyBoardType:(UIKeyboardType)keyBoardType {
    _keyBoardType = keyBoardType;
    self.contentTextField.keyboardType = keyBoardType;
}


@end
