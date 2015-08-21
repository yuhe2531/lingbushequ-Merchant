//
//  ScanViewController.m
//  LbsqMerchantVersion
//
//  Created by Runkun1 on 15/8/18.
//  Copyright (c) 2015年 Runkun. All rights reserved.
//

#import "ScanViewController.h"
#import "ZBarSDK.h"
#import "HomeNavViewController.h"

@interface ScanViewController ()<ZBarReaderViewDelegate>

@property (nonatomic, strong) ZBarReaderView *readerView;

@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBackgroundColor;
    
    self.navigationItem.titleView = [[YanMethodManager defaultManager] navibarTitle:@"条码扫描"];
    if (_isPush) {
        [[YanMethodManager defaultManager] popToViewControllerOnClicked:self selector:@selector(popInScanController)];
    }
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    if (_readerView == nil) {
        _readerView = [ZBarReaderView new];
        _readerView.frame = self.view.bounds;
        _readerView.readerDelegate = self;
        [self.view addSubview:_readerView];
        ZBarImageScanner *scanner = _readerView.scanner;
        [scanner setSymbology:ZBAR_I25 config:ZBAR_CFG_ENABLE to:0];
    }
    
    [_readerView start];
}

-(void)readerView:(ZBarReaderView *)readerView didReadSymbols:(ZBarSymbolSet *)symbols fromImage:(UIImage *)image
{
    ZBarSymbol *symbol = nil;
    for (symbol in symbols) {
        NSString *resultCode = symbol.data;
        NSLog(@"========== result code = %@",resultCode);
    }
    [readerView stop];
}

-(void)viewWillDisappear:(BOOL)animated
{
    if (_isPush) {
        _readerView.readerDelegate = nil;
    }
}

-(void)popInScanController
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
