import 'package:pigeon/pigeon.dart';

/// Flutter call Native
@HostApi()
abstract class TakePhotoHostApi {
  @async
  Uint8List? takeCardPhoto(bool isBack);

  @async
  Uint8List? takeSelfPhoto(bool isHand);
}

/// Native call Flutter
@FlutterApi()
abstract class TakePhotoFlutterApi {
  void onTakeCardPhoto(bool isBack, Uint8List? data);
  void onTakeSelfPhoto(bool isHand, Uint8List? data);
}
