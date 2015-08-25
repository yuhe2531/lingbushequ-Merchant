//
//  LoginHeader.m
//  LbsqMerchantVersion
//
//  Created by Runkun1 on 15/8/25.
//  Copyright (c) 2015年 Runkun. All rights reserved.
//

#import "LoginCell.h"

@implementation LoginCell

-(id)initWithFrame:(CGRect)frame image:(UIImage *)image placeholder:(NSString *)placeholder
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 5;
        self.layer.borderColor = kDividColor.CGColor;
        self.layer.borderWidth = 0.5;
        [self createLoginHeaderSubviewsWithImage:image placeholder:placeholder];
    }
    return self;
}

-(void)createLoginHeaderSubviewsWithImage:(UIImage *)image placeholder:(NSString *)placeholder
{
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, self.height)];
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    imageV.backgroundColor = KRandomColor;
    imageV.center = CGPointMake(view.width/2, view.height/2);
    [view addSubview:imageV];
    _textField.leftView = view;
    _textField.leftViewMode = UITextFieldViewModeAlways;
    _textField.textColor = kBlack_Color_1;
    _textField.font = [UIFont systemFontOfSize:kFontSize_1];
    _textField.placeholder = placeholder;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self addSubview:_textField];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
