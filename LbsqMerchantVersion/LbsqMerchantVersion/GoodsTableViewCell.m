//
//  GoodsTableViewCell.m
//  LbsqMerchantVersion
//
//  Created by Runkun1 on 15/8/19.
//  Copyright (c) 2015年 Runkun. All rights reserved.
//

#import "GoodsTableViewCell.h"

@interface GoodsTableViewCell ()

@property (nonatomic, assign) BOOL isAllScreen;
@property (nonatomic, strong) UIImageView *goodsImgV;
@property (nonatomic, strong) UILabel *goodsNameL;
@property (nonatomic, strong) UILabel *goodsPriceL;
@property (nonatomic, strong) UIButton *statusBtn;

@end

@implementation GoodsTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier isAllScreen:(BOOL)all
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _isAllScreen = all;
        [self createGoodsTVSubviews];
    }
    return self;
}

#define kLeftMargin 80

-(void)createGoodsTVSubviews
{
    //kScreen_width-20-40-imageWidth
    //kScreen_width-kLeftMargin-20-40-imageWidth
    CGFloat imageWidth = _isAllScreen ? 100 : 80;
    CGFloat nameLWidth = _isAllScreen ?  kScreen_width-20-40-100: kScreen_width-kLeftMargin-20-40-80;
    _goodsImgV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, imageWidth, imageWidth)];
    _goodsImgV.backgroundColor = KRandomColor;
    [self.contentView addSubview:_goodsImgV];
    
    _goodsNameL = [ControlExtension labelInitWithFrame:CGRectMake(_goodsImgV.right+10, 15, nameLWidth, 20) title:@"商品名称:可口可乐20ml装" font:kFontSize_2 textAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:_goodsNameL];
    
    _goodsPriceL = [ControlExtension labelInitWithFrame:CGRectMake(_goodsNameL.left, _goodsNameL.bottom+(_goodsImgV.height-2*_goodsNameL.height), _goodsNameL.width, _goodsNameL.height) title:@"价格:¥456.0" font:kFontSize_3 textAlignment:NSTextAlignmentLeft];
    _goodsPriceL.textColor = [UIColor redColor];
    [self.contentView addSubview:_goodsPriceL];
    
    _statusBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _statusBtn.frame = CGRectMake(_goodsNameL.left, _goodsNameL.bottom, 60, 15);
    _statusBtn.centerY = _goodsImgV.centerY;
    _statusBtn.layer.cornerRadius = 4;
    [_statusBtn setTitle:@"已上架" forState:UIControlStateNormal];
    _statusBtn.enabled = NO;
    [self.contentView addSubview:_statusBtn];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
