//
//  AddGoodsView.m
//  LbsqMerchantVersion
//
//  Created by Runkun1 on 15/8/20.
//  Copyright (c) 2015年 Runkun. All rights reserved.
//

#import "AddGoodsView.h"

@implementation AddGoodsView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createAddGoodsSubviews];
    }
    return self;
}

#define kleft_margin 100
-(void)createAddGoodsSubviews
{
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = self.bounds;
    addBtn.backgroundColor = KRandomColor;
    [addBtn setTitle:@"添加商品" forState:UIControlStateNormal];
    CGFloat width = [[YanMethodManager defaultManager] LabelWidthByText:@"添加商品" height:40 font:kFontSize_2];
    addBtn.titleEdgeInsets = UIEdgeInsetsMake(10, 50, 10, kScreen_width-kleft_margin-50-width);
    addBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    addBtn.titleLabel.font = [UIFont systemFontOfSize:kFontSize_2];
    [addBtn setImage:[UIImage imageNamed:@"popArrow"] forState:UIControlStateNormal];
    addBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 20, 10, kScreen_width-kleft_margin-50);
    [addBtn addTarget:self action:@selector(addgoodsBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:addBtn];
}

-(void)addgoodsBtnAction
{
    if (self.addGoodsBlock) {
        self.addGoodsBlock();
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
