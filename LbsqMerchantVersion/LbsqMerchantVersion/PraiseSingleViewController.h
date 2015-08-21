//
//  PraiseSingleViewController.h
//  LbsqMerchantVersion
//
//  Created by Runkun1 on 15/8/21.
//  Copyright (c) 2015年 Runkun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PraiseSingleViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger step;

@end
