import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_media_info/flutter_media_info.dart';

import "package:path/path.dart" as path;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late String _debugPath;

  if (Platform.isLinux) {
    _debugPath = "linux/libs/";
  }
  if (Platform.isMacOS) {
    _debugPath = "macos/libs/";
  }
  if (Platform.isWindows) {
    _debugPath = "windows/libs/";
  }

  test('load mediainfo', () async {
    Mediainfo.init(customDebugPath: _debugPath);
  });

  test('mediainfo get version', () async {
    final _mi = Mediainfo.init(customDebugPath: _debugPath);
    final optionResult = _mi.option("Info_Version");

    expect(optionResult, "MediaInfoLib - v21.09");
  });

  test('Get music data with quick load', () async {
    final musicPath = path.join(Directory.current.path, "assets/Beat_Thee.mp3");
    final _mi = Mediainfo.init(customDebugPath: _debugPath);
    _mi.quickLoad(musicPath);
    expect(
        _mi.getInfo(
            MediaInfoStreamType.mediaInfoStreamAudio, 0, "BitRate/String"),
        "320 kb/s");
    expect(
        _mi.getInfo(
            MediaInfoStreamType.mediaInfoStreamAudio, 0, "Duration/String2"),
        "3 min 11 s");
    expect(
        _mi.getInfo(
            MediaInfoStreamType.mediaInfoStreamAudio, 0, "SamplingRate/String"),
        "44.1 kHz");
    expect(
        _mi.getInfo(
            MediaInfoStreamType.mediaInfoStreamAudio, 0, "FrameRate/String"),
        "38.281 FPS (1152 SPF)");

    _mi.delete();
  });

  test('Get music data with open', () async {
    final musicPath = path.join(Directory.current.path, "assets/Beat_Thee.mp3");
    final _mi = Mediainfo.init(customDebugPath: _debugPath);
    _mi.init();
    _mi.open(musicPath);
    expect(
        _mi.getInfo(
            MediaInfoStreamType.mediaInfoStreamAudio, 0, "BitRate/String"),
        "320 kb/s");
    expect(
        _mi.getInfo(
            MediaInfoStreamType.mediaInfoStreamAudio, 0, "Duration/String2"),
        "3 min 11 s");
    expect(
        _mi.getInfo(
            MediaInfoStreamType.mediaInfoStreamAudio, 0, "SamplingRate/String"),
        "44.1 kHz");
    expect(
        _mi.getInfo(
            MediaInfoStreamType.mediaInfoStreamAudio, 0, "FrameRate/String"),
        "38.281 FPS (1152 SPF)");

    _mi.close();
    _mi.delete();
  });
}
