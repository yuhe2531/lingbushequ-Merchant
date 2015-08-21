//
//  ScrollHeaderView.h
//  LbsqMerchantVersion
//
//  Created by Runkun1 on 15/8/19.
//  Copyright (c) 2015年 Runkun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollHeaderView : UIView

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *markLine;

@property (nonatomic, assign) NSInteger moveStep;

-(id)initWithFrame:(CGRect)frame titles:(NSArray *)titles;

@end
