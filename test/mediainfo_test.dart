import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_media_info/flutter_media_info.dart';

import "package:path/path.dart" as path;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late String debugPath;

  if (Platform.isLinux) {
    debugPath = "linux/libs/";
  }
  if (Platform.isMacOS) {
    debugPath = "macos/libs/";
  }
  if (Platform.isWindows) {
    debugPath = "windows/libs/";
  }

  test('load mediainfo', () async {
    Mediainfo(customDebugPath: debugPath);
  });

  test('mediainfo get version', () async {
    final mi = Mediainfo(customDebugPath: debugPath);
    final optionResult = mi.option("Info_Version");

    expect(optionResult, "MediaInfoLib - v22.09");
  });

  test('Get music data with quick load', () async {
    final musicPath = path.join(Directory.current.path, "assets/Beat_Thee.mp3");
    final mi = Mediainfo(customDebugPath: debugPath);
    mi.quickLoad(musicPath);
    expect(
        mi.getInfo(
            MediaInfoStreamType.mediaInfoStreamAudio, 0, "BitRate/String"),
        "320 kb/s");
    expect(
        mi.getInfo(
            MediaInfoStreamType.mediaInfoStreamAudio, 0, "Duration/String2"),
        "3 min 11 s");
    expect(
        mi.getInfo(
            MediaInfoStreamType.mediaInfoStreamAudio, 0, "SamplingRate/String"),
        "44.1 kHz");
    expect(
        mi.getInfo(
            MediaInfoStreamType.mediaInfoStreamAudio, 0, "FrameRate/String"),
        "38.281 FPS (1152 SPF)");

    mi.delete();
  });

  test('Get music data with open', () async {
    final musicPath = path.join(Directory.current.path, "assets/Beat_Thee.mp3");
    final mi = Mediainfo(customDebugPath: debugPath);
    mi.init();
    mi.open(musicPath);
    expect(
        mi.getInfo(
            MediaInfoStreamType.mediaInfoStreamAudio, 0, "BitRate/String"),
        "320 kb/s");
    expect(
        mi.getInfo(
            MediaInfoStreamType.mediaInfoStreamAudio, 0, "Duration/String2"),
        "3 min 11 s");
    expect(
        mi.getInfo(
            MediaInfoStreamType.mediaInfoStreamAudio, 0, "SamplingRate/String"),
        "44.1 kHz");
    expect(
        mi.getInfo(
            MediaInfoStreamType.mediaInfoStreamAudio, 0, "FrameRate/String"),
        "38.281 FPS (1152 SPF)");

    mi.close();
    mi.delete();
  });

  test('Invalid usage close', () async {
    final mi = Mediainfo(customDebugPath: debugPath);

    mi.close();
    mi.delete();
  });
}
