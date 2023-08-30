import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'dh_native_photo_platform_interface.dart';

/// An implementation of [DhNativePhotoPlatform] that uses method channels.
class MethodChannelDhNativePhoto extends DhNativePhotoPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('dh_native_photo');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
