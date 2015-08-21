//
//  ScrollHeaderView.h
//  LbsqMerchantVersion
//
//  Created by Runkun1 on 15/8/19.
//  Copyright (c) 2015年 Runkun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ScrollHeaderClicked)(UIButton *);

@interface ScrollHeaderView : UIView

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *markLine;

@property (nonatomic, assign) NSInteger moveStep;
@property (nonatomic, copy) ScrollHeaderClicked scrollHeaderBlock;

-(id)initWithFrame:(CGRect)frame titles:(NSArray *)titles;

@end
