//
//  OrderViewController.m
//  LbsqMerchantVersion
//
//  Created by Runkun1 on 15/8/21.
//  Copyright (c) 2015年 Runkun. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderStatisticsTableViewCell.h"
#import "EveryOrderViewController.h"

@interface OrderViewController ()


@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = kBackgroundColor;
    
    [self createOrderCSubviews];
    
    // Do any additional setup after loading the view.
}

-(void)setStep:(NSInteger)step
{
    if (_step) {
        return;
    }
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
    return 65;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *order = @"statistics";
    OrderStatisticsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:order];
    if (!cell) {
        cell = [[OrderStatisticsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:order];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    EveryOrderViewController *orderVC = [[EveryOrderViewController alloc] init];
    if (_step == 1) {
        orderVC.naviTitle = @"每日订单";
    } else if (_step == 2) {
        orderVC.naviTitle = @"每周订单";
    } else {
        orderVC.naviTitle = @"每月订单";
    }
    [self.view.superview.viewController.navigationController pushViewController:orderVC animated:YES];
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
