//
//  EveryOrderViewController.m
//  LbsqMerchantVersion
//
//  Created by Runkun1 on 15/8/25.
//  Copyright (c) 2015年 Runkun. All rights reserved.
//

#import "EveryOrderViewController.h"
#import "EveryOrderTableViewCell.h"

@interface EveryOrderViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation EveryOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kBackgroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.titleView = [[YanMethodManager defaultManager] navibarTitle:self.naviTitle];
    [[YanMethodManager defaultManager] popToViewControllerOnClicked:self selector:@selector(popInEveryOrderC)];
    
    [self createEveryOrderCSubviews];
    
    // Do any additional setup after loading the view.
}

-(void)createEveryOrderCSubviews
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreen_width, kScreen_height-64) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
}

#pragma mark UITableView代理 
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 220;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *everyOrder = @"eveyrOrder";
    EveryOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:everyOrder];
    if (!cell) {
        cell = [[EveryOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:everyOrder];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(void)popInEveryOrderC
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
