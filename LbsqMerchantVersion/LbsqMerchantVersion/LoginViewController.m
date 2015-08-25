//
//  LoginViewController.m
//  LbsqMerchantVersion
//
//  Created by Runkun1 on 15/8/25.
//  Copyright (c) 2015年 Runkun. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginCell.h"
#import "TabbarViewController.h"

@interface LoginViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kBackgroundColor;
    self.navigationController.navigationBar.barTintColor = kNaviBarColor;
    self.navigationItem.titleView = [[YanMethodManager defaultManager] navibarTitle:@"登录"];
    if (_presented) {
        UIButton *dismissBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        dismissBtn.frame = CGRectMake(0, 0, 40, 25);
        [dismissBtn setTitle:@"取消" forState:UIControlStateNormal];
        [dismissBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        dismissBtn.titleLabel.font = [UIFont systemFontOfSize:kFontSize_2];
        [dismissBtn addTarget:self action:@selector(dismissBtnAction) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:dismissBtn];
    }
    
    [self createLoginSubvies];
    // Do any additional setup after loading the view.
}

#define kLoginCell_height 40

-(void)createLoginSubvies
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreen_width, kScreen_height)];
    _scrollView.contentSize = CGSizeMake(kScreen_width, _scrollView.height);
    [self.view addSubview:_scrollView];
    
    UIImageView *header = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30, 180, 45)];
    header.backgroundColor = KRandomColor;
    header.centerX = kScreen_width/2;
    [_scrollView addSubview:header];
    
    NSArray *holders = @[@"账号", @"密码"];
    for (int i = 0; i < 2; i++) {
        LoginCell *login = [[LoginCell alloc] initWithFrame:CGRectMake(0, header.bottom + 80 + (kLoginCell_height + 20)*i, kScreen_width-100, kLoginCell_height) image:nil placeholder:holders[i]];
        login.centerX = kScreen_width/2;
        login.tag = 550 + i;
        if (i == 1) {
            login.textField.secureTextEntry = YES;
        }
        [_scrollView addSubview:login];
    }
    
    UIButton *loginBtn = [ControlExtension buttonInitWithFrame:CGRectMake(0, header.bottom+40+2*kLoginCell_height+100, kScreen_width-80, kLoginCell_height) title:@"登录" style:UIButtonTypeSystem font:kFontSize_2 titleColor:[UIColor whiteColor]];
    loginBtn.centerX = kScreen_width/2;
    loginBtn.backgroundColor = kNaviBarColor;
    loginBtn.tag = 600;
    loginBtn.layer.cornerRadius = 5;
    [loginBtn addTarget:self action:@selector(loginBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:loginBtn];
    
    UIButton *forgetBtn = [ControlExtension buttonInitWithFrame:CGRectMake(0, loginBtn.bottom+5, 200, 30) title:@"忘记密码" style:UIButtonTypeSystem font:kFontSize_3 titleColor:[UIColor orangeColor]];
    forgetBtn.centerX = kScreen_width/2;
    forgetBtn.tag = 601;
    [forgetBtn addTarget:self action:@selector(loginBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:forgetBtn];

}

-(void)loginBtnAction:(UIButton *)button
{
    if (button.tag == 600) {
        TabbarViewController *tabVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
        [self presentViewController:tabVC animated:YES completion:nil];
    } else {
        
    }
}

-(void)dismissBtnAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
