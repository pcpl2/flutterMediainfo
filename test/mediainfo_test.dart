import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mediainfo/mediainfo.dart';

void main() {
  const MethodChannel channel = MethodChannel('mediainfo');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await Mediainfo.platformVersion, '42');
  });

  test('initMediainfo', () async {
    Mediainfo.init();
  });
}
