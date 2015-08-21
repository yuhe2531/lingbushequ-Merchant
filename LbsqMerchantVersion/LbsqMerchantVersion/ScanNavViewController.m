//
//  ScanNavViewController.m
//  LbsqMerchantVersion
//
//  Created by Runkun1 on 15/8/18.
//  Copyright (c) 2015年 Runkun. All rights reserved.
//

#import "ScanNavViewController.h"

@interface ScanNavViewController ()<UIGestureRecognizerDelegate>

@end

@implementation ScanNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.barTintColor = kNaviBarColor;
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    id target = self.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
    self.interactivePopGestureRecognizer.enabled = NO;
    
    // Do any additional setup after loading the view.
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return NO;
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
