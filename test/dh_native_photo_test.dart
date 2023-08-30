import 'package:flutter_test/flutter_test.dart';
// import 'package:dh_native_photo/dh_native_photo.dart';
import 'package:dh_native_photo/dh_native_photo_platform_interface.dart';
import 'package:dh_native_photo/dh_native_photo_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDhNativePhotoPlatform with MockPlatformInterfaceMixin implements DhNativePhotoPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final DhNativePhotoPlatform initialPlatform = DhNativePhotoPlatform.instance;

  test('$MethodChannelDhNativePhoto is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDhNativePhoto>());
  });

  test('getPlatformVersion', () async {
    // DhNativePhoto dhNativePhotoPlugin = DhNativePhoto();
    // MockDhNativePhotoPlatform fakePlatform = MockDhNativePhotoPlatform();
    // DhNativePhotoPlatform.instance = fakePlatform;

    // expect(await dhNativePhotoPlugin.getPlatformVersion(), '42');
  });
}
