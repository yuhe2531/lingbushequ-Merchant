//
//  DayTurnoverStatisticView.m
//  LbsqMerchantVersion
//
//  Created by Runkun1 on 15/8/19.
//  Copyright (c) 2015年 Runkun. All rights reserved.
//

#import "DayTurnoverStatisticView.h"

@interface DayTurnoverStatisticView ()

@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UILabel *sumLabel;

@end


@implementation DayTurnoverStatisticView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        [self createDayTurnOverStatisticsSubviews];
    }
    return self;
}

#define KMargin_vertical 60
#define KMargin_horizon 100

#define KTitleL_height 40
#define KTitleL_bottom_margin 10
#define KCountTitleL_height 20

-(void)createDayTurnOverStatisticsSubviews
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(KMargin_horizon/2, KMargin_vertical/2, self.width-KMargin_horizon, self.height-KMargin_vertical)];
    view.backgroundColor = [UIColor whiteColor];
    [self addSubview:view];
    
    UILabel *titleL = [ControlExtension labelInitWithFrame:CGRectMake(0, 0, view.width, KTitleL_height) title:@"今日营业额统计" font:kFontSize_2 textAlignment:NSTextAlignmentCenter];
    titleL.textColor = [UIColor redColor];
    [view addSubview:titleL];
    
    for (int i = 0; i < 2; i++) {
        UILabel *countTitleL = [ControlExtension labelInitWithFrame:CGRectMake(view.width/2*i, titleL.bottom+KTitleL_bottom_margin, view.width/2, KCountTitleL_height) title:@"订单数" font:kFontSize_3 textAlignment:NSTextAlignmentCenter];
        [view addSubview:countTitleL];
    }
    
    _countLabel = [ControlExtension labelInitWithFrame:CGRectMake(0, titleL.bottom+KTitleL_bottom_margin+KCountTitleL_height, view.width/2, KCountTitleL_height) title:@"0" font:kFontSize_3 textAlignment:NSTextAlignmentCenter];
    _countLabel.textColor = [UIColor orangeColor];
    [view addSubview:_countLabel];
    
    _sumLabel = [ControlExtension labelInitWithFrame:CGRectMake(_countLabel.right, _countLabel.top, _countLabel.width, _countLabel.height) title:@"0" font:kFontSize_3 textAlignment:NSTextAlignmentCenter];
    _sumLabel.textColor = [UIColor orangeColor];
    [view addSubview:_sumLabel];
    
    [YanMethodManager lineViewWithFrame:CGRectMake(view.width/2, _countLabel.top-KCountTitleL_height, 0.5, 2*_countLabel.height) superView:view];
    
}

-(void)setOrderCount:(NSInteger)orderCount
{
    _orderCount = orderCount;
    _countLabel.text = [NSString stringWithFormat:@"%ld",_orderCount];
}

-(void)setTransitionSum:(float)transitionSum
{
    _transitionSum = transitionSum;
    _sumLabel.text = [NSString stringWithFormat:@"%.1f",_transitionSum];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
