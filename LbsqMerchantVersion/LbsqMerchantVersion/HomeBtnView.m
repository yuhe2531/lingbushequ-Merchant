//
//  HomeBtnView.m
//  LbsqMerchantVersion
//
//  Created by Runkun1 on 15/8/19.
//  Copyright (c) 2015年 Runkun. All rights reserved.
//

#import "HomeBtnView.h"

@implementation HomeBtnView

-(id)initWithFrame:(CGRect)frame image:(UIImage *)image title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createHomeBtnSubviewsWithImage:image title:title];
    }
    return self;
}

#define KIMageView_width 40
#define KTitleL_height 30

-(void)createHomeBtnSubviewsWithImage:(UIImage *)image title:(NSString *)title
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (self.height-KIMageView_width-KTitleL_height)/2, KIMageView_width, KIMageView_width)];
    imageView.userInteractionEnabled = YES;
    imageView.image = image;
    imageView.backgroundColor = KRandomColor;
    imageView.centerX = self.width/2;
    [self addSubview:imageView];
    
    UILabel *titleL = [ControlExtension labelInitWithFrame:CGRectMake(0, imageView.bottom, self.width, KTitleL_height) title:title font:kFontSize_2 textAlignment:NSTextAlignmentCenter];
    titleL.userInteractionEnabled = YES;
    [self addSubview:titleL];
    
    _button = [UIButton buttonWithType:UIButtonTypeSystem];
    _button.frame = self.bounds;
    [self addSubview:_button];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
