//
//  GoodsInfoTableViewCell.h
//  LbsqMerchantVersion
//
//  Created by Runkun1 on 15/8/22.
//  Copyright (c) 2015年 Runkun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GoodsSwitchBlock)(UISwitch *);

@interface GoodsInfoTableViewCell : UITableViewCell

@property (nonatomic, strong) UITextField *contentTF;
@property (nonatomic, assign) BOOL isPrice;
@property (nonatomic, copy) GoodsSwitchBlock goodsSwitchBlock;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier title:(NSString *)title;

@end
