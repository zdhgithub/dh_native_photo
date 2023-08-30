import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:dh_native_photo/dh_native_photo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Uint8List? _uint8List;
  Uint8List? _uint8ListHead;
  final _dhNativePhotoPlugin = DhNativePhoto();

  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> takePhoto() async {
    _uint8List = await _dhNativePhotoPlugin.takeCardPhoto(false);

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    if (_uint8List != null) {
      setState(() {
        _uint8List;
      });
    }
  }

  Future<void> takeSelfPhoto(bool isHand) async {
    _uint8ListHead = await _dhNativePhotoPlugin.takeSelfPhoto(isHand);

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    if (_uint8ListHead != null) {
      setState(() {
        _uint8ListHead;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TextButton(onPressed: takePhoto, child: Text("TakePhoto")),
              TextButton(onPressed: () => takeSelfPhoto(false), child: Text("TakeSelfPhoto")),
              if (_uint8List != null)
                Column(
                  children: [
                    Text("CardPhoto"),
                    Image.memory(_uint8List!),
                  ],
                ),
              if (_uint8ListHead != null)
                Column(
                  children: [
                    Text("HeadPhoto"),
                    Image.memory(_uint8ListHead!),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
