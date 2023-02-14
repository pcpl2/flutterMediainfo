// ignore_for_file: public_member_api_docs
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';

extension StringWcharPointer on String {
  Pointer<WChar> toNativeWchar({Allocator allocator = malloc}) {
    if (Platform.isWindows) {
      final units = codeUnits;
      final Pointer<Uint16> result = allocator<Uint16>(units.length + 1);
      final Uint16List nativeString = result.asTypedList(units.length + 1);
      nativeString.setRange(0, units.length, units);
      nativeString[units.length] = 0;
      return result.cast();
    } else {
      final units = codeUnits;
      final Pointer<Uint32> result = allocator<Uint32>(units.length + 1);
      final Uint32List nativeString = result.asTypedList(units.length + 1);
      nativeString.setRange(0, units.length, units);
      nativeString[units.length] = 0;
      return result.cast();
    }
  }
}

extension WcharPointer on Pointer<WChar> {
  String toDartString() {
    _ensureNotNullptr('toDartString');

    if (Platform.isWindows) {
      final codeUnits = cast<Uint16>();
      return _toUnknownLengthString16(codeUnits);
    } else {
      final codeUnits = cast<Uint32>();
      return _toUnknownLengthString32(codeUnits);
    }
  }

  void _ensureNotNullptr(String operation) {
    if (this == nullptr) {
      throw UnsupportedError(
          "Operation '$operation' not allowed on a 'nullptr'.");
    }
  }

  static String _toUnknownLengthString16(Pointer<Uint16> codeUnits) {
    final buffer = StringBuffer();
    var i = 0;
    while (true) {
      final char = codeUnits.elementAt(i).value;
      if (char == 0) {
        return buffer.toString();
      }
      buffer.writeCharCode(char);
      i++;
    }
  }

  static String _toUnknownLengthString32(Pointer<Uint32> codeUnits) {
    final buffer = StringBuffer();
    var i = 0;
    while (true) {
      final char = codeUnits.elementAt(i).value;
      if (char == 0) {
        return buffer.toString();
      }
      buffer.writeCharCode(char);
      i++;
    }
  }
}
