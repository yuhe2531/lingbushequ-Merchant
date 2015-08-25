//
//  GoodsHeaderView.h
//  LbsqMerchantVersion
//
//  Created by Runkun1 on 15/8/22.
//  Copyright (c) 2015年 Runkun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapBlock)(void);

@interface GoodsHeaderView : UIView

@property (nonatomic, copy) TapBlock tapActionBlock;
@property (nonatomic, strong) UIImageView *imageV;

-(id)initWithFrame:(CGRect)frame image:(UIImage *)image title:(NSString *)title;

@end
