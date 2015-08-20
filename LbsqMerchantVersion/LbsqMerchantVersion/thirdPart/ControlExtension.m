//
//  ControlExtension.m
//  LbsqMerchantVersion
//
//  Created by Runkun1 on 15/8/19.
//  Copyright (c) 2015年 Runkun. All rights reserved.
//

#import "ControlExtension.h"

@implementation ControlExtension

+(UILabel *)labelInitWithFrame:(CGRect)rect title:(NSString *)title font:(NSInteger)font textAlignment:(NSTextAlignment)alignment
{
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.font = [UIFont systemFontOfSize:font];
    label.textAlignment = alignment;
    label.text = title;
    return label;
}

+(UIButton *)buttonInitWithFrame:(CGRect)rect title:(NSString *)title style:(UIButtonType)type font:(NSInteger)font titleColor:(UIColor *)titleColor
{
    UIButton *button = [UIButton buttonWithType:type];
    button.frame = rect;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    return button;
}

@end
