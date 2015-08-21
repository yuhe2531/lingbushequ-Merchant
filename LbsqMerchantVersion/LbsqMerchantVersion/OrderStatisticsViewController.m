//
//  OrderStatisticsViewController.m
//  LbsqMerchantVersion
//
//  Created by Runkun1 on 15/8/19.
//  Copyright (c) 2015年 Runkun. All rights reserved.
//

#import "OrderStatisticsViewController.h"
#import "ScrollHeaderView.h"
#import "OrderViewController.h"
#import "SearchOrderViewController.h"

@interface OrderStatisticsViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) ScrollHeaderView *scrollHeader;
@property (nonatomic, strong) NSMutableArray *statisticsContentArray;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation OrderStatisticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = kBackgroundColor;
    self.navigationItem.titleView = [[YanMethodManager defaultManager] navibarTitle:@"订单统计"];
    [[YanMethodManager defaultManager] popToViewControllerOnClicked:self selector:@selector(popInOrderStatisticsVC)];
    
    UIButton *checkBtn = [ControlExtension buttonInitWithFrame:CGRectMake(0, 0, 40, 25) title:@"查询" style:UIButtonTypeSystem font:kFontSize_3 titleColor:[UIColor whiteColor]];
    checkBtn.layer.cornerRadius = 5;
    [checkBtn addTarget:self action:@selector(checkBtnAction) forControlEvents:UIControlEventTouchUpInside];
    checkBtn.layer.borderColor = kDividColor.CGColor;
    checkBtn.layer.borderWidth = 0.5;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:checkBtn];
    
    [self createOrderStatisticsSubviews];
    
    // Do any additional setup after loading the view.
}

#define kScrollHeader_height 45

-(void)createOrderStatisticsSubviews
{
    NSArray *titles = @[@"每日", @"每周", @"每月"];
    _scrollHeader = [[ScrollHeaderView alloc] initWithFrame:CGRectMake(0, 64, kScreen_width, kScrollHeader_height) titles:titles];
    
    [self.view addSubview:_scrollHeader];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _scrollHeader.bottom, kScreen_width, kScreen_height-64-_scrollHeader.height)];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(titles.count * kScreen_width, _scrollView.height);
    [self.view addSubview:_scrollView];
    
    //顶部的三个切换按钮被点击
    __weak OrderStatisticsViewController *weakSelf = self;
    _scrollHeader.scrollHeaderBlock = ^(UIButton *button){
        [UIView animateWithDuration:0.5 animations:^{
            weakSelf.scrollView.contentOffset = CGPointMake(kScreen_width*(button.tag-250), weakSelf.scrollView.contentOffset.y);
            OrderViewController *orderVC = (OrderViewController *)weakSelf.statisticsContentArray[button.tag-250];
            orderVC.step = button.tag - 250 + 1;
            
        }];
    };
    
    _statisticsContentArray = [NSMutableArray array];
    for (int i = 0; i < titles.count; i++) {
        OrderViewController *orderVC = [[OrderViewController alloc] init];
        orderVC.view.frame = CGRectMake(kScreen_width*i, 0, kScreen_width, kScreen_height-_scrollHeader.height-64);
        orderVC.tableView.height = orderVC.view.height;
        [_statisticsContentArray addObject:orderVC];
        
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)0.0001*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        for (int i = 0; i < _statisticsContentArray.count; i++) {
            OrderViewController *orderVC = (OrderViewController *)_statisticsContentArray[i];
            if (i == 0) {
                orderVC.step = 1;
            }
            [_scrollView addSubview:orderVC.view];
        }
    });
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger offset_x = scrollView.contentOffset.x / kScreen_width;
    OrderViewController *orderVC = (OrderViewController *)_statisticsContentArray[offset_x];
    orderVC.step = offset_x + 1;
    
    _scrollHeader.moveStep = offset_x;
}

-(void)checkBtnAction
{
    SearchOrderViewController *searchVC = [[SearchOrderViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
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
