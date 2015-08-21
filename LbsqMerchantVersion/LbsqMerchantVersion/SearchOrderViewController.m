//
//  SearchOrderViewController.m
//  LbsqMerchantVersion
//
//  Created by Runkun1 on 15/8/21.
//  Copyright (c) 2015年 Runkun. All rights reserved.
//

#import "SearchOrderViewController.h"

@interface SearchOrderViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *searchTF;

@end

@implementation SearchOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kBackgroundColor;
    [[YanMethodManager defaultManager] popToViewControllerOnClicked:self selector:@selector(popInSearchOrderC)];
    
    [self createSearchOrderSubviews];
    // Do any additional setup after loading the view.
}

#define kSearchTF_height 30

-(void)createSearchOrderSubviews
{
    _searchTF = [[UITextField alloc] initWithFrame:CGRectMake(15, 5, kScreen_width-70, kSearchTF_height)];
    _searchTF.backgroundColor = kColorWithRGB(46, 156, 96);
    _searchTF.font = [UIFont systemFontOfSize:kFontSize_2];
    _searchTF.layer.borderColor = kDividColor.CGColor;
    _searchTF.layer.borderWidth = 0.5;
    _searchTF.layer.cornerRadius = 5;
    _searchTF.returnKeyType = UIReturnKeySearch;
    _searchTF.delegate = self;
    [_searchTF becomeFirstResponder];
    _searchTF.placeholder = @"您可以输入订单号的后几位查询";
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _searchTF.height, _searchTF.height)];
    UIImageView *leftImageV = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 20, 20)];
    leftImageV.backgroundColor = KRandomColor;
    leftImageV.center = CGPointMake(view.width/2, view.height/2);
    [view addSubview:leftImageV];
    _searchTF.leftViewMode = UITextFieldViewModeAlways;
    _searchTF.leftView = view;
    self.navigationItem.titleView = _searchTF;
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [_searchTF resignFirstResponder];
}

-(void)popInSearchOrderC
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
