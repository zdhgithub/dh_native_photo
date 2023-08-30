//
//  FtspPhotograph.h
//  Rapipeso
//
//  Created by 马淑栋 on 2022/10/11.
//

//#import "FtspBaseViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
//#import "FtspInfowriteIdentityAutodyne.h"
NS_ASSUME_NONNULL_BEGIN

@interface FtspPhotograph : UIViewController//FtspBaseViewController
//AVCaptureSession对象来执行输入设备和输出设备之间的数据传递
@property (nonatomic, strong) AVCaptureSession* session;
//AVCaptureDeviceInput对象是输入流
@property (nonatomic, strong) AVCaptureDeviceInput* videoInput;
//照片输出流对象，当然我的照相机只有拍照功能，所以只需要这个对象就够了
@property (nonatomic, strong) AVCaptureStillImageOutput* stillImageOutput;
//预览图层，来显示照相机拍摄到的画面
@property (nonatomic, strong) AVCaptureVideoPreviewLayer* previewLayer;
///是否手持身份证
@property (nonatomic, assign) BOOL isHand;

@property (nonatomic ,copy)void(^selHeadImageHande)(UIImage * image);
@end

NS_ASSUME_NONNULL_END
