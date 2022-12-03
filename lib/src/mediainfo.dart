// ignore_for_file: unused_field

import 'dart:developer' as developer;

import "dart:ffi";
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:flutter_media_info/src/extensions.dart';
import 'models/media_info_exceptions.dart';
import 'models/media_info_info_type.dart';
import 'models/media_info_stream_type.dart';
import 'models/media_info_functions.dart';
import 'utils.dart';

class Mediainfo {
  Pointer<Void>? _mi;
  bool fileOpened = false;

  late String _dllPath;
  late DynamicLibrary _dylib;

  //Functions
  late MediaInfoInitFT _miInit;
  late MediaInfoNewQuickFT _miNewQuick;
  late MediaInfoDeleteFT _miDelete;
  late MediaInfoOpenFT _miOpen;
  late MediaInfoOpenBufferFT _miOpenBuffer;
  late MediaInfoOpenBufferInitFT _miOpenBufferInit;
  late MediaInfoOpenBufferContinueFT _miOpenBufferContinue;
  late MediaInfoOpenBufferContinueGoToGetFT _miOpenBufferContinueGoToGet;
  late MediaInfoOpenBufferFinalizeFT _miOpenBufferFinalize;
  late MediaInfoOpenNextPacketFT _miOpenNextPacket;
  late MediaInfoSaveFT _miSave;
  late MediaInfoCloseFT _miClose;
  late MediaInfoInformFT _miInform;
  late MediaInfoGetIFT _miGetI;
  late MediaInfoGetFT _miGet;
  late MediaInfoSetIFT _miSetI;
  late MediaInfoSetFT _miSet;
  late MediaInfoOutputBufferGetFT _miOutputBufferGet;
  late MediaInfoOutputBufferGetIFT _miOutputBufferGetI;
  late MediaInfoOptionFT _miOption;
  late MediaInfoStateGetFT _miStateGet;
  late MediaInfoCountGetFT _miCountGet;

  late OpenFileForMediaInfo _openFileForMI;

  @Deprecated("Use Mediainfo()")
  Mediainfo.init({String? customDebugPath}) {
    try {
      if (Platform.isLinux || Platform.isAndroid) {
        DynamicLibrary.open(getLibZen(customDebugPath: customDebugPath));
      }

      _dllPath = platformDLPath(customDebugPath: customDebugPath);
      _dylib =
          DynamicLibrary.open(_dllPath);
      _loadSymbols(_dylib, customDebugPath: customDebugPath);
    } on Exception catch (e) {
      developer.log(e.toString());
    }
  }

  Mediainfo({String? customDebugPath}) {
    try {
      if (Platform.isLinux || Platform.isAndroid) {
        DynamicLibrary.open(getLibZen(customDebugPath: customDebugPath));
      }

      _dllPath = platformDLPath(customDebugPath: customDebugPath);
      _dylib =
          DynamicLibrary.open(_dllPath);
      _loadSymbols(_dylib, customDebugPath: customDebugPath);
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

    var res = 0;

    if (Platform.isMacOS || Platform.isLinux) {
      final success = _openFileForMI(_dllPath.toNativeUtf8(), _mi!, path.toNativeUtf8());
      if(success == 0) {
        res = 2; //TODO Add valid file size
      }
    } else {
      res = _miOpen(_mi!, path.toNativeWchar());
    }

    if (res > 0) {
      fileOpened = true;
      return true;
    } else {
      return false;
    }
  }

  /// Quick load file
  /// This function has load file
  ///
  /// Throws [MediaInfoInstanceHasExists] if instance is loaded
  void quickLoad(String path, {String options = ""}) {
    if (_mi != null) {
      throw MediaInfoInstanceHasExists();
    }

    if (Platform.isMacOS || Platform.isLinux) {
      _miOption(nullptr, "QuickInit".toNativeWchar(), options.toNativeWchar());
      _mi = _miInit();

      _openFileForMI(_dllPath.toNativeUtf8(), _mi!, path.toNativeUtf8());
    } else {
      _mi = _miNewQuick(path.toNativeWchar(), options.toNativeWchar());
    }

    fileOpened = true;
  }

  String option(String option, {String value = ""}) {
    return _miOption(
            _mi ?? nullptr, option.toNativeWchar(), value.toNativeWchar())
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
      parameter.toNativeWchar(),
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

  void _loadSymbols(DynamicLibrary dylib, {String? customDebugPath}) {
    if (Platform.isMacOS || Platform.isLinux) {
      final DynamicLibrary nativeAddLib = _dylib =
          DynamicLibrary.open(getNativeUtilsLib(customDebugPath: customDebugPath));
      _openFileForMI = nativeAddLib
          .lookup<
              NativeFunction<
                  Int32 Function(Pointer<Utf8>, Pointer<Void>,
                      Pointer<Utf8>)>>("openFileForMediaInfo")
          .asFunction();
    }
    _miInit =
        dylib.lookupFunction<MediaInfoNew, MediaInfoInitFT>("MediaInfo_New");
    _miNewQuick = dylib.lookupFunction<MediaInfoNewQuick, MediaInfoNewQuickFT>(
        "MediaInfo_New_Quick");
    _miDelete = dylib
        .lookupFunction<MediaInfoDelete, MediaInfoDeleteFT>("MediaInfo_Delete");
    _miOpen =
        dylib.lookupFunction<MediaInfoOpen, MediaInfoOpenFT>("MediaInfo_Open");
    _miOpenBuffer =
        dylib.lookupFunction<MediaInfoOpenBuffer, MediaInfoOpenBufferFT>(
            "MediaInfo_Open_Buffer");
    _miOpenBufferInit = dylib.lookupFunction<MediaInfoOpenBufferInit,
        MediaInfoOpenBufferInitFT>("MediaInfo_Open_Buffer_Init");
    _miOpenBufferContinue = dylib.lookupFunction<MediaInfoOpenBufferContinue,
        MediaInfoOpenBufferContinueFT>("MediaInfo_Open_Buffer_Continue");
    _miOpenBufferContinueGoToGet = dylib.lookupFunction<
            MediaInfoOpenBufferContinueGoToGet,
            MediaInfoOpenBufferContinueGoToGetFT>(
        "MediaInfo_Open_Buffer_Continue_GoTo_Get");
    _miOpenBufferFinalize = dylib.lookupFunction<MediaInfoOpenBufferFinalize,
        MediaInfoOpenBufferFinalizeFT>("MediaInfo_Open_Buffer_Finalize");
    _miOpenNextPacket = dylib.lookupFunction<MediaInfoOpenNextPacket,
        MediaInfoOpenNextPacketFT>("MediaInfo_Open_NextPacket");
    _miSave =
        dylib.lookupFunction<MediaInfoSave, MediaInfoSaveFT>("MediaInfo_Save");
    _miClose = dylib
        .lookupFunction<MediaInfoClose, MediaInfoCloseFT>("MediaInfo_Close");
    _miInform = dylib
        .lookupFunction<MediaInfoInform, MediaInfoInformFT>("MediaInfo_Inform");
    _miGetI =
        dylib.lookupFunction<MediaInfoGetI, MediaInfoGetIFT>("MediaInfo_GetI");
    _miGet =
        dylib.lookupFunction<MediaInfoGet, MediaInfoGetFT>("MediaInfo_Get");
    _miSetI =
        dylib.lookupFunction<MediaInfoSetI, MediaInfoSetIFT>("MediaInfo_SetI");
    _miSet =
        dylib.lookupFunction<MediaInfoSet, MediaInfoSetFT>("MediaInfo_Set");
    _miOutputBufferGet = dylib.lookupFunction<MediaInfoOutputBufferGet,
        MediaInfoOutputBufferGetFT>("MediaInfo_Output_Buffer_Get");
    _miOutputBufferGetI = dylib.lookupFunction<MediaInfoOutputBufferGetI,
        MediaInfoOutputBufferGetIFT>("MediaInfo_Output_Buffer_GetI");
    _miOption = dylib
        .lookupFunction<MediaInfoOption, MediaInfoOptionFT>("MediaInfo_Option");
    _miStateGet = dylib.lookupFunction<MediaInfoStateGet, MediaInfoStateGetFT>(
        "MediaInfo_State_Get");
    _miCountGet = dylib.lookupFunction<MediaInfoCountGet, MediaInfoCountGetFT>(
        "MediaInfo_Count_Get");

    developer.log("${option("Info_Version")} Loaded");
  }
}
