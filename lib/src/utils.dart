import "dart:io" show Directory, Platform;
import 'package:flutter/foundation.dart';
import "package:path/path.dart" as path;

String platformDLPath({String? customDebugPath}) {
  const libName = "mediainfo";
  if (kDebugMode) {
    if (Platform.isLinux || Platform.isAndroid) {
      if (customDebugPath != null) {
        return "$customDebugPath/lib$libName.so";
      } else {
        return "lib$libName.so";
      }
    }
    if (Platform.isMacOS || Platform.isIOS) {
      if (customDebugPath != null) {
        return "$customDebugPath/lib$libName.dylib";
      } else {
        return "lib$libName.dylib";
      }
    }
    if (Platform.isWindows) {
      if (customDebugPath != null) {
        return "$customDebugPath/$libName.dll";
      } else {
        return "$libName.dll";
      }
    }
    throw Exception("Platform Not Supported: ${Platform.operatingSystem}");
  } else {
    if (Platform.isLinux || Platform.isAndroid) {
      return path.join(Directory.current.path, "lib$libName.so");
    }
    if (Platform.isMacOS || Platform.isIOS) {
      return path.join(Directory.current.path, "lib$libName.dylib");
    }
    if (Platform.isWindows) {
      return path.join(Directory.current.path, "$libName.dll");
    }
    throw Exception("Platform Not Supported: ${Platform.operatingSystem}");
  }
}

String getLibZen({String? customDebugPath}) {
  if (Platform.isLinux) {
    if (customDebugPath != null) {
      return path.join(Directory.current.path, "$customDebugPath/libzen.so.0");
    } else {
      return path.join(Directory.current.path, "libzen.so.0");
    }
  }
  throw Exception("Platform Not Supported: ${Platform.operatingSystem}");
}
