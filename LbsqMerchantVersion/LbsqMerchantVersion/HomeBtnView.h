//
//  HomeBtnView.h
//  LbsqMerchantVersion
//
//  Created by Runkun1 on 15/8/19.
//  Copyright (c) 2015年 Runkun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeBtnView : UIView

@property (nonatomic, strong) UIButton *button;

-(id)initWithFrame:(CGRect)frame image:(UIImage *)image title:(NSString *)title;

@end
