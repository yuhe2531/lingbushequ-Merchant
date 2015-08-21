//
//  RetrievePWView.h
//  LbsqMerchantVersion
//
//  Created by Runkun1 on 15/8/20.
//  Copyright (c) 2015年 Runkun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CodeBtnBlock)(void);

@interface RetrievePWView : UIView<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *codeTF;
@property (nonatomic, strong) UILabel *codeLabel;
@property (nonatomic, copy) CodeBtnBlock codeBtnBlock;
@property (nonatomic, strong) UIButton *codeBtn;

-(id)initWithFrame:(CGRect)frame title:(NSString *)title;

@end
