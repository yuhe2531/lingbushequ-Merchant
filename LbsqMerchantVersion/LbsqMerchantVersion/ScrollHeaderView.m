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

#define ktitleL_width kScreen_width/3
#define kTitleL_height 40

-(void)createScrollHeaderSubviewsWithTitles:(NSArray *)titles
{
    for (int i = 0; i < titles.count; i++) {
//        UILabel *titleL = [ControlExtension labelInitWithFrame:CGRectMake(ktitleL_width*i, 0, ktitleL_width, ktitleL_width) title:<#(NSString *)#> font:<#(NSInteger)#> textAlignment:<#(NSTextAlignment)#>]
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
