//
//  System_ScanViewController.h
//  OCommunity
//
//  Created by runkun2 on 15/8/10.
//  Copyright (c) 2015年 Runkun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface System_ScanViewController : UIViewController

@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;
@property (nonatomic, retain) UIImageView * line;
@property (nonatomic, assign) BOOL isPush;

@end
