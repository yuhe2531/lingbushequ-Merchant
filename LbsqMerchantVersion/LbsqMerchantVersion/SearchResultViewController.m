//
//  SearchResultViewController.m
//  LbsqMerchantVersion
//
//  Created by Runkun1 on 15/8/19.
//  Copyright (c) 2015年 Runkun. All rights reserved.
//

#import "SearchResultViewController.h"
#import "GoodsTableViewCell.h"
#import "GoodsInfoViewController.h"

@interface SearchResultViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITextField *searchTF;

@end

@implementation SearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = kBackgroundColor;
    
    [[YanMethodManager defaultManager] popToViewControllerOnClicked:self selector:@selector(searchResultPop)];
    
    [self createSearchResultSubviews];
    
    // Do any additional setup after loading the view.
}

#define kSearchTF_height 30

-(void)createSearchResultSubviews
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
    _searchTF.placeholder = @"请输入商品名称";
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _searchTF.height, _searchTF.height)];
    UIImageView *leftImageV = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 20, 20)];
    leftImageV.backgroundColor = KRandomColor;
    leftImageV.center = CGPointMake(view.width/2, view.height/2);
    [view addSubview:leftImageV];
    _searchTF.leftViewMode = UITextFieldViewModeAlways;
    _searchTF.leftView = view;
    self.navigationItem.titleView = _searchTF;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreen_width, kScreen_height-64) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [_searchTF resignFirstResponder];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *result = @"search";
    GoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:result];
    if (!cell) {
        cell = [[GoodsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:result isAllScreen:YES];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    GoodsInfoViewController *infoVC = [[GoodsInfoViewController alloc] init];
    [self.navigationController pushViewController:infoVC animated:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)searchResultPop
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
