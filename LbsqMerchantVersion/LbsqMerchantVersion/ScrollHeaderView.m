//
//  ScrollHeaderView.m
//  LbsqMerchantVersion
//
//  Created by Runkun1 on 15/8/19.
//  Copyright (c) 2015年 Runkun. All rights reserved.
//

#import "ScrollHeaderView.h"

@implementation ScrollHeaderView

-(id)initWithFrame:(CGRect)frame titles:(NSArray *)titles
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createScrollHeaderSubviewsWithTitles:titles];
    }
    return self;
}

#define kScrollTitle_count 3

#define kMarkLine_height 3

-(void)createScrollHeaderSubviewsWithTitles:(NSArray *)titles
{
    CGFloat titleWidth = kScreen_width / kScrollTitle_count;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreen_width, self.height)];
//    _scrollView.backgroundColor = [UIColor redColor];
    _scrollView.contentSize = CGSizeMake(titleWidth * kScrollTitle_count, self.height);
    [self addSubview:_scrollView];

    for (int i = 0; i < titles.count; i++) {
        
        UIButton *button = [ControlExtension buttonInitWithFrame:CGRectMake(titleWidth*i, 0, titleWidth, self.height) title:titles[i] style:UIButtonTypeSystem font:kFontSize_2 titleColor:kBlack_Color_1];
        button.tag = 250 + i;
        [button addTarget:self action:@selector(scrollBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:button];
        
    }
    
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.height, self.width, 0.5)];
    bottomLine.backgroundColor = kDividColor;
    [self addSubview:bottomLine];
    
    _markLine = [[UIView alloc] initWithFrame:CGRectMake(0, _scrollView.height-kMarkLine_height, titleWidth, kMarkLine_height)];
    _markLine.backgroundColor = [UIColor greenColor];
    [_scrollView addSubview:_markLine];
}

-(void)scrollBtnAction:(UIButton *)button
{
    if (self.scrollHeaderBlock) {
        self.scrollHeaderBlock(button);
    }
    CGFloat titleWidth = kScreen_width / kScrollTitle_count;
    [UIView animateWithDuration:0.5 animations:^{
        _markLine.left = (button.tag-250) * titleWidth;
    }];
}

-(void)setMoveStep:(NSInteger)moveStep
{
    _moveStep = moveStep;
    CGFloat titleWidth = kScreen_width / kScrollTitle_count;
    [UIView animateWithDuration:0.5 animations:^{
        _markLine.left = _moveStep * titleWidth;
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
