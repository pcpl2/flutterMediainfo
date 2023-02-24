// ignore_for_file: public_member_api_docs
import "dart:io" show Directory, Platform, Process;
import 'package:flutter/foundation.dart';
import "package:flutter_media_info/src/models/cpu_architecture.dart";
import "package:path/path.dart" as path;

String platformDLPath({String? customDebugPath}) {
  const libName = "mediainfo";
  if (kDebugMode) {
    if (Platform.isLinux) {
      if (customDebugPath != null) {
        return "$customDebugPath/lib$libName.so";
      } else {
        return "lib$libName.so";
      }
    }
    if (Platform.isMacOS || Platform.isIOS) {
      if (customDebugPath != null) {
        return "$customDebugPath/lib$libName.0.dylib";
      } else {
        return path.join(
          path.dirname(path.dirname(Platform.resolvedExecutable)),
          'Frameworks',
          'flutter_media_info.framework',
          'Resources',
          'lib$libName.0.dylib',
        );
      }
    }
    if (Platform.isWindows) {
      if (customDebugPath != null) {
        return "$customDebugPath/$libName.dll";
      } else {
        return path.join(
          path.dirname(Platform.resolvedExecutable),
          '$libName.dll',
        );
      }
    }
    throw Exception("Platform Not Supported: ${Platform.operatingSystem}");
  } else {
    if (Platform.isLinux) {
      return path.join(
        path.dirname(Platform.resolvedExecutable),
        "lib$libName.so",
      );
    }
    if (Platform.isMacOS || Platform.isIOS) {
      return path.join(
        path.dirname(path.dirname(Platform.resolvedExecutable)),
        'Frameworks',
        'flutter_media_info.framework',
        'Resources',
        'lib$libName.0.dylib',
      );
    }
    if (Platform.isWindows) {
      return path.join(
        path.dirname(Platform.resolvedExecutable),
        '$libName.dll',
      );
    }
    throw Exception("Platform Not Supported: ${Platform.operatingSystem}");
  }
}

String getLibZen({String? customDebugPath}) {
  if (Platform.isLinux) {
    if (customDebugPath != null) {
      return path.join(Directory.current.path, "$customDebugPath/libzen.so.0");
    } else {
      return path.join(
        path.dirname(Platform.resolvedExecutable),
        "libzen.so.0",
      );
    }
  }
  throw Exception("Platform Not Supported: ${Platform.operatingSystem}");
}

String getNativeUtilsLib({String? customDebugPath}) {
  if (Platform.isMacOS) {
    if (customDebugPath != null) {
      return path.join(
          Directory.current.path, "macos/nu_cmake/libnativeUtils.dylib");
    } else {
      return path.join(
        path.dirname(path.dirname(Platform.resolvedExecutable)),
        'Frameworks',
        'flutter_media_info.framework',
        'Resources',
        'libnativeUtils.dylib',
      );
    }
  } else if (Platform.isLinux) {
    if (customDebugPath != null) {
      return path.join(
          Directory.current.path, "nativeUtils/nu_libs/libnativeUtils.so");
    } else {
      return path.join(
          path.dirname(Platform.resolvedExecutable), "libnativeUtils.so");
    }
  }
  throw Exception("Platform Not Supported: ${Platform.operatingSystem}");
}

String? getRawCpuArch() {
  switch (Platform.operatingSystem) {
    case "android":
    case "linux":
    case "macos":
      try {
        final res = Process.runSync('uname', ["-m"], runInShell: false);
        if (res.exitCode != 0) {
          return null;
        }
        return res.stdout.toString().trim();
      } catch (e) {
        return null;
      }
    case "windows":
      return Platform.environment['PROCESSOR_ARCHITECTURE'];
  }
  return null;
}

CpuArchitecture getCpuArch() {
  final cpuArchRaw = getRawCpuArch();
  if (cpuArchRaw == null) {
    return CpuArchitecture.unknown;
  }
  return CpuArchitectureFactory().fromString(cpuArchRaw);
}
