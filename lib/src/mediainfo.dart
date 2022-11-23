// ignore_for_file: unused_field

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

  @Deprecated("Use Mediainfo()")
  Mediainfo.init({String? customDebugPath}) {
    try {
      if (Platform.isLinux || Platform.isAndroid) {
        DynamicLibrary.open(getLibZen(customDebugPath: customDebugPath));
      }

      final dylib =
          DynamicLibrary.open(platformDLPath(customDebugPath: customDebugPath));
      _loadSymbols(dylib);
    } on Exception catch (e) {
      developer.log(e.toString());
    }
  }

  Mediainfo({String? customDebugPath}) {
    try {
      if (Platform.isLinux || Platform.isAndroid) {
        DynamicLibrary.open(getLibZen(customDebugPath: customDebugPath));
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
      throw MediaInfoInstanceHasExists();
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

    final res = _miOpen(_mi!, path.toNativeUtf16());

    if (res > 0) {
      fileOpened = true;
      return true;
    } else {
      return false;
    }
  }

  void quickLoad(String path, {String options = ""}) {
    if (_mi != null) {
      throw MediaInfoInstanceHasExists();
    }

    _mi = _miNewQuick(path.toNativeUtf16(), options.toNativeUtf16());
    fileOpened = true;
  }

  String option(String option, {String value = ""}) {
    return _miOption(
            _mi ?? nullptr, option.toNativeUtf16(), value.toNativeUtf16())
        .toDartString();
  }

  /// Get all informations about a file in one string.
  /// This function require load file.
  ///
  /// Throws [NotLoadedMediaInfoInstance] if instance is not loaded
  /// Returns [String] all information about file
  String inform() {
    if (_mi == null) {
      throw NotLoadedMediaInfoInstance();
    }
    return _miInform(_mi!, 0).toDartString();
  }

  /// Get a piece of information about a file (parameter is a string)
  ///
  /// Throws [NotLoadedMediaInfoInstance] if instance is not loaded or [FileHasNotLoaded] if file is not loaded.
  /// Returns [String] with information about parameter
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
      parameter.toNativeUtf16(),
      kindOfInfo.index,
      kindOfSearch.index,
    ).toDartString();
  }

  // Remove mediainfo instance from memory
  void delete() {
    _miDelete(_mi ?? nullptr);
    _mi = null;
  }

  /// Close a file opened before with Open()
  void close() {
    _miClose(_mi ?? nullptr);
    fileOpened = false;
  }

  void _loadSymbols(DynamicLibrary dylib) {
    _miInit =
        dylib.lookupFunction<MediaInfoANew, MediaInfoInit>("MediaInfo_New");
    _miNewQuick = dylib.lookupFunction<MediaInfoANewQuick, MediaInfoNewQuick>(
        "MediaInfo_New_Quick");
    _miDelete = dylib
        .lookupFunction<MediaInfoADelete, MediaInfoDelete>("MediaInfo_Delete");
    _miOpen =
        dylib.lookupFunction<MediaInfoAOpen, MediaInfoOpen>("MediaInfo_Open");
    _miOpenBuffer =
        dylib.lookupFunction<MediaInfoAOpenBuffer, MediaInfoOpenBuffer>(
            "MediaInfo_Open_Buffer");
    _miOpenBufferInit =
        dylib.lookupFunction<MediaInfoAOpenBufferInit, MediaInfoOpenBufferInit>(
            "MediaInfo_Open_Buffer_Init");
    _miOpenBufferContinue = dylib.lookupFunction<MediaInfoAOpenBufferContinue,
        MediaInfoOpenBufferContinue>("MediaInfo_Open_Buffer_Continue");
    _miOpenBufferContinueGoToGet = dylib.lookupFunction<
            MediaInfoAOpenBufferContinueGoToGet,
            MediaInfoOpenBufferContinueGoToGet>(
        "MediaInfo_Open_Buffer_Continue_GoTo_Get");
    _miOpenBufferFinalize = dylib.lookupFunction<MediaInfoAOpenBufferFinalize,
        MediaInfoOpenBufferFinalize>("MediaInfo_Open_Buffer_Finalize");
    _miOpenNextPacket =
        dylib.lookupFunction<MediaInfoAOpenNextPacket, MediaInfoOpenNextPacket>(
            "MediaInfo_Open_NextPacket");
    _miSave =
        dylib.lookupFunction<MediaInfoASave, MediaInfoSave>("MediaInfo_Save");
    _miClose = dylib
        .lookupFunction<MediaInfoAClose, MediaInfoClose>("MediaInfo_Close");
    _miInform = dylib
        .lookupFunction<MediaInfoAInform, MediaInfoInform>("MediaInfo_Inform");
    _miGetI =
        dylib.lookupFunction<MediaInfoAGetI, MediaInfoGetI>("MediaInfo_GetI");
    _miGet = dylib.lookupFunction<MediaInfoAGet, MediaInfoGet>("MediaInfo_Get");
    _miSetI =
        dylib.lookupFunction<MediaInfoASetI, MediaInfoSetI>("MediaInfo_SetI");
    _miSet = dylib.lookupFunction<MediaInfoASet, MediaInfoSet>("MediaInfo_Set");
    _miOutputBufferGet = dylib.lookupFunction<MediaInfoAOutputBufferGet,
        MediaInfoOutputBufferGet>("MediaInfo_Output_Buffer_Get");
    _miOutputBufferGetI = dylib.lookupFunction<MediaInfoAOutputBufferGetI,
        MediaInfoOutputBufferGetI>("MediaInfo_Output_Buffer_GetI");
    _miOption = dylib
        .lookupFunction<MediaInfoAOption, MediaInfoOption>("MediaInfo_Option");
    _miStateGet = dylib.lookupFunction<MediaInfoAStateGet, MediaInfoStateGet>(
        "MediaInfo_State_Get");
    _miCountGet = dylib.lookupFunction<MediaInfoACountGet, MediaInfoCountGet>(
        "MediaInfo_Count_Get");

    developer.log("${option("Info_Version")} Loaded");
  }
}
