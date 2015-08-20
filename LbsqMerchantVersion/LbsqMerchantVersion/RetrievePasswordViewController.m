//
//  RetrievePasswordViewController.m
//  LbsqMerchantVersion
//
//  Created by Runkun1 on 15/8/20.
//  Copyright (c) 2015年 Runkun. All rights reserved.
//

#import "RetrievePasswordViewController.h"
#import "RetrievePWView.h"

@interface RetrievePasswordViewController ()

{
    NSInteger _timeSeconds;
}

@property (nonatomic, strong) RetrievePWView *numberCell;
@property (nonatomic, strong) RetrievePWView *codeCell;
@property (nonatomic, strong) RetrievePWView *passwordCell;
@property (nonatomic, strong) RetrievePWView *vertifyPassCell;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation RetrievePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *title = _isModify ? @"修改密码" : @"找回密码";
    self.navigationItem.titleView = [[YanMethodManager defaultManager] navibarTitle:title];
    
    [[YanMethodManager defaultManager] popToViewControllerOnClicked:self selector:@selector(popInRetrieveC)];
    
    [self createRetrievePasswSubviews];
    
    // Do any additional setup after loading the view.
}

#define kBottomView_height 120
#define kRegistBtn_height 40

-(void)createRetrievePasswSubviews
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_width, kScreen_height) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_width, kBottomView_height)];
    bottomView.backgroundColor = [UIColor whiteColor];
    UIButton *registBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    registBtn.frame = CGRectMake(15, kBottomView_height-kRegistBtn_height-40, kScreen_width-30, kRegistBtn_height);
    registBtn.layer.cornerRadius = 5;
    registBtn.backgroundColor = kNaviBarColor;
    [registBtn setTitle:@"完成" forState:UIControlStateNormal];
    [registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registBtn.titleLabel.font = [UIFont systemFontOfSize:kFontSize_1];
    [registBtn addTarget:self action:@selector(registerAccountAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:registBtn];
    tableView.tableFooterView = bottomView;
}

#pragma mark UITableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

#define kTableView_cell_height 55
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kTableView_cell_height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak RetrievePasswordViewController *weakSelf = self;
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.row) {
        case 0:{
            _numberCell = [[RetrievePWView alloc] initWithFrame:CGRectMake(15, 15, kScreen_width-30, 35) title:@"手   机   号"];
            _numberCell.codeTF.width = _numberCell.width - 30;
            [_numberCell.codeLabel removeFromSuperview];
            [cell.contentView addSubview:_numberCell];
        }
            break;
        case 1:{
            _codeCell = [[RetrievePWView alloc] initWithFrame:CGRectMake(15, 15, kScreen_width-30, 35) title:@"验   证   码"];
            _codeCell.codeBtnBlock = ^{
                //一分钟倒计时
                if ([[YanMethodManager defaultManager] validateMobile:_numberCell.codeTF.text] == NO) {
                    [weakSelf.view makeToast:@"手机号格式错误" duration:1.5 position:@"center"];
                } else {//获取验证码
                    _timeSeconds = 60;
                    weakSelf.codeCell.codeLabel.backgroundColor = [UIColor lightGrayColor];
                    weakSelf.codeCell.codeBtn.enabled = NO;
                    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDownAction) userInfo:nil repeats:YES];
                }
            };
            [cell.contentView addSubview:_codeCell];
        }
            break;
        case 2:{
            _passwordCell = [[RetrievePWView alloc] initWithFrame:CGRectMake(15, 15, kScreen_width-30, 35) title:@"密        码"];
            _passwordCell.codeTF.secureTextEntry = YES;
            _passwordCell.codeTF.width = _passwordCell.width - 30;
            [_passwordCell.codeLabel removeFromSuperview];
            [cell.contentView addSubview:_passwordCell];
            
        }
            break;
        case 3:{
            _vertifyPassCell = [[RetrievePWView alloc] initWithFrame:CGRectMake(15, 15, kScreen_width-30, 35) title:@"确 认 密 码"];
            _vertifyPassCell.codeTF.secureTextEntry = YES;
            _vertifyPassCell.codeTF.width = _vertifyPassCell.width - 30;
            [_vertifyPassCell.codeLabel removeFromSuperview];
            [cell.contentView addSubview:_vertifyPassCell];
        }
            break;
            
        default:
            break;
    }
    return cell;
}

-(void)countDownAction
{
    if (_timeSeconds > 0) {
        _timeSeconds--;
        _codeCell.codeLabel.text = [NSString stringWithFormat:@"验证码(%ld)",_timeSeconds];
    } else {
        [_timer invalidate];
        _codeCell.codeLabel.backgroundColor = kNaviBarColor;
        _codeCell.codeBtn.enabled = YES;
        _codeCell.codeLabel.text = @"获取验证码";
    }
}

-(void)registerAccountAction
{
    
}

-(void)popInRetrieveC
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
