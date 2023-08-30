fvm flutter pub run pigeon \
  --input photo.dart \
  --dart_out lib/src/ff_native_takephoto.dart \
  --objc_header_out ios/Classes/FLTTakePhotoApi.h \
  --objc_source_out ios/Classes/FLTTakePhotoApi.m \
  --objc_prefix FLT \
  --java_out android/src/main/java/com/dh/plugins/ff_native_takephoto/TakePhotoApi.java \
  --java_package "com.dh.plugins.ff_native_takephoto"