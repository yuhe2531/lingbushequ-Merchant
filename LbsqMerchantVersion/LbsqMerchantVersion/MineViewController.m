//
//  MineViewController.m
//  LbsqMerchantVersion
//
//  Created by Runkun1 on 15/8/18.
//  Copyright (c) 2015年 Runkun. All rights reserved.
//

#import "MineViewController.h"
#import "UIImageView+WebCache.h"
#import "RetrievePasswordViewController.h"
#import "FeedbackViewController.h"

#define kImageHead_height 120

#define kServiceNumber @"4000279567"

@interface MineViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSArray *mineArray;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.titleView = [[YanMethodManager defaultManager] navibarTitle:@"我的"];
    
    _mineArray = @[@[@"联系电话", [@"客服热线 " stringByAppendingString:kServiceNumber]], @[@"修改登录密码", @"营业状态", @"关于我们", @"意见反馈"]];
    
    [self createMineSubviews];
    
    // Do any additional setup after loading the view.
}

-(void)createMineSubviews
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_width, kScreen_height) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_width, kImageHead_height)];
    _tableView.tableHeaderView = view;
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_width, 120)];
    UIButton *signoutBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    signoutBtn.frame = CGRectMake(0, 50, kScreen_width-100, 44);
    signoutBtn.centerX = footer.width/2;
    signoutBtn.backgroundColor = kNaviBarColor;
    [signoutBtn setTitle:@"退出" forState:UIControlStateNormal];
    [signoutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    signoutBtn.layer.cornerRadius = 5;
    [footer addSubview:signoutBtn];
    _tableView.tableFooterView = footer;
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, kScreen_width, kImageHead_height)];
    _imageView.backgroundColor = KRandomColor;
    [self.view addSubview:_imageView];
}

#pragma mark UITableView

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _mineArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = _mineArray[section];
    return array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *mineID = @"mine";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mineID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mineID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (indexPath.section == 1 && indexPath.row == 1) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSwichInCell:cell];
    }
    
    cell.imageView.image = [UIImage imageNamed:@"list_cart"];
    NSArray *array = _mineArray[indexPath.section];
    NSString *title = array[indexPath.row];
    cell.textLabel.text = title;
    cell.textLabel.font = [UIFont systemFontOfSize:kFontSize_2];
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (indexPath.section) {
        case 0:{
            switch (indexPath.row) {
                case 0:{//联系电话
                    
                    break;
                }
                case 1:{//客服热线
                    
                    [[YanMethodManager defaultManager] callPhoneActionWithNum:kServiceNumber viewController:self];
                    
                    break;
                }
                default:
                    break;
            }
            
            break;
        }
        case 1:{
            switch (indexPath.row) {
                case 0:{//修改密码
                    
                    RetrievePasswordViewController *retrieveVC = [[RetrievePasswordViewController alloc] init];
                    retrieveVC.isModify = YES;
                    [self.navigationController pushViewController:retrieveVC animated:YES];
                    
                    break;
                }
                case 1:{//营业状态
                    
                    break;
                }
                case 2:{//关于我们
                    
                    break;
                }
                case 3:{//意见反馈
                    
                    FeedbackViewController *feedbackVC = [[FeedbackViewController alloc] init];
                    [self.navigationController pushViewController:feedbackVC animated:YES];
                    
                    break;
                }
                default:
                    break;
            }
            
            break;
        }
        default:
            break;
    }
}

#define kSwich_width 60
#define kSwich_height 30

-(void)addSwichInCell:(UITableViewCell *)cell
{
    UISwitch *cellSwich = [[UISwitch alloc] initWithFrame:CGRectMake(kScreen_width-10-kSwich_width, 6, kSwich_width, kSwich_height)];
    cellSwich.onTintColor = kNaviBarColor;
    cellSwich.on = YES;
    [cellSwich addTarget:self action:@selector(swichChangeAction:) forControlEvents:UIControlEventValueChanged];
    [cell.contentView addSubview:cellSwich];
}

-(void)swichChangeAction:(UISwitch *)tempSwich
{
    NSLog(@"========= swich on = %d",tempSwich.on);
    if (tempSwich.on) {
        
    } else {
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offset = scrollView.contentOffset.y;
    if (offset > 0) {
        _imageView.top = -offset;
    } else {
        CGFloat newHeight = kImageHead_height + ABS(offset);
        _imageView.height = newHeight;
        
        CGFloat newWidth = kScreen_width/kImageHead_height * newHeight;
        _imageView.width = newWidth;
        _imageView.frame = CGRectMake(-(newWidth-kScreen_width)/2, 0, newWidth, newHeight);
        
    }
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
