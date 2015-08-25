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
#import "GoodsInfoViewController.h"
#import "System_ScanViewController.h"

#define kLeftCategory_width 100

@interface GoodsManagementViewController ()

@property (nonatomic, strong) UITableView *categoryTableView;
@property (nonatomic, strong) UITableView *goodsTableView;
@property (nonatomic, strong) NSMutableArray *sections;//大分类
@property (nonatomic, strong) NSMutableArray *rows;//小分类
@property (nonatomic, strong) NSMutableArray *showRowsArray;//BOOL
@property (nonatomic, strong) NSIndexPath *selectIndexPath;

@end

@implementation GoodsManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.titleView = [[YanMethodManager defaultManager] navibarTitle:@"商品管理"];
    [[YanMethodManager defaultManager] popToViewControllerOnClicked:self selector:@selector(popInGoodsManagementController)];
    
    _selectIndexPath = nil;
    
    //**************************************************************************/测试代码
    _sections = [NSMutableArray arrayWithArray:@[@"一级分类一级分类", @"一级分类", @"一级分类", @"一级分类", @"一级分类"]];
    _rows = [NSMutableArray array];
    self.showRowsArray = [NSMutableArray array];
    NSInteger count = _sections.count;
    for (int i = 0; i < count; i++) {
        
        NSArray *tempArray = @[@"二级分类二级分类", @"二级分类", @"二级分类", @"二级分类", @"二级分类", @"二级分类"];
        [_rows addObject:tempArray];
        [_showRowsArray addObject:@NO];
    }
    ////////*****************************/////////
    
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
//        ScanViewController *scanVC = [[ScanViewController alloc] init];
//        scanVC.isPush = YES;
//        [weakSelf.navigationController pushViewController:scanVC animated:YES];
        
        System_ScanViewController *sysVC = [[System_ScanViewController alloc] init];
        sysVC.isPush = YES;
        [weakSelf.navigationController pushViewController:sysVC animated:YES];
    };
    [self.view addSubview:addView];
    
    _categoryTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, searchView.bottom, kLeftCategory_width, kScreen_height-64-kSearchView_height) style:UITableViewStylePlain];
    _categoryTableView.showsVerticalScrollIndicator = NO;
    _categoryTableView.dataSource = self;
    _categoryTableView.delegate = self;
    [self.view addSubview:_categoryTableView];
    UIView *cateLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_width, 1)];
    _categoryTableView.tableFooterView = cateLine;
    
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
        return _sections.count;
    } else {
        return 1;
    }
}

#define kSection_header 50

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == _categoryTableView) {
        UIView *sectionHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kLeftCategory_width, kSection_header)];
        sectionHeader.backgroundColor = kBackgroundColor;
        UILabel *titleLabel = [ControlExtension labelInitWithFrame:CGRectMake(10, 0, sectionHeader.width-10, sectionHeader.height) title:_sections[section] font:kFontSize_3 textAlignment:NSTextAlignmentCenter];
        titleLabel.numberOfLines = 2;
        titleLabel.textColor = kNaviBarColor;
        [sectionHeader addSubview:titleLabel];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.tag = 450 + section;
        button.frame = CGRectMake(10, 0, sectionHeader.width-10, sectionHeader.height);
        button.titleLabel.numberOfLines = 2;
        [button addTarget:self action:@selector(categoryButtonSectionAction:) forControlEvents:UIControlEventTouchUpInside];
        [sectionHeader addSubview:button];
        return sectionHeader;
    }
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == _categoryTableView) {
        return kSection_header;
    }
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _categoryTableView) {
        if ([_showRowsArray[section]  isEqual: @YES]) {
            NSArray *array = _rows[section];
            return array.count;
        } else {
            return 0;
        }
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
        NSArray *array = _rows[indexPath.section];
        cell.textLabel.text = array[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:kFontSize_2];
        cell.textLabel.numberOfLines = 2;
        UIView *line = [cell viewWithTag:5000];
        [line removeFromSuperview];
        if (_selectIndexPath.section == indexPath.section) {
            if (_selectIndexPath.row == indexPath.row) {
                UIView *leftLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 3, 44)];
                leftLine.tag = 5000;
                leftLine.backgroundColor = kNaviBarColor;
                [cell.contentView addSubview:leftLine];
            }
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
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (tableView == _categoryTableView) {
        _selectIndexPath = indexPath;
        [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        [tableView reloadData];
    } else {
        
        GoodsInfoViewController *goodsVC = [[GoodsInfoViewController alloc] init];
        [self.navigationController pushViewController:goodsVC animated:YES];
    }
}

-(void)categoryButtonSectionAction:(UIButton *)button
{
    NSLog(@"============ button tag = %ld",button.tag);
    NSInteger index = button.tag - 450;
    if ([_showRowsArray[index] isEqual:@NO]) {
        [_showRowsArray replaceObjectAtIndex:index withObject:@YES];
    } else {
        [_showRowsArray replaceObjectAtIndex:index withObject:@NO];
    }
    [_categoryTableView reloadData];
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
