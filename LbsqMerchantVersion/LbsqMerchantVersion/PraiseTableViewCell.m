//
//  PraiseTableViewCell.m
//  LbsqMerchantVersion
//
//  Created by Runkun1 on 15/8/21.
//  Copyright (c) 2015年 Runkun. All rights reserved.
//

#import "PraiseTableViewCell.h"
#import "StarsView.h"

@interface PraiseTableViewCell ()

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *nameL;
@property (nonatomic, strong) UILabel *dateL;
@property (nonatomic, strong) UILabel *praiseL;
@property (nonatomic, strong) StarsView *starsView;

@end

@implementation PraiseTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

#define kIcon_width 35
#define kLeft_margin 15
#define kTop_margin 10
#define kMargin 10

#define kNameL_width 150

#define kDateL_width 80

#define kStarView_height 15

-(void)setPraise:(PraiseModel *)praise
{
    _praise = praise;
    
    [self.contentView removeAllSubviews];
    
    _icon = [[UIImageView alloc] initWithFrame:CGRectMake(kLeft_margin, kTop_margin, kIcon_width, kIcon_width)];
    _icon.backgroundColor = KRandomColor;
    [self.contentView addSubview:_icon];
    
    _nameL = [ControlExtension labelInitWithFrame:CGRectMake(_icon.right+kMargin, _icon.top, kNameL_width, _icon.height) title:@"15665797058" font:kFontSize_2 textAlignment:NSTextAlignmentLeft];
    _nameL.textColor = kBlack_Color_1;
    [self.contentView addSubview:_nameL];
    
    _dateL = [ControlExtension labelInitWithFrame:CGRectMake(kScreen_width-15-kDateL_width, _icon.top, kDateL_width, _icon.height) title:@"2015-08-21" font:kFontSize_3 textAlignment:NSTextAlignmentRight];
    _dateL.textColor = kBlack_Color_2;
    [self.contentView addSubview:_dateL];
    
    NSString *tempStr = @"正式测试数据，一个测试的数据，测定侧记十四时是谁测试，测试";
    CGFloat height = [[YanMethodManager defaultManager] titleLabelHeightByText:tempStr width:kScreen_width-2*kLeft_margin font:kFontSize_2];
    _praiseL = [ControlExtension labelInitWithFrame:CGRectMake(_icon.left, _icon.bottom+kMargin, kScreen_width-2*kLeft_margin, height) title:tempStr font:kFontSize_2 textAlignment:NSTextAlignmentLeft];
    _praiseL.numberOfLines = 0;
    [self.contentView addSubview:_praiseL];
    
    _starsView = [[StarsView alloc] initWithFrame:CGRectMake(kScreen_width-kLeft_margin-5*kStarView_height-20, _praiseL.bottom+kMargin, 5*kStarView_height+20, kStarView_height)];
    _starsView.starCount = 3;
    [self.contentView addSubview:_starsView];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
