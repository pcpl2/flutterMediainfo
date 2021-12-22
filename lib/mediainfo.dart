import 'dart:developer' as developer;

import "dart:ffi";

import "package:ffi/ffi.dart";
import 'package:flutter_media_info/models/media_info_exceptions.dart';
import 'package:flutter_media_info/models/media_info_info_type.dart';
import 'package:flutter_media_info/models/media_info_stream_type.dart';
import 'package:flutter_media_info/models/media_info_functions.dart';
import 'package:flutter_media_info/utils.dart';

class Mediainfo {
  Pointer<Void>? _mi;

  //Functions
  late MediaInfoInit _miInit;
  late MediaInfoNewQuick _miNewQuick;
  late MediaInfoDelete _miDelete;
  late MediaInfoOpen _miOpen;
  late MediaInfoOpenBuffer _miOpenBuffer;
  late MediaInfoOpenBufferInit _miOpenBufferInit;
  late MediaInfoOpenBufferContinue _miOpenBufferContinue;
  late MediaInfoOpenBufferContinueGoToGet _miOpenBufferContinueGoToGet;
  late MediaInfoOpenBufferFinalize _miOpenBufferFinalize;
  late MediaInfoOpenNextPacket _miOpenNextPacket;
  late MediaInfoSave _miSave;
  late MediaInfoClose _miClose;
  late MediaInfoInform _miInform;
  late MediaInfoGetI _miGetI;
  late MediaInfoGet _miGet;
  late MediaInfoSetI _miSetI;
  late MediaInfoSet _miSet;
  late MediaInfoOutputBufferGet _miOutputBufferGet;
  late MediaInfoOutputBufferGetI _miOutputBufferGetI;
  late MediaInfoOption _miOption;
  late MediaInfoStateGet _miStateGet;
  late MediaInfoCountGet _miCountGet;

  Mediainfo.init() {
    final dlPath = platformPath("");

    try {
      final dylib = DynamicLibrary.open(dlPath);
      _loadSymbols(dylib);
    } on Exception catch (e) {
      developer.log(e.toString());
    }
  }

  void init() {
    if (_mi != null) {
      throw MediaInfoInstanceHasExist();
    }

    _mi = _miInit();
  }

  void quickLoad(String path, {String options = ""}) {
    if (_mi != null) {
      throw MediaInfoInstanceHasExist();
    }

    _mi = _miNewQuick(path.toNativeUtf8(), options.toNativeUtf8());
  }

  String option(String option, {String value = ""}) {
    if (_mi == null) {
      throw NotLoadedMediaInfoInstance();
    }
    return _miOption(_mi!, option.toNativeUtf8(), value.toNativeUtf8())
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
    return _miGet(
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

    _miDelete(_mi!);
  }

  void _loadSymbols(DynamicLibrary dylib) {
    _miInit =
        dylib.lookupFunction<MediaInfoANew, MediaInfoInit>("MediaInfoA_New");
    _miNewQuick = dylib.lookupFunction<MediaInfoANewQuick, MediaInfoNewQuick>(
        "MediaInfoA_New_Quick");
    _miDelete = dylib
        .lookupFunction<MediaInfoADelete, MediaInfoDelete>("MediaInfoA_Delete");
    _miOpen =
        dylib.lookupFunction<MediaInfoAOpen, MediaInfoOpen>("MediaInfoA_Open");
    _miOpenBuffer =
        dylib.lookupFunction<MediaInfoAOpenBuffer, MediaInfoOpenBuffer>(
            "MediaInfoA_Open_Buffer");
    _miOpenBufferInit =
        dylib.lookupFunction<MediaInfoAOpenBufferInit, MediaInfoOpenBufferInit>(
            "MediaInfoA_Open_Buffer_Init");
    _miOpenBufferContinue = dylib.lookupFunction<MediaInfoAOpenBufferContinue,
        MediaInfoOpenBufferContinue>("MediaInfoA_Open_Buffer_Continue");
    _miOpenBufferContinueGoToGet = dylib.lookupFunction<
            MediaInfoAOpenBufferContinueGoToGet,
            MediaInfoOpenBufferContinueGoToGet>(
        "MediaInfoA_Open_Buffer_Continue_GoTo_Get");
    _miOpenBufferFinalize = dylib.lookupFunction<MediaInfoAOpenBufferFinalize,
        MediaInfoOpenBufferFinalize>("MediaInfoA_Open_Buffer_Finalize");
    _miOpenNextPacket =
        dylib.lookupFunction<MediaInfoAOpenNextPacket, MediaInfoOpenNextPacket>(
            "MediaInfoA_Open_NextPacket");
    _miSave =
        dylib.lookupFunction<MediaInfoASave, MediaInfoSave>("MediaInfoA_Save");
    _miClose = dylib
        .lookupFunction<MediaInfoAClose, MediaInfoClose>("MediaInfoA_Close");
    _miInform = dylib
        .lookupFunction<MediaInfoAInform, MediaInfoInform>("MediaInfoA_Inform");
    _miGetI =
        dylib.lookupFunction<MediaInfoAGetI, MediaInfoGetI>("MediaInfoA_GetI");
    _miGet =
        dylib.lookupFunction<MediaInfoAGet, MediaInfoGet>("MediaInfoA_Get");
    _miSetI =
        dylib.lookupFunction<MediaInfoASetI, MediaInfoSetI>("MediaInfoA_SetI");
    _miSet =
        dylib.lookupFunction<MediaInfoASet, MediaInfoSet>("MediaInfoA_Set");
    _miOutputBufferGet = dylib.lookupFunction<MediaInfoAOutputBufferGet,
        MediaInfoOutputBufferGet>("MediaInfoA_Output_Buffer_Get");
    _miOutputBufferGetI = dylib.lookupFunction<MediaInfoAOutputBufferGetI,
        MediaInfoOutputBufferGetI>("MediaInfoA_Output_Buffer_GetI");
    _miOption = dylib
        .lookupFunction<MediaInfoAOption, MediaInfoOption>("MediaInfoA_Option");
    _miStateGet = dylib.lookupFunction<MediaInfoAStateGet, MediaInfoStateGet>(
        "MediaInfoA_State_Get");
    _miCountGet = dylib.lookupFunction<MediaInfoACountGet, MediaInfoCountGet>(
        "MediaInfoA_Count_Get");
  }
}
