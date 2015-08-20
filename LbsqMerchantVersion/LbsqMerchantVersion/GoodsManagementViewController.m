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
#import "AddGoodsView.h"
#import "ScanViewController.h"

#define kLeftCategory_width 100

@interface GoodsManagementViewController ()

@property (nonatomic, strong) UITableView *categoryTableView;
@property (nonatomic, strong) UITableView *goodsTableView;

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
#define kAddView_height 40
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
    
    AddGoodsView *addView = [[AddGoodsView alloc] initWithFrame:CGRectMake(kLeftCategory_width, 64+kSearchView_height, kScreen_width, kAddView_height)];
    addView.addGoodsBlock = ^{
        ScanViewController *scanVC = [[ScanViewController alloc] init];
        scanVC.isPush = YES;
        [weakSelf.navigationController pushViewController:scanVC animated:YES];
    };
    [self.view addSubview:addView];
    
    _categoryTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, searchView.bottom, kLeftCategory_width, kScreen_height-64-kSearchView_height) style:UITableViewStylePlain];
    _categoryTableView.showsVerticalScrollIndicator = NO;
    _categoryTableView.dataSource = self;
    _categoryTableView.delegate = self;
    [self.view addSubview:_categoryTableView];
    
    _goodsTableView = [[UITableView alloc] initWithFrame:CGRectMake(_categoryTableView.right, addView.bottom, kScreen_width-kLeftCategory_width, _categoryTableView.height-addView.height) style:UITableViewStylePlain];
    _goodsTableView.showsVerticalScrollIndicator = NO;
    _goodsTableView.dataSource = self;
    _goodsTableView.delegate = self;
    [self.view addSubview:_goodsTableView];
    
    [YanMethodManager lineViewWithFrame:CGRectMake(_categoryTableView.width, _categoryTableView.top, 0.5, _categoryTableView.height) superView:self.view];
    
}

#pragma mark UITableView

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == _categoryTableView) {
        return 2;
    } else {
        return 1;
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _categoryTableView) {
        return 10;
    } else {
        return 10;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _categoryTableView) {
        static NSString *goodsID = @"category";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:goodsID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:goodsID];
        }
        return cell;
    } else {
        static NSString *goodsID = @"goods";
        GoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:goodsID];
        if (!cell) {
            cell = [[GoodsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:goodsID isAllScreen:NO];
        }
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _categoryTableView) {
        return 44;
    } else {
        return 90;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _categoryTableView) {
        
    } else {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
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
