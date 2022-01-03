# FlutterMediaInfo
[![pub package](https://img.shields.io/pub/v/flutter_media_info.svg?label=flutter_media_info&color=blue)](https://pub.dev/packages/flutter_media_info) <img alt="GitHub" src="https://img.shields.io/github/license/pcpl2/flutterMediainfo"> [![Tests](https://github.com/pcpl2/flutterMediainfo/actions/workflows/CI_Tests.yml/badge.svg)](https://github.com/pcpl2/flutterMediainfo/actions/workflows/CI_Tests.yml) ![GitHub issues](https://img.shields.io/github/issues/pcpl2/flutterMediainfo)

Library for use [LibMediaInfo](https://mediaarea.net/en/MediaInfo) in flutter with support for macos, windows, linux.

## Get started

### Add dependency

```yaml
dependencies:
  flutter_media_info: ^0.0.2
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

This product uses [MediaInfo](https://mediaarea.net/en/MediaInfo) library, Copyright (c) 2002-2021 [MediaArea.net SARL](mailto:info@mediaarea.net).