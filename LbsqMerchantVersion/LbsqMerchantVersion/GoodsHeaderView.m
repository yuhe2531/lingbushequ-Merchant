//
//  GoodsHeaderView.m
//  LbsqMerchantVersion
//
//  Created by Runkun1 on 15/8/22.
//  Copyright (c) 2015年 Runkun. All rights reserved.
//

#import "GoodsHeaderView.h"

@implementation GoodsHeaderView

-(id)initWithFrame:(CGRect)frame image:(UIImage *)image title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createGoodsHeaderSubviewsWithImage:image title:title];
    }
    return self;
}

#define kImageV_widht 60

-(void)createGoodsHeaderSubviewsWithImage:(UIImage *)image title:(NSString *)title
{
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30, kImageV_widht, kImageV_widht)];
    imageV.centerX = self.width/2;
    imageV.image = image;
    imageV.backgroundColor = KRandomColor;
    imageV.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapIconAction:)];
    [imageV addGestureRecognizer:tap];
    [self addSubview:imageV];
    
    UILabel *titleL = [ControlExtension labelInitWithFrame:CGRectMake(0, imageV.bottom+5, self.width, 30) title:title font:kFontSize_2 textAlignment:NSTextAlignmentCenter];
    titleL.textColor = kBlack_Color_1;
    [self addSubview:titleL];
    
    [YanMethodManager lineViewWithFrame:CGRectMake(0, self.height, self.width, 0.5) superView:self];
    [YanMethodManager lineViewWithFrame:CGRectMake(0, self.height-10, self.width, 10) superView:self];
    
}

-(void)tapIconAction:(UITapGestureRecognizer *)tap
{
    if (self.tapActionBlock) {
        self.tapActionBlock();
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
