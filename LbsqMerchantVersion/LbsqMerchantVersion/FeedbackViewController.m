//
//  FeedbackViewController.m
//  LbsqMerchantVersion
//
//  Created by Runkun1 on 15/8/20.
//  Copyright (c) 2015年 Runkun. All rights reserved.
//

#import "FeedbackViewController.h"
#import "GCPlaceholderTextView.h"

@interface FeedbackViewController ()<UITextViewDelegate>

@property (nonatomic, strong) GCPlaceholderTextView *feedbackTV;

@end

@implementation FeedbackViewController

#define kFeedbackTV_height 200

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = kBackgroundColor;
    
    self.navigationItem.titleView = [[YanMethodManager defaultManager] navibarTitle:@"意见反馈"];
    [[YanMethodManager defaultManager] popToViewControllerOnClicked:self selector:@selector(popInFeedbackC)];
    
    _feedbackTV = [[GCPlaceholderTextView alloc] initWithFrame:CGRectMake(15, 64+15, kScreen_width-30, kFeedbackTV_height)];
    _feedbackTV.placeholder = @"请在此填写您对我们的建议,如您有结款/投诉/验证/账号等问题需要处理,请拔打客服热线4000279567";
    _feedbackTV.returnKeyType = UIReturnKeySend;
    _feedbackTV.delegate = self;
    _feedbackTV.font = [UIFont systemFontOfSize:kFontSize_2];
    [self.view addSubview:_feedbackTV];
    
    UIButton *sendBtn = [ControlExtension buttonInitWithFrame:CGRectMake(_feedbackTV.left, _feedbackTV.bottom + 20, _feedbackTV.width, 45) title:@"发送" style:UIButtonTypeSystem font:kFontSize_2 titleColor:[UIColor whiteColor]];
    sendBtn.backgroundColor = kNaviBarColor;
    sendBtn.layer.cornerRadius = 5;
    [sendBtn addTarget:self action:@selector(sendBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendBtn];
    
    
    // Do any additional setup after loading the view.
}

-(void)sendBtnAction
{
    
}

-(void)popInFeedbackC
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    ((TabbarViewController *)self.tabBarController).tabBarView.hidden = YES;
}

#pragma mark UITextView
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
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
