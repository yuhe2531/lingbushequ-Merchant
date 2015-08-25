//
//  GoodsInfoViewController.m
//  LbsqMerchantVersion
//
//  Created by Runkun1 on 15/8/22.
//  Copyright (c) 2015年 Runkun. All rights reserved.
//

#import "GoodsInfoViewController.h"
#import "GoodsHeaderView.h"
#import "GoodsInfoTableViewCell.h"
#import "VPImageCropperViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>

#define ORIGINAL_MAX_WIDTH kScreen_width

@interface GoodsInfoViewController ()<UITextFieldDelegate, UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, VPImageCropperDelegate>

@property (nonatomic, assign) BOOL canEdit;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *goodsTitles;
@property (nonatomic, strong) GoodsHeaderView *headerView;
@property (nonatomic, assign) BOOL isRecommend;
@property (nonatomic, assign) BOOL isTejia;

@end

@implementation GoodsInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _canEdit = NO;
    
    self.view.backgroundColor = kBackgroundColor;
    self.navigationItem.titleView = [[YanMethodManager defaultManager] navibarTitle:@"商品信息"];
    [[YanMethodManager defaultManager] popToViewControllerOnClicked:self selector:@selector(popInGoodsInfoC)];
    UIButton *editBtn = [ControlExtension buttonInitWithFrame:CGRectMake(0, 0, 45, 25) title:@"编辑" style:UIButtonTypeSystem font:kFontSize_3 titleColor:[UIColor whiteColor]];
    editBtn.tag = 3000;
    editBtn.layer.borderColor = kDividColor.CGColor;
    editBtn.layer.borderWidth = 0.5;
    editBtn.layer.cornerRadius = 4;
    [editBtn addTarget:self action:@selector(editBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:editBtn];
    
    [self createGoodsInfoCSubviews];
    
    //键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    // Do any additional setup after loading the view.
}

#define kHeaderView_height 230

-(void)createGoodsInfoCSubviews
{
    _headerView = [[GoodsHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreen_width, kHeaderView_height) image:nil title:@"15665797058"];
    //点击icon更换头像
    __weak GoodsInfoViewController *weakSelf = self;
    _headerView.tapActionBlock = ^{
        if (weakSelf.canEdit) {
            NSLog(@"========== 更换商品图片");
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:weakSelf cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选区", nil];
            [actionSheet showInView:weakSelf.view];
        }
    };
    
    _goodsTitles = @[@"商品分类:", @"商品名称:", @"商品价格:", @"是否特价:", @"首页推荐:"];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreen_width, kScreen_height-64) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    _tableView.tableHeaderView = _headerView;
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_width, 200)];
    [YanMethodManager lineViewWithFrame:CGRectMake(15, 0, kScreen_width, 0.5) superView:footer];
    UIButton *saveBtn = [ControlExtension buttonInitWithFrame:CGRectMake(30, 40, kScreen_width-60, 40) title:@"保存并上架" style:UIButtonTypeSystem font:kFontSize_2 titleColor:[UIColor whiteColor]];
    saveBtn.backgroundColor = kNaviBarColor;
    saveBtn.layer.cornerRadius = 5;
    saveBtn.layer.borderWidth = 0.5;
    saveBtn.layer.borderColor = kDividColor.CGColor;
    saveBtn.tag = 500;
    [saveBtn addTarget:self action:@selector(goodsInfoBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:saveBtn];
    
    UIButton *deleBtn = [ControlExtension buttonInitWithFrame:CGRectMake(saveBtn.left, saveBtn.bottom+15, kScreen_width-60, 40) title:@"下架" style:UIButtonTypeSystem font:kFontSize_2 titleColor:[UIColor whiteColor]];
    deleBtn.backgroundColor = kNaviBarColor;
    deleBtn.layer.cornerRadius = 5;
    deleBtn.layer.borderWidth = 0.5;
    deleBtn.layer.borderColor = kDividColor.CGColor;
    deleBtn.tag = 501;
    [deleBtn addTarget:self action:@selector(goodsInfoBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:deleBtn];
    _tableView.tableFooterView = footer;
}

-(void)goodsInfoBtnAction:(UIButton *)button
{
    if (button.tag == 500) {//保存并上架
        _canEdit = NO;
        UIButton *editBtn = (UIButton *)[self.navigationController.view viewWithTag:3000];
        [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [_tableView reloadData];
    } else {//下架
        
    }
}

#pragma mark UITableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *goods = @"goods";
    GoodsInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:goods];
    if (!cell) {
        cell = [[GoodsInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:goods title:_goodsTitles[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (indexPath.row == 3 || indexPath.row == 4) {
        cell.isPrice = YES;
    } else {
        cell.isPrice = NO;
    }
    cell.contentTF.returnKeyType = UIReturnKeyDone;
    cell.contentTF.tag = 400 + indexPath.row;
    cell.contentTF.delegate = self;
    cell.canEdit = _canEdit;
    if (indexPath.row == 3) {
        cell.goodsSwitch.on = _isRecommend;
    } else {
        cell.goodsSwitch.on = _isTejia;
    }
    cell.goodsSwitchBlock = ^(UISwitch *goodsSwitch){
        if (indexPath.row == 3) {
            _isRecommend = goodsSwitch.isOn;
        } else {
            _isTejia = goodsSwitch.isOn;
        }
    };
    return cell;
}

#pragma mark UITextField

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField.tag == 403 || textField.tag == 404) {
        if (textField.text.length > 0) {
            textField.text = [@"¥ " stringByAppendingString:textField.text];
        }
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)editBtnAction:(UIButton *)button
{
    _canEdit = !_canEdit;
    if (_canEdit) {
        [button setTitle:@"完成" forState:UIControlStateNormal];
    } else {
        [button setTitle:@"编辑" forState:UIControlStateNormal];
    }
    [_tableView reloadData];
}

-(void)popInGoodsInfoC
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)keyBoardWillShow:(NSNotification *)noti
{
    CGRect rect = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat ty = rect.size.height;
    [UIView animateWithDuration:0.5 animations:^{
        _tableView.height = kScreen_height - 64 - ty;
    }];
}

-(void)keyBoardWillHide:(NSNotification *)noti
{
    [UIView animateWithDuration:0.5 animations:^{
        _tableView.height = kScreen_height - 64;
    }];
}

#pragma mark 更换商品图片相关
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([self isFrontCameraAvailable]) {
                controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            }
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                             }];
        }
    } else {
        // 从相册中选取
        if ([self isPhotoLibraryAvailable]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                             }];
        }
    }
}

#pragma mark VPImageCropperDelegate
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    self.headerView.imageV.image = editedImage;
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        NSLog(@"=========== 选区照片完成");
        NSData *imageData;
        if (UIImagePNGRepresentation(editedImage) == nil) {
            imageData = UIImageJPEGRepresentation(editedImage, 1);
        }else{
            imageData = UIImagePNGRepresentation(editedImage);
        }
        NSString *imgString = [imageData base64EncodedStringWithOptions:0];
    }];
}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        portraitImg = [self imageByScalingToMaxSize:portraitImg];
        // 裁剪
        VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
        imgEditorVC.delegate = self;
        [self presentViewController:imgEditorVC animated:YES completion:^{
            // TO DO
        }];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}

#pragma mark camera utility
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}

#pragma mark image scale utility
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < ORIGINAL_MAX_WIDTH) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = ORIGINAL_MAX_WIDTH;
        btWidth = sourceImage.size.width * (ORIGINAL_MAX_WIDTH / sourceImage.size.height);
    } else {
        btWidth = ORIGINAL_MAX_WIDTH;
        btHeight = sourceImage.size.height * (ORIGINAL_MAX_WIDTH / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark portraitImageView getter
- (UIImageView *)portraitImageView {
    
    return _headerView.imageV;
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
