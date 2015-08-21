//
//  PraiseViewController.m
//  LbsqMerchantVersion
//
//  Created by Runkun1 on 15/8/21.
//  Copyright (c) 2015年 Runkun. All rights reserved.
//

#import "PraiseViewController.h"
#import "ScrollHeaderView.h"

@interface PraiseViewController ()

@property (nonatomic, strong) ScrollHeaderView *praiseHeader;

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
