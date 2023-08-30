library dh_native_takephoto;

import 'dart:typed_data';
import 'src/ff_native_takephoto.dart';
export 'src/ff_native_takephoto.dart';

class DhNativePhoto {
  // Future<String?> getPlatformVersion() {
  //   return DhNativePhotoPlatform.instance.getPlatformVersion();
  // }
  factory DhNativePhoto() => _dhNativePhoto;
  DhNativePhoto._();
  static final DhNativePhoto _dhNativePhoto = DhNativePhoto._();
  final TakePhotoHostApi _takePhotoApi = TakePhotoHostApi();

  /// take screenshot by native
  Future<Uint8List?> takeCardPhoto(bool isBack) => _takePhotoApi.takeCardPhoto(isBack);
  Future<Uint8List?> takeSelfPhoto(bool isHand) => _takePhotoApi.takeSelfPhoto(isHand);

  /// ScreenshotFlutterApi setup
  void setup(TakePhotoFlutterApi api) => TakePhotoFlutterApi.setup(api);
}
