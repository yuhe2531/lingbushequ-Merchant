//
//  System_ScanViewController.m
//  OCommunity
//
//  Created by runkun2 on 15/8/10.
//  Copyright (c) 2015年 Runkun. All rights reserved.
//

#import "System_ScanViewController.h"
#define kTop 100
#define kLeft 50
@interface System_ScanViewController ()<AVCaptureMetadataOutputObjectsDelegate>
{
    
    AVCaptureSession *session;//输入输出的中间桥梁
    NSTimer * timer;
    int num;
    BOOL upOrdown;

}
@end

@implementation System_ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor grayColor];
    
    self.navigationItem.titleView = [[YanMethodManager defaultManager] navibarTitle:@"条码扫描"];
    if (_isPush) {
        [[YanMethodManager defaultManager] popToViewControllerOnClicked:self selector:@selector(popInScanController)];
    }
   
    //上面框
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,kScreen_width, kTop)];
    view1.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    //下面框
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, kScreen_width - kLeft *2 + kTop , kScreen_width, kScreen_height-(kScreen_width - kLeft *2 +kTop))];
    view2.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(0, kTop, kLeft, kScreen_width - kLeft *2)];
    view3.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    
    UIView *view4 = [[UIView alloc] initWithFrame:CGRectMake(kScreen_width - kLeft, kTop, kLeft, kScreen_width - kLeft *2)];
    view4.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    
    [self.view addSubview:view1];
    [self.view addSubview:view2];
    [self.view addSubview:view3];
    [self.view addSubview:view4];

    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(kLeft-5, kTop-5, kScreen_width -kLeft*2+10, kScreen_width -kLeft*2+10)];
    imageView.image = [UIImage imageNamed:@"pick_bg"];
    [self.view addSubview:imageView];
    
    UILabel * labIntroudction= [[UILabel alloc] initWithFrame:CGRectMake(imageView.left, imageView.bottom +10 ,imageView.width, 60)];
    labIntroudction.font = [UIFont systemFontOfSize:kFontSize_2];
    labIntroudction.backgroundColor = [UIColor clearColor];
    labIntroudction.numberOfLines=0;
    labIntroudction.textColor=[UIColor whiteColor];
    labIntroudction.text = @"将二维码图像置于矩形方框内，离手机摄像头10CM左右，系统会自动识别。";
    [self.view addSubview:labIntroudction];
    


    _line = [[UIImageView alloc] initWithFrame:CGRectMake(50, 110, 220, 2)];
    _line.image = [UIImage imageNamed:@"line.png"];
    [self.view addSubview:_line];


}
-(void)animation1
{
    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake(kLeft+5, kTop+2*num, kScreen_width -kLeft*2-5, 2);
        if (2*num >= kScreen_width -kLeft*2) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        _line.frame = CGRectMake(kLeft+5, kTop+2*num, kScreen_width -kLeft*2-5, 2);
        if (num == 0) {
            upOrdown = NO;
        }
    }
    
}
-(void)backAction
{
    
    [self dismissViewControllerAnimated:YES completion:^{
        [timer invalidate];
        timer = nil;
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
//    [session stopRunning];
//    AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex : 0 ];
//    //输出扫描字符串
//    NSLog(@"%@",metadataObject.stringValue);

    NSString *stringValue;
    
    if ([metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
    
    [session stopRunning];
     NSLog(@"%@",stringValue);
    
    [timer invalidate];
    timer = nil;
    [self.preview removeFromSuperlayer];
  
}
-(void)saomaAction{

    
    upOrdown = NO;
    num =0;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    //创建输出流
    AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];
    //设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //初始化链接对象
    session = [[AVCaptureSession alloc]init];
    //高质量采集率
    [session setSessionPreset:AVCaptureSessionPresetHigh];
    
    if ([session canAddInput:input])
    {
        [session addInput:input];
    }
    
    if ([session canAddOutput:output])
    {
        [session addOutput:output];
    }
    
    //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    CGFloat p1 = kScreen_height/kScreen_width;
    CGFloat p2 = 1920.0/1080.0;
    if (p1<p2) {
        
        CGFloat fixHeight = kScreen_width *1920.0/1080.0;
        CGFloat fixPadding = (fixHeight -kScreen_height)/2;
        //         output.rectOfInterest = CGRectMake((labIntroudction.bottom +20 +fixPadding)/fixHeight, 40/kScreen_width, (kScreen_width -80)/fixHeight, (kScreen_width -80)/kScreen_width);
        output.rectOfInterest = CGRectMake((kTop +fixPadding)/fixHeight, kLeft/kScreen_width, (kScreen_width - kLeft *2)/fixHeight, (kScreen_width - kLeft *2)/kScreen_width);
    }else{
        
        CGFloat fixWidth = kScreen_height *1080.0/1920.0;
        CGFloat fixPadding = (fixWidth -kScreen_width)/2;
        //     output.rectOfInterest = CGRectMake((labIntroudction.bottom +20)/kScreen_height, (40+fixPadding)/fixWidth, (kScreen_width -80)/kScreen_height, (kScreen_width -80)/fixWidth);
        output.rectOfInterest = CGRectMake(kTop/kScreen_height, (kLeft+fixPadding)/fixWidth, (kScreen_width - kLeft *2)/kScreen_height, (kScreen_width - kLeft *2)/fixWidth);
    }
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    //    _preview.frame =CGRectMake(40,labIntroudction.bottom +20,kScreen_width -80,kScreen_width -80);
    _preview.frame = self.view.bounds;
    [self.view.layer insertSublayer:self.preview atIndex:0];
    //开始捕获
    [session startRunning];

}
-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self saomaAction];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [session stopRunning];    
    [timer invalidate];
    timer = nil;
    [self.preview removeFromSuperlayer];
}

-(void)popInScanController
{
    [self.navigationController popViewControllerAnimated:YES];
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
