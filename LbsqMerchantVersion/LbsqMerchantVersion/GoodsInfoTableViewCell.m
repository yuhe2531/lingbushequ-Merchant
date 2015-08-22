//
//  GoodsInfoTableViewCell.m
//  LbsqMerchantVersion
//
//  Created by Runkun1 on 15/8/22.
//  Copyright (c) 2015年 Runkun. All rights reserved.
//

#import "GoodsInfoTableViewCell.h"

@implementation GoodsInfoTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier title:(NSString *)title
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creageGoodsInfoSubviewsWithTitle:title];
    }
    return self;
}

-(void)creageGoodsInfoSubviewsWithTitle:(NSString *)title
{
    UILabel *titleL = [ControlExtension labelInitWithFrame:CGRectMake(15, 0, 80, 44) title:title font:kFontSize_2 textAlignment:NSTextAlignmentLeft];
    titleL.textColor = kBlack_Color_1;
    [self.contentView addSubview:titleL];
    
    _contentTF = [[UITextField alloc] initWithFrame:CGRectMake(titleL.right+5, titleL.top, kScreen_width-titleL.width-20, titleL.height)];
    _contentTF.placeholder = @"placeholder";
    [self.contentView addSubview:_contentTF];
}

-(void)setIsPrice:(BOOL)isPrice
{
    _isPrice = isPrice;
    if (_isPrice) {
        _contentTF.width = _contentTF.width - 60 - 10;
        UISwitch *goodsSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(_contentTF.right+5, _contentTF.top, 60, 30)];
        goodsSwitch.centerY = _contentTF.centerY;
        [goodsSwitch addTarget:self action:@selector(goodsSwichAction:) forControlEvents:UIControlEventValueChanged];
        [self.contentView addSubview:goodsSwitch];
    }
}

-(void)goodsSwichAction:(UISwitch *)goodsSwitch
{
    if (self.goodsSwitchBlock) {
        self.goodsSwitchBlock(goodsSwitch);
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
