import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'dh_native_photo_method_channel.dart';

abstract class DhNativePhotoPlatform extends PlatformInterface {
  /// Constructs a DhNativePhotoPlatform.
  DhNativePhotoPlatform() : super(token: _token);

  static final Object _token = Object();

  static DhNativePhotoPlatform _instance = MethodChannelDhNativePhoto();

  /// The default instance of [DhNativePhotoPlatform] to use.
  ///
  /// Defaults to [MethodChannelDhNativePhoto].
  static DhNativePhotoPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DhNativePhotoPlatform] when
  /// they register themselves.
  static set instance(DhNativePhotoPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
