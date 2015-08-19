//
//  SearchView.m
//  LbsqMerchantVersion
//
//  Created by Runkun1 on 15/8/19.
//  Copyright (c) 2015年 Runkun. All rights reserved.
//

#import "SearchView.h"

@implementation SearchView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kBackgroundColor;
        [self createSearchSubviews];
    }
    return self;
}

-(void)createSearchSubviews
{
    UITextField *searchTF = [[UITextField alloc] initWithFrame:CGRectMake(15, 5, self.width-30, self.height-10)];
    searchTF.font = [UIFont systemFontOfSize:kFontSize_2];
    searchTF.layer.borderColor = kDividColor.CGColor;
    searchTF.layer.borderWidth = 0.5;
    searchTF.layer.cornerRadius = 5;
    searchTF.placeholder = @"请输入商品名称";
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, searchTF.height, searchTF.height)];
    UIImageView *leftImageV = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 20, 20)];
    leftImageV.backgroundColor = KRandomColor;
    leftImageV.center = CGPointMake(view.width/2, view.height/2);
    [view addSubview:leftImageV];
    searchTF.leftViewMode = UITextFieldViewModeAlways;
    searchTF.leftView = view;
    [self addSubview:searchTF];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    searchBtn.frame = self.bounds;
    [searchBtn addTarget:self action:@selector(searchBtnJumpAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:searchBtn];
    
}

-(void)searchBtnJumpAction
{
    if (self.searchBtnBlock) {
        self.searchBtnBlock();
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
