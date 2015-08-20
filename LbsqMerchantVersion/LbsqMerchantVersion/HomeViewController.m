//
//  HomeViewController.m
//  LbsqMerchantVersion
//
//  Created by Runkun1 on 15/8/18.
//  Copyright (c) 2015年 Runkun. All rights reserved.
//

#import "HomeViewController.h"
#import "DayTurnoverStatisticView.h"
#import "HomeBtnView.h"
#import "OrderStatisticsViewController.h"
#import "GoodsManagementViewController.h"

@interface HomeViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) DayTurnoverStatisticView *headerView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.titleView = [[YanMethodManager defaultManager] navibarTitle:@"零步社区"];
    
    //加UI
    [self createHomeSubviews];
    
    // Do any additional setup after loading the view.
}

#define KHeaderView_height 160
//添加头视图
-(void)createHomeSubviews
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreen_width, kScreen_height)];
    [self.view addSubview:_scrollView];
    
    _headerView = [[DayTurnoverStatisticView alloc] initWithFrame:CGRectMake(0, 0, kScreen_width, KHeaderView_height)];
    [_scrollView addSubview:_headerView];
    
    [self addHomeBtns];
}

#define KModelBtn_height 120
//添加主要模块
-(void)addHomeBtns
{
    NSArray *titles = @[@"订单统计", @"商品管理", @"口碑"];
    for (int i = 1; i <= titles.count; i++) {
        
        int count = (i % 2 == 0) ? (count = i / 2) : (count = i / 2 + 1);
        float top = (count -1) * KModelBtn_height;
        if (i % 2 == 1) {
            HomeBtnView *btnView = [[HomeBtnView alloc] initWithFrame:CGRectMake(0, top+_headerView.bottom, kScreen_width/2, KModelBtn_height) image:nil title:titles[i-1]];
            btnView.button.tag = 200 + i;
            [btnView.button addTarget:self action:@selector(homeBtnViewAction:) forControlEvents:UIControlEventTouchUpInside];
            [YanMethodManager lineViewWithFrame:CGRectMake(0, btnView.height, btnView.width, 0.5) superView:btnView];
            [YanMethodManager lineViewWithFrame:CGRectMake(btnView.width-0.5, 0, 0.5, btnView.height) superView:btnView];
            [_scrollView addSubview:btnView];
        } else {
            HomeBtnView *btnView = [[HomeBtnView alloc] initWithFrame:CGRectMake(kScreen_width/2, top+_headerView.bottom, kScreen_width/2, KModelBtn_height) image:nil title:titles[i-1]];
            btnView.button.tag = 200 + i;
            [btnView.button addTarget:self action:@selector(homeBtnViewAction:) forControlEvents:UIControlEventTouchUpInside];
            [YanMethodManager lineViewWithFrame:CGRectMake(0, btnView.height, btnView.width, 0.5) superView:btnView];
            [YanMethodManager lineViewWithFrame:CGRectMake(btnView.width-0.5, 0, 0.5, btnView.height) superView:btnView];
            [_scrollView addSubview:btnView];
        }
        
    }
    
    NSInteger lineCount = (titles.count % 2 == 0) ? titles.count/2 : titles.count/2 + 1;
    _scrollView.contentSize = CGSizeMake(kScreen_width, KHeaderView_height + KModelBtn_height*lineCount);
}

-(void)homeBtnViewAction:(UIButton *)button
{
    NSLog(@"======= btn tag = %ld",button.tag);
    switch (button.tag) {
        case 201:{//订单统计
            OrderStatisticsViewController *orderVC = [[OrderStatisticsViewController alloc] init];
            [self.navigationController pushViewController:orderVC animated:YES];
            break;
        }
        case 202:{//商品管理
            GoodsManagementViewController *managementVC = [[GoodsManagementViewController alloc] init];
            [self.navigationController pushViewController:managementVC animated:YES];
            
            break;
        }
        case 203:{//口碑
            
            
            break;
        }
            
        default:
            break;
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    ((TabbarViewController *)self.tabBarController).tabBarView.hidden = NO;
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
