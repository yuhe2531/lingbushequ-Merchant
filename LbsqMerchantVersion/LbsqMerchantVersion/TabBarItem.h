//
//  TabBarItem.h
//  LbsqMerchantVersion
//
//  Created by Runkun1 on 15/8/18.
//  Copyright (c) 2015年 Runkun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabBarItem : UIView

@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, strong) UIButton *button;

-(id)initWithFrame:(CGRect)frame image:(UIImage *)image title:(NSString *)title selectedImage:(UIImage *)selectedImage;

@end
