import 'dart:developer' as developer;

import "dart:ffi";
import 'dart:io';

import "package:ffi/ffi.dart";
import 'models/media_info_exceptions.dart';
import 'models/media_info_info_type.dart';
import 'models/media_info_stream_type.dart';
import 'models/media_info_functions.dart';
import 'utils.dart';

class Mediainfo {
  Pointer<Void>? _mi;
  bool fileOpened = false;

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

  Mediainfo.init({String? customDebugPath}) {
    try {
      if (Platform.isLinux || Platform.isAndroid) {
        DynamicLibrary.open(getLibZen());
      }

      final dylib =
          DynamicLibrary.open(platformDLPath(customDebugPath: customDebugPath));
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
    fileOpened = false;
  }

  /// Open file in media info instance
  ///
  /// return status of open file
  bool open(String path) {
    if (_mi == null) {
      throw NotLoadedMediaInfoInstance();
    }

    final res = _miOpen(_mi!, path.toNativeUtf8());

    if (res > 0) {
      fileOpened = true;
      return true;
    } else {
      return false;
    }
  }

  void quickLoad(String path, {String options = ""}) {
    if (_mi != null) {
      throw MediaInfoInstanceHasExist();
    }

    _mi = _miNewQuick(path.toNativeUtf8(), options.toNativeUtf8());
  }

  String option(String option, {String value = ""}) {
    return _miOption(
            _mi ?? nullptr, option.toNativeUtf8(), value.toNativeUtf8())
        .toDartString();
  }

  /// Get all details about a file in one string
  String inform() {
    if (_mi == null) {
      throw NotLoadedMediaInfoInstance();
    }
    return _miInform(_mi!, 0).toDartString();
  }

  ///Get a piece of information about a file (parameter is a string)
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

    if (!fileOpened) {
      throw FileHasNotLoaded();
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

  void delete() {
    if (_mi == null) {
      throw NotLoadedMediaInfoInstance();
    }

    _miDelete(_mi!);
    _mi = null;
  }

  /// Close a file opened before with Open()
  void close() {
    if (_mi == null) {
      throw NotLoadedMediaInfoInstance();
    }

    if (!fileOpened) {
      throw FileHasNotLoaded();
    }

    _miClose(_mi!);
    fileOpened = false;
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

    developer.log("${option("Info_Version")} Loaded");
  }
}
