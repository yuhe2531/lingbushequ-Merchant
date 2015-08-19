//
//  SearchView.h
//  LbsqMerchantVersion
//
//  Created by Runkun1 on 15/8/19.
//  Copyright (c) 2015年 Runkun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SearchBtnBlock)(void);

@interface SearchView : UIView

@property (nonatomic, copy) SearchBtnBlock searchBtnBlock;

@end
