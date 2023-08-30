//
//  FtspPhotograph.m
//  Rapipeso
//
//  Created by 马淑栋 on 2022/10/11.
//

#import "FtspPhotograph.h"
#import <Masonry/Masonry.h>
#import "DHCommon.h"


@interface FtspPhotograph ()
{
    int count ;
    UIButton *_photoButotn;
    UIView   *_downView;
    UIImage * _photopImage;
    NSInteger selectedFirstTag;
    NSInteger selectedSecondTag;
}

@property (nonatomic ,strong) UIButton * backBtn;
@property (nonatomic ,strong) UIView * viewb;

@property (nonatomic ,strong) UIButton * frontOrBackBtn;
@property (nonatomic, strong) UIImageView *roundBgImgView;

@end

@implementation FtspPhotograph

- (void)viewDidLoad {
    [super viewDidLoad];
   
//    self.navigationBar.hidden = YES;
//    self.view.backgroundColor = UIColorHex(#000000);
    [self MakeMyCapture];
    
    
    [self.view addSubview:self.backBtn];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(ZWTStatusBarHeight + (10));
        make.left.offset((15));
        make.height.offset((30));
        make.width.offset((35));
    }];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    
    if (self.session) {
        
        [self.session startRunning];
    }
}


- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:YES];
    if (self.session) {
        
        [self.session stopRunning];
    }
}
-(void)backBarBtnClick{
    [self dismissViewControllerAnimated:true completion:nil];
//    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 构造自定义相机


- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition) position {

    
    if (@available(iOS 10.0, *)) {
        AVCaptureDeviceDiscoverySession *captureDeviceDiscoverySession = [AVCaptureDeviceDiscoverySession discoverySessionWithDeviceTypes:@[AVCaptureDeviceTypeBuiltInWideAngleCamera] mediaType:AVMediaTypeVideo position:position];
        NSArray *devices = [captureDeviceDiscoverySession devices];
        for (AVCaptureDevice *device in devices ){
            if ( device.position == position ){
                return device;
            }
        }
    } else {
        // Fallback on earlier versions
    }
    
   

      

    return nil ;

}
/**
 切换摄像头按钮的点击方法的实现（切换摄像头时可以添加转场动画）
 */
-(void)frontOrBackAction{
    //获取摄像头的数量（该方法会返回当前能够输入视频的全部设备，包括前后摄像头和外接设备）
    NSInteger cameraCount = [[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] count];
    //摄像头的数量小于等于1的时候直接返回
    if (cameraCount <= 1) {
        return;
    }
    AVCaptureDevice *newCamera = nil;
    AVCaptureDeviceInput *newInput = nil;
    //获取当前相机的方向（前/后）
    AVCaptureDevicePosition position = [[self.videoInput device] position];
 
    //为摄像头的转换加转场动画
    CATransition *animation = [CATransition animation];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 0.5;
    animation.type = @"oglFlip";
 
    if (position == AVCaptureDevicePositionFront) {
        newCamera = [self cameraWithPosition:AVCaptureDevicePositionBack];
        animation.subtype = kCATransitionFromLeft;
 
    }else if (position == AVCaptureDevicePositionBack){
        newCamera = [self cameraWithPosition:AVCaptureDevicePositionFront];
        animation.subtype = kCATransitionFromRight;
    }
    // 添加动画
    [self.previewLayer addAnimation:animation forKey:nil];
 
    //输入流
    newInput = [AVCaptureDeviceInput deviceInputWithDevice:newCamera error:nil];
    if (newInput != nil) {
        [self.session beginConfiguration];
        [newCamera lockForConfiguration:nil];
        //先移除原来的input
        [self.session removeInput:self.videoInput];
        if ([self.session canAddInput:newInput]) {
            [self.session addInput:newInput];
            self.videoInput = newInput;
        }else{
            //如果不能加现在的input，就加原来的input
            [self.session addInput:self.videoInput];
        }
        [newCamera unlockForConfiguration];
        [self.session commitConfiguration];
    }
    
}

-(void)MakeMyCapture {

    self.session = [[AVCaptureSession alloc] init];
    NSError *error;
    //AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDevice * device = [self cameraWithPosition:AVCaptureDevicePositionFront];
    //[device setValue:@"AVCaptureDevicePositionFront" forKey:NSStringFromSelector(@selector(position))];
    //device.position = AVCaptureDevicePositionFront ;
    
    
    
    //更改这个设置的时候必须先锁定设备，修改完后再解锁，否则崩溃
//    [device lockForConfiguration:nil];
//    //设置闪光灯为自动
//    if ([device isFlashModeSupported:AVCaptureFlashModeAuto]) {
//        [device setFlashMode:AVCaptureFlashModeAuto];
//    } else {
//        [device setFlashMode:AVCaptureFlashModeOff];
//    }
//    [device unlockForConfiguration];
    
    self.videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:device error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary * outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey, nil];
    [self.stillImageOutput setOutputSettings:outputSettings];
    
    if ([self.session canAddInput:self.videoInput]) {
        [self.session addInput:self.videoInput];
    }
    if ([self.session canAddOutput:self.stillImageOutput]) {
        [self.session addOutput:self.stillImageOutput];
    }
    
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    
    self.previewLayer.frame = CGRectMake(0 ,0,kScreenWidth ,kScreenHeight);
    self.previewLayer.videoGravity = AVLayerVideoGravityResize;
    //    [self.previewLayer setBounds:self.view.bounds];
    self.previewLayer.contentsScale = [UIScreen mainScreen].scale;
//    self.previewLayer.backgroundColor = [[UIColor redColor]CGColor];
    
    self.view.layer.masksToBounds = YES;
    
    [self.view.layer addSublayer:self.previewLayer];
    
    [device lockForConfiguration:nil];
    CGPoint cpoint = CGPointMake(kScreenWidth*0.5, kScreenHeight*0.5);
    // 设置聚焦点的位置
    if ([device isFocusPointOfInterestSupported]) {
    [device setFocusPointOfInterest:cpoint];
    }
    // 设置聚焦模式
    if ([device isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus]) {
    [device setFocusMode:AVCaptureFocusModeContinuousAutoFocus];
    }
    [device unlockForConfiguration];
    
    UIImage *roundBgImg = SmartImageNamed(@"photo_bg");
    CGSize  imageSize = roundBgImg.size;
    UIImageView * photoimageView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth -imageSize.width)/2 ,(kScreenHeight - imageSize.height)/2,imageSize.width ,imageSize.height)];
    photoimageView.image = roundBgImg;
    self.roundBgImgView = photoimageView;
    [self.view  addSubview:photoimageView];
    
    
    //创建相机下面自定义视图
    [self createCusphototV];
}
-(void)createCusphototV
{
    CGFloat viewH = 140;
    _downView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-viewH, kScreenWidth, viewH)];
    _downView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_downView];
    //加上相机按钮和其他的自定义按钮
    _photoButotn = [[UIButton alloc] init];
    [_photoButotn setBackgroundImage:SmartImageNamed(@"toke_photo_f") forState:UIControlStateNormal];
    [_photoButotn addTarget:self action:@selector(SavePhoto:) forControlEvents:UIControlEventTouchUpInside];
    [_downView addSubview:_photoButotn];
    _photoButotn.frame = CGRectMake((kScreenWidth-76)/2, 40, 76, 76);
    
    
    self.frontOrBackBtn = [[UIButton alloc] init];
    [self.frontOrBackBtn setImage:SmartImageNamed(@"toggle") forState:UIControlStateNormal];
    [self.frontOrBackBtn addTarget:self action:@selector(frontOrBackAction) forControlEvents:UIControlEventTouchUpInside];
    [_downView addSubview:self.frontOrBackBtn];
    self.frontOrBackBtn.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.6];
    self.frontOrBackBtn.layer.cornerRadius = 22;
    self.frontOrBackBtn.layer.masksToBounds = true;
    self.frontOrBackBtn.frame = CGRectMake(kScreenWidth-60, 40+(76-44)*0.5, 44, 44);
        //创建状态button
//    if([self.taskTypeStr isEqualToString:@"上画"])
//    {
//        [self createstaButton:_downView];
//    }
    
//    FtspConfigModel *config = [FtspStroModelExpand configModelWith:ConfigListTable];
//    FtspHomeUserInfoModel * userModel = [FtspStroModelExpand userInfoModelWith:LoanUserInfoTable];
//    NSString *mobile = userModel.mobile ?: @"-1";
//    NSString *mobileSuf = [mobile substringFromIndex:mobile.length-1];
//    NSString *hand_mobile_suffix = config.hand_mobile_suffix_ios ?: @"-1";
//    NSArray *suffixArr = [hand_mobile_suffix componentsSeparatedByString:@","];
//    if (config.hand_id_ios.integerValue == 1 && ([suffixArr containsObject:@"-1"] || [suffixArr containsObject:mobileSuf])) {
    if(self.isHand){
        self.frontOrBackBtn.hidden = false;
        self.roundBgImgView.hidden = true;
    }else{
        self.frontOrBackBtn.hidden = true;
        self.roundBgImgView.hidden = false;
    }
}

-(void)SavePhoto:(UIButton *)button
{
    //进行拍照保存图片
    AVCaptureConnection *conntion = [self.stillImageOutput connectionWithMediaType:AVMediaTypeVideo];
    if (!conntion) {
        NSLog(@"拍照失败!");
        return;
    }
    [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:conntion completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (imageDataSampleBuffer == nil) {
            return ;
        }
        NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        self->_photopImage = [UIImage imageWithData:imageData];
//        CGSize  imageSize = [UIImage imageNamed:@"photo_bg"].size;
//        CGSize bigImageSize2 = self->_photopImage.size;
//        NSLog(@"%lf === %lf",imageSize.width,imageSize.height);
//        NSLog(@"%lf === %lf",bigImageSize2.width/kScreenWidth,bigImageSize2.height/kScreenHeight);
        
        //先压缩
//        self->_photopImage = [self imageWithImage:self->_photopImage scaledToSize:CGSizeMake(kScreenWidth,kScreenHeight)];
        
        /* 这个是截图人脸的方法，测试不让截图，要全部的搞不懂.....
         后来沟通了 回显的时候 在截取
         */
        //self->_photopImage = [self getImageByCuttingImage:self->_photopImage ToRect:CGRectMake((kScreenWidth -(330))/2 ,(kScreenHeight - imageSize.height)/2,(330) ,imageSize.height)];
       [self Dophoto];
        
    }];
}


- (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (  UIImage  *)getImageByCuttingImage:(  UIImage  *)image ToRect:(  CGRect  )rect {

    //  大图  bigImage
    //  定义  myImageRect  ，截图的区域
    CGRect    toImageRect = rect;
    UIImage  *bigImage= image;

    CGImageRef  imageRef = bigImage.CGImage;
    CGImageRef  subImageRef =  CGImageCreateWithImageInRect(imageRef, toImageRect);

    CGSize size;
    size.  width  = rect.size.width;
    size.  height  = rect.size.height;

    UIGraphicsBeginImageContext(size);
    CGContextRef  context =  UIGraphicsGetCurrentContext ();
    CGContextDrawImage(context, toImageRect, subImageRef);
    UIImage  *smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();

    return  smallImage;
}


-(void)Dophoto
{
    [self.view addSubview:self.viewb];
    self.viewb.frame = self.view.frame;
    self.viewb.backgroundColor = [UIColor blackColor];
    
    UIImageView *imagev = [[UIImageView alloc] initWithImage:_photopImage];
    imagev.contentMode = UIViewContentModeScaleAspectFit;
    imagev.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [self.viewb addSubview:imagev];
    
    UIView * bottomBgview = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 60, kScreenWidth, 60)];
    bottomBgview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    [self.viewb addSubview:bottomBgview];
    
    UIButton *leftbutton = [[UIButton alloc]init];
    [leftbutton setTitle:@"cancelación" forState:UIControlStateNormal];
    [leftbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    leftbutton.titleLabel.font = [UIFont systemFontOfSize:17];
    leftbutton.tag = 1001;
    [leftbutton setTintColor:[UIColor whiteColor]];
    [bottomBgview addSubview:leftbutton];
    [leftbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset((15));
        make.centerY.equalTo(bottomBgview.mas_centerY);
        make.height.offset((30));
    }];
    [leftbutton addTarget:self action:@selector(hitopbutton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *rightbutton = [[UIButton alloc]init];
    [rightbutton setTitle:@"determinar" forState:UIControlStateNormal];
    [rightbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightbutton.titleLabel.font = [UIFont systemFontOfSize:17];
    rightbutton.tag = 1000;
    [rightbutton setTintColor:[UIColor whiteColor]];
    [bottomBgview addSubview:rightbutton];
    [rightbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-(15));
        make.centerY.equalTo(bottomBgview.mas_centerY);
        make.height.offset((30));
    }];
    [rightbutton addTarget:self action:@selector(hitopbutton:) forControlEvents:UIControlEventTouchUpInside];

}
-(void)hitopbutton:(UIButton *)button
{
    [self.viewb removeFromSuperview];
    [button.superview removeFromSuperview];
    if(button.tag == 1000){
//        [self savePicturePath];
//        for (UIViewController*controller in [self.navigationController viewControllers])
//        {
//            if ([controller isKindOfClass:NSClassFromString(@"FtspInfowriteIdentityAutodyne")])
//            {
//                UIViewController * vc = controller;
                if (self.selHeadImageHande) {
                    self.selHeadImageHande(self->_photopImage);
                }
                [self dismissViewControllerAnimated:true completion:nil];
//                [self.navigationController popToViewController:vc animated:YES];
//            }
//        }
        
    }
    else{
        
        
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


- (UIButton *)backBtn
{
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:SmartImageNamed(@"nav_back_w") forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backBarBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (UIView *)viewb
{
    if (!_viewb) {
        _viewb = [[UIView alloc] init];
    }
    return _viewb;
}


@end
