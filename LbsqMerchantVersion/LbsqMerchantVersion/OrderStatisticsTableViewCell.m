//
//  OrderStatisticsTableViewCell.m
//  LbsqMerchantVersion
//
//  Created by Runkun1 on 15/8/19.
//  Copyright (c) 2015年 Runkun. All rights reserved.
//

#import "OrderStatisticsTableViewCell.h"

@interface OrderStatisticsTableViewCell ()

@property (nonatomic, strong) UILabel *countLabel;//订单总量
@property (nonatomic, strong) UILabel *sumTransictionL;//交易总额
@property (nonatomic, strong) UILabel *dateL;//时间

@end

@implementation OrderStatisticsTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createOrderStatisticsCellSubviews];
    }
    return self;
}

-(void)createOrderStatisticsCellSubviews
{
    _countLabel = [ControlExtension labelInitWithFrame:CGRectMake(10, 10, kScreen_width/2, 20) title:@"订单总量:200" font:kFontSize_2 textAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:_countLabel];
    
    _sumTransictionL = [ControlExtension labelInitWithFrame:CGRectMake(_countLabel.left, _countLabel.bottom+5, _countLabel.width, _countLabel.height) title:@"交易总额:345.0" font:kFontSize_2 textAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:_sumTransictionL];
    
    _dateL = [ControlExtension labelInitWithFrame:CGRectMake(kScreen_width-50, _countLabel.bottom-5, kScreen_width/2-50, 15) title:@"2015-08-19" font:kFontSize_3 textAlignment:NSTextAlignmentRight];
    [self.contentView addSubview:_dateL];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
