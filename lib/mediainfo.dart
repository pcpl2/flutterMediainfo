import 'dart:developer' as developer;

import "dart:ffi";

import "package:ffi/ffi.dart";
import 'package:flutter_media_info/models/media_info_exceptions.dart';
import 'package:flutter_media_info/models/media_info_info_type.dart';
import 'package:flutter_media_info/models/media_info_stream_type.dart';
import 'package:flutter_media_info/models/media_info_functions.dart';
import 'package:flutter_media_info/utils.dart';

// ignore: slash_for_doc_comments
/**
 *     //Get() example
    printString(__T("video:"));
    printString(MI.Get(Stream_Video, 0, __T("CodecID")));
    printString(MI.Get(Stream_Video, 0, __T("Duration/String2")));
    printString(MI.Get(Stream_Video, 0, __T("Width")));
    printString(MI.Get(Stream_Video, 0, __T("Height")));
    printString(MI.Get(Stream_Video, 0, __T("FrameRate")));
    printString(MI.Get(Stream_Video, 0, __T("FrameRate_Mode")));
    printString(MI.Get(Stream_Video, 0, __T("BitRate/String")));
    printString(__T("audio:"));
    printString(MI.Get(Stream_Audio, 0, __T("CodecID")));
    printString(MI.Get(Stream_Audio, 0, __T("BitRate/String")));
    printString(MI.Get(Stream_Audio, 0, __T("SamplingRate/String")));
 */
class Mediainfo {
  Pointer<Void>? _mi;

  //Functions
  late MediaInfoInit _mediaInfoInit;
  late MediaInfoNewQuick _mediaInfoNewQuick;
  late MediaInfoDelete _mediaInfoDelete;
  late MediaInfoOpen _mediaInfoOpen;
  late MediaInfoOption _mediaInfoOption;

  ///...
  late MediaInfoGet _mediaInfoGet;


  Mediainfo.init() {
    final dlPath = platformPath("");

    try {
      final dylib = DynamicLibrary.open(dlPath);
      _mediaInfoInit =
          dylib.lookupFunction<MediaInfoANew, MediaInfoInit>("MediaInfoA_New");
      _mediaInfoNewQuick =
          dylib.lookupFunction<MediaInfoNewQuick, MediaInfoNewQuick>(
              "MediaInfoA_New_Quick");
      _mediaInfoDelete =
          dylib.lookupFunction<MediaInfoADelete, MediaInfoDelete>(
              "MediaInfoA_Delete");
      _mediaInfoOpen = dylib
          .lookupFunction<MediaInfoAOpen, MediaInfoOpen>("MediaInfoA_Open");

      _mediaInfoGet =
          dylib.lookupFunction<MediaInfoAGet, MediaInfoGet>("MediaInfoA_Get");

      _mediaInfoOption =
          dylib.lookupFunction<MediaInfoAOption, MediaInfoOption>(
              "MediaInfoA_Option");
    } on Exception catch (e) {
      developer.log(e.toString());
    }
  }

  void quickLoad(String path, {String options = ""}) {
    if (_mi != null) {
      throw MediaInfoInstanceHasExist();
    }

    _mi = _mediaInfoNewQuick(path.toNativeUtf8(), options.toNativeUtf8());
  }

  String option(String option, {String value = ""}) {
    if (_mi == null) {
      throw NotLoadedMediaInfoInstance();
    }
    return _mediaInfoOption(_mi!, option.toNativeUtf8(), value.toNativeUtf8())
        .toDartString();
  }

  String getInfo(
    MediaInfoStreamType streamType,
    int streamNumber,
    String parameter, {
    MediaInfoInfoType kindOfInfo = MediaInfoInfoType.mediaInfoInfoText,
    MediaInfoInfoType kindOfSearch = MediaInfoInfoType.mediaInfoInfoName,
  }) {
    if (_mi == null) {
      throw NotLoadedMediaInfoInstance();
    }
    return _mediaInfoGet(
      _mi!,
      streamType.index,
      streamNumber,
      parameter.toNativeUtf8(),
      kindOfInfo.index,
      kindOfSearch.index,
    ).toDartString();
  }

  void close() {
    if (_mi == null) {
      throw NotLoadedMediaInfoInstance();
    }

    _mediaInfoDelete(_mi!);
  }
}
