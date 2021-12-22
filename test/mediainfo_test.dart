import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_media_info/mediainfo.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('initMediainfo', () async {
    Mediainfo.init();
  });
}
