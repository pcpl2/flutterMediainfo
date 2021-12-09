
import 'dart:developer' as developer;

import 'dart:async';

import 'package:flutter/services.dart';

import "dart:ffi";

import "package:ffi/ffi.dart";
import 'package:mediainfo/utils.dart';

class Mediainfo {
  static const MethodChannel _channel = MethodChannel('mediainfo');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  Mediainfo.init() {
    final dlPath = platformPath("");

    try {
      final dylib = DynamicLibrary.open(dlPath);
    } on Exception catch (e) {
      developer.log(e.toString());
    }
  }
}
