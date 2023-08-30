#import "DhNativePhotoPlugin.h"
#import "DDPhotoViewController.h"
#import "FtspPhotograph.h"

static FLTTakePhotoFlutterApi *takePhotoFlutterApi;

@implementation DhNativePhotoPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  //FlutterMethodChannel* channel = [FlutterMethodChannel methodChannelWithName:@"dh_native_photo" binaryMessenger:[registrar messenger]];
    DhNativePhotoPlugin* instance = [[DhNativePhotoPlugin alloc] init];
    FLTTakePhotoHostApiSetup(registrar.messenger, instance);
  //[registrar addMethodCallDelegate:instance channel:channel];
    takePhotoFlutterApi = [[FLTTakePhotoFlutterApi alloc] initWithBinaryMessenger:registrar.messenger];
}

//- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
//  if ([@"getPlatformVersion" isEqualToString:call.method]) {
//    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
//  } else {
//    result(FlutterMethodNotImplemented);
//  }
//}

- (UIViewController *)viewControllerWithWindow:(UIWindow *)window {
  UIWindow *windowToUse = window;
  if (windowToUse == nil) {
    for (UIWindow *window in [UIApplication sharedApplication].windows) {
      if (window.isKeyWindow) {
        windowToUse = window;
        break;
      }
    }
  }

  UIViewController *topController = windowToUse.rootViewController;
  while (topController.presentedViewController) {
    topController = topController.presentedViewController;
  }
  return topController;
}

- (void)takeCardPhotoIsBack:(nonnull NSNumber *)isBack completion:(nonnull void (^)(FlutterStandardTypedData * _Nullable, FlutterError * _Nullable))completion {
    DDPhotoViewController *vc = [[DDPhotoViewController alloc] init];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    vc.imageblock = ^(UIImage *image) {
        NSData *data = UIImageJPEGRepresentation(image, 0.9);
        if (data == nil || data.length == 0) {
            FlutterError *err = [FlutterError errorWithCode:@"4000" message:@"photo err" details:nil];
            completion(nil, err);
        } else {
            FlutterStandardTypedData *typedData = [FlutterStandardTypedData typedDataWithBytes:data];
            completion(typedData, nil);
        }
    };
  [[self viewControllerWithWindow:nil] presentViewController:vc animated:YES completion:nil];
}

- (void)takeSelfPhotoIsHand:(nonnull NSNumber *)isHand completion:(nonnull void (^)(FlutterStandardTypedData * _Nullable, FlutterError * _Nullable))completion {

    FtspPhotograph * vc = [[FtspPhotograph alloc]init];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    vc.isHand = isHand.boolValue;
    vc.selHeadImageHande = ^(UIImage * _Nonnull image) {
        NSData *data = UIImageJPEGRepresentation(image, 0.9);
        if (data == nil || data.length == 0) {
            FlutterError *err = [FlutterError errorWithCode:@"4000" message:@"photo err" details:nil];
            completion(nil, err);
        } else {
            FlutterStandardTypedData *typedData = [FlutterStandardTypedData typedDataWithBytes:data];
            completion(typedData, nil);
        }
    };
    [[self viewControllerWithWindow:nil] presentViewController:vc animated:YES completion:nil];
}

@end
