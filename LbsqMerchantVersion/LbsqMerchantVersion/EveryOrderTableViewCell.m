//
//  EveryOrderTableViewCell.m
//  LbsqMerchantVersion
//
//  Created by Runkun1 on 15/8/25.
//  Copyright (c) 2015年 Runkun. All rights reserved.
//

#import "EveryOrderTableViewCell.h"

@implementation EveryOrderTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createEveryOrderCellSubviews];
    }
    return self;
}

#define kLabel_height 25

-(void)createEveryOrderCellSubviews
{
    NSArray *titles = @[@"订单号:", @"客户:", @"地址:", @"金额:", @"订单状态:", @"下单时间:"];
    for (int i = 0; i < 6; i++) {
        if (i == 4) {
            UILabel *statusLabel = [ControlExtension labelInitWithFrame:CGRectMake(15, 10+(10+kLabel_height)*i, 80, 20) title:titles[i] font:kFontSize_2 textAlignment:NSTextAlignmentLeft];
            statusLabel.textColor = kBlack_Color_1;
            [self.contentView addSubview:statusLabel];
            
            UIButton *button = [ControlExtension buttonInitWithFrame:CGRectMake(statusLabel.right+10, statusLabel.top, 60, 25) title:@"已完成" style:UIButtonTypeSystem font:kFontSize_2 titleColor:[UIColor whiteColor]];
            button.backgroundColor = [UIColor redColor];
            button.centerY = statusLabel.centerY;
            button.layer.cornerRadius = 5;
            button.tag = 500 + i;
            [self.contentView addSubview:button];
        } else {
            UILabel *label = [ControlExtension labelInitWithFrame:CGRectMake(15, 10+(10+kLabel_height)*i, kScreen_width, kLabel_height) title:titles[i] font:kFontSize_2 textAlignment:NSTextAlignmentLeft];
            label.tag = 500 + i;
            [self.contentView addSubview:label];
        }
    }    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
