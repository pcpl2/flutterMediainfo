import 'dart:io' show Platform;

import 'package:flutter_media_info/src/models/cpu_architecture.dart';
import 'package:flutter_media_info/src/utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('get raw cpu arch', () async {
    final cpuRawArch = getRawCpuArch();
    expect(cpuRawArch, isNot(null));
    if (Platform.isWindows) {
      expect(cpuRawArch, "AMD64");
    } else {
      expect(cpuRawArch, "x86_64");
    }
  });

  test('get cpu arch enum', () async {
    final cpuArch = getCpuArch();
    expect(cpuArch, CpuArchitecture.x86_64);
  });
}
