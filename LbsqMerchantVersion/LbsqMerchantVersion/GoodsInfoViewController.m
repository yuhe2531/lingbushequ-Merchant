//
//  GoodsInfoViewController.m
//  LbsqMerchantVersion
//
//  Created by Runkun1 on 15/8/22.
//  Copyright (c) 2015年 Runkun. All rights reserved.
//

#import "GoodsInfoViewController.h"
#import "GoodsHeaderView.h"
#import "GoodsInfoTableViewCell.h"

@interface GoodsInfoViewController ()<UITextFieldDelegate>

@property (nonatomic, assign) BOOL canEdit;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *goodsTitles;

@end

@implementation GoodsInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _canEdit = NO;
    
    self.view.backgroundColor = kBackgroundColor;
    self.navigationItem.titleView = [[YanMethodManager defaultManager] navibarTitle:@"商品信息"];
    [[YanMethodManager defaultManager] popToViewControllerOnClicked:self selector:@selector(popInGoodsInfoC)];
    UIButton *editBtn = [ControlExtension buttonInitWithFrame:CGRectMake(0, 0, 45, 25) title:@"编辑" style:UIButtonTypeSystem font:kFontSize_3 titleColor:[UIColor whiteColor]];
    editBtn.layer.borderColor = kDividColor.CGColor;
    editBtn.layer.borderWidth = 0.5;
    editBtn.layer.cornerRadius = 4;
    [editBtn addTarget:self action:@selector(editBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:editBtn];
    
    [self createGoodsInfoCSubviews];
    
    // Do any additional setup after loading the view.
}

#define kHeaderView_height 140

-(void)createGoodsInfoCSubviews
{
    GoodsHeaderView *headerView = [[GoodsHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreen_width, kHeaderView_height) image:nil title:@"15665797058"];
    //点击icon更换头像
    headerView.tapActionBlock = ^{
        NSLog(@"========= tap");
        if (_canEdit) {
            
        }
    };
    
    _goodsTitles = @[@"商品分类:", @"商品名称:", @"商品价格:", @"是否特价:", @"首页推荐:"];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreen_width, kScreen_height-64) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    _tableView.tableHeaderView = headerView;
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_width, 200)];
    [YanMethodManager lineViewWithFrame:CGRectMake(15, 0, kScreen_width, 0.5) superView:footer];
    UIButton *saveBtn = [ControlExtension buttonInitWithFrame:CGRectMake(30, 40, kScreen_width-60, 40) title:@"保存并上架" style:UIButtonTypeSystem font:kFontSize_2 titleColor:[UIColor whiteColor]];
    saveBtn.backgroundColor = kNaviBarColor;
    saveBtn.layer.cornerRadius = 5;
    saveBtn.layer.borderWidth = 0.5;
    saveBtn.layer.borderColor = kDividColor.CGColor;
    saveBtn.tag = 500;
    [saveBtn addTarget:self action:@selector(goodsInfoBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:saveBtn];
    
    UIButton *deleBtn = [ControlExtension buttonInitWithFrame:CGRectMake(saveBtn.left, saveBtn.bottom+15, kScreen_width-60, 40) title:@"下架" style:UIButtonTypeSystem font:kFontSize_2 titleColor:[UIColor whiteColor]];
    deleBtn.backgroundColor = kNaviBarColor;
    deleBtn.layer.cornerRadius = 5;
    deleBtn.layer.borderWidth = 0.5;
    deleBtn.layer.borderColor = kDividColor.CGColor;
    deleBtn.tag = 501;
    [deleBtn addTarget:self action:@selector(goodsInfoBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:deleBtn];
    _tableView.tableFooterView = footer;
}

-(void)goodsInfoBtnAction:(UIButton *)button
{
    if (button.tag == 500) {//保存并上架
        
    } else {//下架
        
    }
}

#pragma mark UITableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *goods = @"goods";
    GoodsInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:goods];
    if (!cell) {
        cell = [[GoodsInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:goods title:_goodsTitles[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.contentTF.tag = 400 + indexPath.row;
    cell.contentTF.delegate = self;
    if (indexPath.row == 3 || indexPath.row == 4) {
        cell.isPrice = YES;
    }
    return cell;
}

#pragma mark UITextField

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField.tag == 403 || textField.tag == 404) {
        if (textField.text.length > 0) {
            textField.text = [@"¥ " stringByAppendingString:textField.text];
        }
    }
    return YES;
}

-(void)editBtnAction:(UIButton *)button
{
    
}

-(void)popInGoodsInfoC
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
