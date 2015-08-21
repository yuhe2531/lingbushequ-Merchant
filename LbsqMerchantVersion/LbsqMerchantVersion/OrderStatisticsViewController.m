//
//  OrderStatisticsViewController.m
//  LbsqMerchantVersion
//
//  Created by Runkun1 on 15/8/19.
//  Copyright (c) 2015年 Runkun. All rights reserved.
//

#import "OrderStatisticsViewController.h"
#import "ScrollHeaderView.h"

@interface OrderStatisticsViewController ()

@property (nonatomic, strong) ScrollHeaderView *scrollHeader;

@end

@implementation OrderStatisticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = kBackgroundColor;
    self.navigationItem.titleView = [[YanMethodManager defaultManager] navibarTitle:@"订单统计"];
    [[YanMethodManager defaultManager] popToViewControllerOnClicked:self selector:@selector(popInOrderStatisticsVC)];
    
    [self createOrderStatisticsSubviews];
    
    // Do any additional setup after loading the view.
}

#define kScrollHeader_height 45

-(void)createOrderStatisticsSubviews
{
    NSArray *titles = @[@"每日", @"每周", @"每月"];
    _scrollHeader = [[ScrollHeaderView alloc] initWithFrame:CGRectMake(0, 64, kScreen_width, kScrollHeader_height) titles:titles];
    [self.view addSubview:_scrollHeader];
}

-(void)viewWillAppear:(BOOL)animated
{
    ((TabbarViewController *)self.tabBarController).tabBarView.hidden = YES;
}

-(void)popInOrderStatisticsVC
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
