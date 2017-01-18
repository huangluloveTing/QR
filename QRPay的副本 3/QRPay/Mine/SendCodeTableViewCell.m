//
//  SendCodeTableViewCell.m
//  QRPay
//
//  Created by 黄露 on 2016/11/24.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "SendCodeTableViewCell.h"

@interface SendCodeTableViewCell () <UITextFieldDelegate>

@property (nonatomic ,strong) UILabel *subTitleLabel;
@property (nonatomic ,strong) UITextField *textField;
@property (nonatomic ,strong) UIButton *sendBtn;
@property (nonatomic ,strong) UILabel *bottomLine;

@end

@implementation SendCodeTableViewCell {
    CGRect titleLabelFrame;
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        titleLabelFrame = CGRectZero;
    }
    return self;
}

- (UILabel *)subTitleLabel {
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] initWithFrame:titleLabelFrame];
        _subTitleLabel.textColor = [UIColor blackColor];
        _subTitleLabel.font = [UIFont systemFontOfSize:14 * PPWidth];
    }
    return _subTitleLabel;
}

- (UITextField *) textField {
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(VIEW_MAXX(self.subTitleLabel), 5, CGRectGetMinX(self.sendBtn.frame) - VIEW_MAXX(self.subTitleLabel) - 5, HEIGHT_VIEW(self) - 10)];
        _textField.textColor = [UIColor darkGrayColor];
        _textField.font = [UIFont systemFontOfSize:14 * PPWidth];
        _textField.textAlignment = NSTextAlignmentRight;
        _textField.delegate = self;
        _textField.returnKeyType = UIReturnKeyDone;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _textField;
}

- (UIButton *)sendBtn {
    if (!_sendBtn) {
        _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendBtn.frame = CGRectMake(WIDTH_VIEW(self.contentView) - 110, 5, 100, HEIGHT_VIEW(self.contentView) - 10);
        [_sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sendBtn setBackgroundColor:[UIColor redColor]];
        _sendBtn.layer.cornerRadius = 5;
        _sendBtn.layer.masksToBounds = YES;
        [_sendBtn addTarget:self action:@selector(sendBtnTapAction:) forControlEvents:UIControlEventTouchUpInside];
        _sendBtn.titleLabel.font = [UIFont systemFontOfSize:14 * PPWidth];
    }
    return _sendBtn;
}

- (UILabel *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UILabel alloc] initWithFrame:CGRectMake(10, VIEW_MAXY(self.contentView) - 0.5, WIDTH_VIEW(self.contentView) - 20, 0.5)];
        _bottomLine.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    }
    return _bottomLine;
}

#pragma mark -- set property 
-(void) setSubTitles:(NSString *)subTitles {
    _subTitles = subTitles;
    
    CGSize size = [subTitles sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14 * PPWidth]}];
    
    titleLabelFrame = CGRectMake(10, 5, size.width, HEIGHT_VIEW(self.contentView) - 10);
    
    [self layoutIfNeeded];
    
    self.subTitleLabel.text = subTitles;
}

- (void) setPlaceholderStr:(NSString *)placeholderStr {
    _placeholderStr = placeholderStr;
    self.textField.placeholder = placeholderStr;
}

- (void) setBtnStr:(NSString *)btnStr {
    _btnStr = btnStr;
    
    [self.sendBtn setTitle:btnStr forState:UIControlStateNormal];
    [self layoutIfNeeded];
}

#pragma mark -- private method
- (void)sendBtnTapAction:(UIButton *)btn {
    if (self.tapSendBtnBlock) {
        self.tapSendBtnBlock(self.textField.text , btn);
    }
}

#pragma mark -- LayoutSubviews
- (void) layoutSubviews {
    [self.contentView addSubview:self.subTitleLabel];
    [self.contentView addSubview:self.textField];
    [self.contentView addSubview:self.sendBtn];
    [self.contentView addSubview:self.bottomLine];
}

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

- (void) textFieldDidEndEditing:(UITextField *)textField {
    self.contentString = textField.text;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.contentString = textField.text;
}

- (BOOL) textFieldShouldEndEditing:(UITextField *)textField {
    
    self.contentString = textField.text;
    return YES;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}

@end
