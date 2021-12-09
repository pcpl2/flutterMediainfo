import "dart:io" show Platform;
import "package:path/path.dart" as path;

/// Creates a path to the correctly-named dynamic library (which differs by OS)
/// containing the media info lib, given the name of its containing directory
/// (`dlPath`). If the platform is not supported an [Exception] is thrown.
String platformPath(String dlPath) {
  const libName = "mediainfo";
  if (Platform.isLinux || Platform.isAndroid) return path.join(dlPath, "lib$libName.so");
  if (Platform.isMacOS || Platform.isIOS) return path.join(dlPath, "lib$libName.dylib");
  if (Platform.isWindows) return path.join(dlPath, "$libName.dll");
  throw Exception("Platform Not Supported: ${Platform.operatingSystem}");
}
