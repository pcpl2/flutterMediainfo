# FlutterMediaInfo
[![pub package](https://img.shields.io/pub/v/flutter_media_info.svg?label=flutter_media_info&color=blue)](https://pub.dev/packages/flutter_media_info) ![GitHub](https://img.shields.io/github/license/pcpl2/flutterMediainfo) ![Platform](https://img.shields.io/badge/Platform-LINUX%20%7C%20WINDOWS%20%7C%20MACOS-blue) [![Tests](https://github.com/pcpl2/flutterMediainfo/actions/workflows/CI_Tests.yml/badge.svg)](https://github.com/pcpl2/flutterMediainfo/actions/workflows/CI_Tests.yml) ![GitHub issues](https://img.shields.io/github/issues/pcpl2/flutterMediainfo) [![CodeFactor](https://www.codefactor.io/repository/github/pcpl2/fluttermediainfo/badge)](https://www.codefactor.io/repository/github/pcpl2/fluttermediainfo) ![Pub Points](https://img.shields.io/pub/points/flutter_media_info) ![Pub Popularity](https://img.shields.io/pub/popularity/flutter_media_info) ![Pub Likes](https://img.shields.io/pub/likes/flutter_media_info)

Library for use [LibMediaInfo](https://mediaarea.net/en/MediaInfo) in flutter with support for macos, windows, linux.

## Get started

### Minimal system requirements
* Ubuntu 20.04 x64
* Windows 7 x64
* macOS 10.10 x64 (Running on Rosetta 2 is not working currently)


### Requirements
For use this package you must have installed `camke` in your development/build system on all platforms.

### Add dependency

```yaml
dependencies:
  flutter_media_info: ^0.0.3
```


### Example:

```dart
import 'package:flutter_media_info/flutter_media_info.dart';


void printVideoDuration() {
    final mi = Mediainfo.init();
    mi.quickLoad("/home/user/myVideo.mp4");

    final movieDuration = mi.getInfo(MediaInfoStreamType.mediaInfoStreamVideo, 0, "Duration/String2");

    mi.close();
    print('Duration: ${movieDuration}');
}

```

# License

This product uses [MediaInfo](https://mediaarea.net/en/MediaInfo) library, Copyright (c) 2002-2023 [MediaArea.net SARL](mailto:info@mediaarea.net).