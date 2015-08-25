//
//  PraiseSingleViewController.m
//  LbsqMerchantVersion
//
//  Created by Runkun1 on 15/8/21.
//  Copyright (c) 2015年 Runkun. All rights reserved.
//

#import "PraiseSingleViewController.h"
#import "PraiseTableViewCell.h"
#import "PraiseModel.h"

@interface PraiseSingleViewController ()

@end

@implementation PraiseSingleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = kBackgroundColor;
    
    [self createOrderCSubviews];
    
    // Do any additional setup after loading the view.
}

-(void)setStep:(NSInteger)step
{
    _step = step;
    NSLog(@"=============== %ld",_step);
    
}

-(void)createOrderCSubviews
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_width, self.view.height) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

#pragma mark UITableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *tempStr = @"正式测试数据，一个测试的数据，测定侧记十四时是谁测试，测试";
    CGFloat height = [[YanMethodManager defaultManager] titleLabelHeightByText:tempStr width:kScreen_width-2*15 font:kFontSize_2];
    return height + 90;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *praise = @"praise";
    PraiseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:praise];
    if (!cell) {
        cell= [[PraiseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:praise];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    PraiseModel *model = [[PraiseModel alloc] init];
    cell.praise = model;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
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
