// Autogenerated from Pigeon (v10.1.6), do not edit directly.
// See also: https://pub.dev/packages/pigeon

#import "FLTTakePhotoApi.h"

#if TARGET_OS_OSX
#import <FlutterMacOS/FlutterMacOS.h>
#else
#import <Flutter/Flutter.h>
#endif

#if !__has_feature(objc_arc)
#error File requires ARC to be enabled.
#endif

static NSArray *wrapResult(id result, FlutterError *error) {
  if (error) {
    return @[
      error.code ?: [NSNull null], error.message ?: [NSNull null], error.details ?: [NSNull null]
    ];
  }
  return @[ result ?: [NSNull null] ];
}
static id GetNullableObjectAtIndex(NSArray *array, NSInteger key) {
  id result = array[key];
  return (result == [NSNull null]) ? nil : result;
}

NSObject<FlutterMessageCodec> *FLTTakePhotoHostApiGetCodec(void) {
  static FlutterStandardMessageCodec *sSharedObject = nil;
  sSharedObject = [FlutterStandardMessageCodec sharedInstance];
  return sSharedObject;
}

void FLTTakePhotoHostApiSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<FLTTakePhotoHostApi> *api) {
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.dh_native_photo.TakePhotoHostApi.takeCardPhoto"
        binaryMessenger:binaryMessenger
        codec:FLTTakePhotoHostApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(takeCardPhotoIsBack:completion:)], @"FLTTakePhotoHostApi api (%@) doesn't respond to @selector(takeCardPhotoIsBack:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSNumber *arg_isBack = GetNullableObjectAtIndex(args, 0);
        [api takeCardPhotoIsBack:arg_isBack completion:^(FlutterStandardTypedData *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.dh_native_photo.TakePhotoHostApi.takeSelfPhoto"
        binaryMessenger:binaryMessenger
        codec:FLTTakePhotoHostApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(takeSelfPhotoIsHand:completion:)], @"FLTTakePhotoHostApi api (%@) doesn't respond to @selector(takeSelfPhotoIsHand:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSNumber *arg_isHand = GetNullableObjectAtIndex(args, 0);
        [api takeSelfPhotoIsHand:arg_isHand completion:^(FlutterStandardTypedData *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
}
NSObject<FlutterMessageCodec> *FLTTakePhotoFlutterApiGetCodec(void) {
  static FlutterStandardMessageCodec *sSharedObject = nil;
  sSharedObject = [FlutterStandardMessageCodec sharedInstance];
  return sSharedObject;
}

@interface FLTTakePhotoFlutterApi ()
@property(nonatomic, strong) NSObject<FlutterBinaryMessenger> *binaryMessenger;
@end

@implementation FLTTakePhotoFlutterApi

- (instancetype)initWithBinaryMessenger:(NSObject<FlutterBinaryMessenger> *)binaryMessenger {
  self = [super init];
  if (self) {
    _binaryMessenger = binaryMessenger;
  }
  return self;
}
- (void)onTakeCardPhotoIsBack:(NSNumber *)arg_isBack data:(nullable FlutterStandardTypedData *)arg_data completion:(void (^)(FlutterError *_Nullable))completion {
  FlutterBasicMessageChannel *channel =
    [FlutterBasicMessageChannel
      messageChannelWithName:@"dev.flutter.pigeon.dh_native_photo.TakePhotoFlutterApi.onTakeCardPhoto"
      binaryMessenger:self.binaryMessenger
      codec:FLTTakePhotoFlutterApiGetCodec()];
  [channel sendMessage:@[arg_isBack ?: [NSNull null], arg_data ?: [NSNull null]] reply:^(id reply) {
    completion(nil);
  }];
}
- (void)onTakeSelfPhotoIsHand:(NSNumber *)arg_isHand data:(nullable FlutterStandardTypedData *)arg_data completion:(void (^)(FlutterError *_Nullable))completion {
  FlutterBasicMessageChannel *channel =
    [FlutterBasicMessageChannel
      messageChannelWithName:@"dev.flutter.pigeon.dh_native_photo.TakePhotoFlutterApi.onTakeSelfPhoto"
      binaryMessenger:self.binaryMessenger
      codec:FLTTakePhotoFlutterApiGetCodec()];
  [channel sendMessage:@[arg_isHand ?: [NSNull null], arg_data ?: [NSNull null]] reply:^(id reply) {
    completion(nil);
  }];
}
@end

