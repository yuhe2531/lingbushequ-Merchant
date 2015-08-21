//
//  PraiseViewController.m
//  LbsqMerchantVersion
//
//  Created by Runkun1 on 15/8/21.
//  Copyright (c) 2015年 Runkun. All rights reserved.
//

#import "PraiseViewController.h"
#import "ScrollHeaderView.h"
#import "TabbarViewController.h"
#import "PraiseSingleViewController.h"

@interface PraiseViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) ScrollHeaderView *praiseHeader;
@property (nonatomic, strong) NSMutableArray *praiseContentArray;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation PraiseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = kBackgroundColor;
    self.navigationItem.titleView = [[YanMethodManager defaultManager] navibarTitle:@"口碑"];
    [[YanMethodManager defaultManager] popToViewControllerOnClicked:self selector:@selector(popInPraiseC)];
    
    [self createPraiseCSubviews];
    
    // Do any additional setup after loading the view.
}

#define kPraiseHeader_height 45

-(void)createPraiseCSubviews
{
    NSArray *titles = @[@"近一周", @"近一月", @"近三月"];
    _praiseHeader = [[ScrollHeaderView alloc] initWithFrame:CGRectMake(0, 64, kScreen_width, kPraiseHeader_height) titles:titles];
    [self.view addSubview:_praiseHeader];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _praiseHeader.bottom, kScreen_width, kScreen_height-64-_praiseHeader.height)];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(titles.count * kScreen_width, _scrollView.height);
    [self.view addSubview:_scrollView];
    
    //顶部的三个切换按钮被点击
    __weak PraiseViewController *weakSelf = self;
    _praiseHeader.scrollHeaderBlock = ^(UIButton *button){
        [UIView animateWithDuration:0.5 animations:^{
            weakSelf.scrollView.contentOffset = CGPointMake(kScreen_width*(button.tag-250), weakSelf.scrollView.contentOffset.y);
            PraiseSingleViewController *praiseVC = (PraiseSingleViewController *)weakSelf.praiseContentArray[button.tag-250];
            praiseVC.step = button.tag - 250 + 1;
            
        }];
    };
    
    _praiseContentArray = [NSMutableArray array];
    for (int i = 0; i < titles.count; i++) {
        PraiseSingleViewController *praiseVC = [[PraiseSingleViewController alloc] init];
        praiseVC.view.frame = CGRectMake(kScreen_width*i, 0, kScreen_width, _scrollView.height);
        praiseVC.tableView.height = praiseVC.view.height;
        [_praiseContentArray addObject:praiseVC];
        
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)0.0001*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        for (int i = 0; i < _praiseContentArray.count; i++) {
            PraiseSingleViewController *praiseVC = (PraiseSingleViewController *)_praiseContentArray[i];
            if (i == 0) {
                praiseVC.step = 1;
            }
            
            [_scrollView addSubview:praiseVC.view];
        }
    });
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger offset_x = scrollView.contentOffset.x / kScreen_width;
    PraiseSingleViewController *praiseVC = (PraiseSingleViewController *)_praiseContentArray[offset_x];
    praiseVC.step = offset_x + 1;
    
    _praiseHeader.moveStep = offset_x;
}

-(void)viewWillAppear:(BOOL)animated
{
    ((TabbarViewController *)self.tabBarController).tabBarView.hidden = YES;
}

-(void)popInPraiseC
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
