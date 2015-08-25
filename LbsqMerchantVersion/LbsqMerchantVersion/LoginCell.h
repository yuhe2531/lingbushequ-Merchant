//
//  LoginHeader.h
//  LbsqMerchantVersion
//
//  Created by Runkun1 on 15/8/25.
//  Copyright (c) 2015年 Runkun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginCell : UIView

@property (nonatomic, strong) UITextField *textField;

-(id)initWithFrame:(CGRect)frame image:(UIImage *)image placeholder:(NSString *)placeholder;

@end
