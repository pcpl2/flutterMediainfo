# FlutterMediaInfo
<img alt="GitHub" src="https://img.shields.io/github/license/pcpl2/flutterMediainfo">

Library for use [LibMediaInfo](https://mediaarea.net/en/MediaInfo) in flutter with support for macos, windows, linux.

## Get started
<!---
### Add dependency

```yaml
dependencies:
  flutter_media_info: ^0.0.1
```
--->

### Example:

```dart
import 'package:flutter_media_info/mediainfo.dart';
import 'package:flutter_media_info/models/media_info_stream_type.dart';

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