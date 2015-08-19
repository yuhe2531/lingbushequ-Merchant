//
//  GoodsManagementViewController.m
//  LbsqMerchantVersion
//
//  Created by Runkun1 on 15/8/19.
//  Copyright (c) 2015年 Runkun. All rights reserved.
//

#import "GoodsManagementViewController.h"
#import "TabbarViewController.h"
#import "SearchView.h"
#import "SearchResultViewController.h"
#import "GoodsTableViewCell.h"

#define kLeftCategory_width 80

@interface GoodsManagementViewController ()

@end

@implementation GoodsManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.titleView = [[YanMethodManager defaultManager] navibarTitle:@"商品管理"];
    [[YanMethodManager defaultManager] popToViewControllerOnClicked:self selector:@selector(popInGoodsManagementController)];
    
    [self createGoodsManagementControllerSubviews];
    
    // Do any additional setup after loading the view.
}

#define kSearchView_height 45
//添加UI
-(void)createGoodsManagementControllerSubviews
{
    SearchView *searchView = [[SearchView alloc] initWithFrame:CGRectMake(0, 64, kScreen_width, kSearchView_height)];
    __weak GoodsManagementViewController *weakSelf = self;
    searchView.searchBtnBlock = ^{
        SearchResultViewController *resultVC = [[SearchResultViewController alloc] init];
        [weakSelf.navigationController pushViewController:resultVC animated:YES];
    };
    [self.view addSubview:searchView];
    
    UITableView *goodsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, searchView.bottom, kScreen_width, kScreen_height-64-kSearchView_height) style:UITableViewStylePlain];
    goodsTableView.dataSource = self;
    goodsTableView.delegate = self;
    [self.view addSubview:goodsTableView];
}

#pragma mark UITableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *goodsID = @"goods";
    GoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:goodsID];
    if (!cell) {
        cell = [[GoodsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:goodsID isAllScreen:YES];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

-(void)viewWillAppear:(BOOL)animated
{
    ((TabbarViewController *)self.tabBarController).tabBarView.hidden = YES;
}

-(void)popInGoodsManagementController
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
