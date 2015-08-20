//
//  ControlExtension.h
//  LbsqMerchantVersion
//
//  Created by Runkun1 on 15/8/19.
//  Copyright (c) 2015年 Runkun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ControlExtension : NSObject

+(UILabel *)labelInitWithFrame:(CGRect)rect title:(NSString *)title font:(NSInteger)font textAlignment:(NSTextAlignment)alignment;

+(UIButton *)buttonInitWithFrame:(CGRect)rect title:(NSString *)title style:(UIButtonType)type font:(NSInteger)font titleColor:(UIColor *)titleColor;

@end
