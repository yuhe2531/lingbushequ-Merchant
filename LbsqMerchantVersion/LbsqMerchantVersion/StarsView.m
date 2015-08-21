//
//  StarsView.m
//  LbsqMerchantVersion
//
//  Created by Runkun1 on 15/8/21.
//  Copyright (c) 2015年 Runkun. All rights reserved.
//

#import "StarsView.h"

@implementation StarsView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createFiveStarsView];
    }
    return self;
}

-(void)createFiveStarsView
{
    for (int i = 0; i < 5; i++) {
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake((self.height+5)*i, 0, self.height, self.height)];
        imgV.backgroundColor = [UIColor lightGrayColor];
        imgV.tag = 300 + i;
        [self addSubview:imgV];
    }
}

-(void)setStarCount:(NSInteger)starCount
{
    _starCount = starCount;
    for (int i = 0; i < 5; i++) {
        UIImageView *imageView = (UIImageView *)[self viewWithTag:300+i];
        if (i <= _starCount) {
            imageView.backgroundColor = [UIColor orangeColor];
        } else {
            imageView.backgroundColor = [UIColor lightGrayColor];
        }
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
