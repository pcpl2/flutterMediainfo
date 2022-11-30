import 'dart:ffi';

import 'package:ffi/ffi.dart';

//void*           __stdcall MediaInfo_New ()
typedef MediaInfoNew = Pointer<Void> Function();
typedef MediaInfoInitFT = Pointer<Void> Function();

//void*           __stdcall MediaInfo_New_Quick (const char_t* File, const char_t* Options)
typedef MediaInfoNewQuick = Pointer<Void> Function(
  Pointer<WChar> file,
  Pointer<WChar> options,
);
typedef MediaInfoNewQuickFT = Pointer<Void> Function(
  Pointer<WChar> file,
  Pointer<WChar> options,
);

//void            __stdcall MediaInfo_Delete (void* Handle)
typedef MediaInfoDelete = Void Function(
  Pointer<Void> handle,
);
typedef MediaInfoDeleteFT = void Function(
  Pointer<Void> handle,
);

//size_t          __stdcall MediaInfo_Open (void* Handle, const wchar_t* File)
typedef MediaInfoOpen = Size Function(
  Pointer<Void> handle,
  Pointer<WChar> file,
);
typedef MediaInfoOpenFT = int Function(
  Pointer<Void> handle,
  Pointer<WChar> file,
);

//size_t          __stdcall MediaInfo_Open_Buffer (void* Handle, const unsigned wchar_t* Begin, size_t  Begin_Size, const unsigned wchar_t* End, size_t  End_Size)
typedef MediaInfoOpenBuffer = Uint32 Function(
  Pointer<Void> handle,
  Pointer<WChar> begin,
  Uint32 beginSize,
  Pointer<WChar> end,
  Uint32 endSize,
);
typedef MediaInfoOpenBufferFT = int Function(
  Pointer<Void> handle,
  Pointer<WChar> begin,
  int beginSize,
  Pointer<WChar> end,
  int endSize,
);

//size_t          __stdcall MediaInfo_Open_Buffer_Init (void* Handle, MediaInfo_int64u File_Size, MediaInfo_int64u File_Offset)
typedef MediaInfoOpenBufferInit = Uint32 Function(
  Pointer<Void> handle,
  Uint64 fileSize,
  Uint64 fileOffset,
);
typedef MediaInfoOpenBufferInitFT = int Function(
  Pointer<Void> handle,
  int fileSize,
  int fileOffset,
);

//size_t          __stdcall MediaInfo_Open_Buffer_Continue (void* Handle, MediaInfo_int8u* Buffer, size_t Buffer_Size)
typedef MediaInfoOpenBufferContinue = Uint32 Function(
  Pointer<Void> handle,
  Pointer<Uint8> buffer,
  Uint32 bufferSize,
);
typedef MediaInfoOpenBufferContinueFT = int Function(
  Pointer<Void> handle,
  Pointer<Uint8> buffer,
  int bufferSize,
);

//MediaInfo_int64u __stdcall MediaInfo_Open_Buffer_Continue_GoTo_Get (void* Handle)
typedef MediaInfoOpenBufferContinueGoToGet = Uint64 Function(
  Pointer<Void> handle,
);
typedef MediaInfoOpenBufferContinueGoToGetFT = int Function(
  Pointer<Void> handle,
);

//size_t          __stdcall MediaInfo_Open_Buffer_Finalize (void* Handle)
typedef MediaInfoOpenBufferFinalize = Uint32 Function(
  Pointer<Void> handle,
);
typedef MediaInfoOpenBufferFinalizeFT = int Function(
  Pointer<Void> handle,
);

//size_t          __stdcall MediaInfo_Open_NextPacket (void* Handle)
typedef MediaInfoOpenNextPacket = Uint32 Function(
  Pointer<Void> handle,
);
typedef MediaInfoOpenNextPacketFT = int Function(
  Pointer<Void> handle,
);

//size_t          __stdcall MediaInfo_Save (void* Handle)
typedef MediaInfoSave = Uint32 Function(
  Pointer<Void> handle,
);
typedef MediaInfoSaveFT = int Function(
  Pointer<Void> handle,
);

//void            __stdcall MediaInfo_Close (void* Handle)
typedef MediaInfoClose = Void Function(
  Pointer<Void> handle,
);
typedef MediaInfoCloseFT = void Function(
  Pointer<Void> handle,
);

//const wchar_t*     __stdcall MediaInfo_Inform (void* Handle, size_t Reserved)
typedef MediaInfoInform = Pointer<WChar> Function(
  Pointer<Void> handle,
  Uint32 reserved,
);
typedef MediaInfoInformFT = Pointer<WChar> Function(
  Pointer<Void> handle,
  int reserved,
);

//const wchar_t*     __stdcall MediaInfo_GetI (void* Handle, MediaInfo_stream_t StreamKind, size_t StreamNumber, size_t  Parameter, MediaInfo_info_C KindOfInfo)
typedef MediaInfoGetI = Pointer<WChar> Function(
  Pointer<Void> handle,
  Uint32 streamKind,
  Uint32 streamNumber,
  Uint32 parameter,
  Uint32 kindOfInfo,
);
typedef MediaInfoGetIFT = Pointer<WChar> Function(
  Pointer<Void> handle,
  int streamKind,
  int streamNumber,
  int parameter,
  int kindOfInfo,
);

//const wchar_t*     __stdcall MediaInfo_Get (void* Handle, MediaInfo_stream_t StreamKind, size_t StreamNumber, const wchar_t* Parameter, MediaInfo_info_C KindOfInfo, MediaInfo_info_C KindOfSearch)
typedef MediaInfoGet = Pointer<WChar> Function(
  Pointer<Void> handle,
  Uint32 streamKind,
  Uint32 streamNumber,
  Pointer<WChar> parameter,
  Uint32 kindOfInfo,
  Uint32 kindOfSearch,
);
typedef MediaInfoGetFT = Pointer<WChar> Function(
  Pointer<Void> handle,
  int streamKind,
  int streamNumber,
  Pointer<WChar> parameter,
  int kindOfInfo,
  int kindOfSearch,
);

//size_t          __stdcall MediaInfo_SetI (void* Handle, const wchar_t* ToSet, MediaInfo_stream_t StreamKind, size_t StreamNumber, size_t  Parameter, const wchar_t* OldParameter)
typedef MediaInfoSetI = Uint32 Function(
  Pointer<Void> handle,
  Pointer<WChar> toSet,
  Uint32 streamKind,
  Uint32 streamNumber,
  Uint32 parameter,
  Pointer<WChar> oldParameter,
);
typedef MediaInfoSetIFT = int Function(
  Pointer<Void> handle,
  Pointer<WChar> toSet,
  int streamKind,
  int streamNumber,
  int parameter,
  Pointer<WChar> oldParameter,
);

//size_t          __stdcall MediaInfo_Set (void* Handle, const wchar_t* ToSet, MediaInfo_stream_t StreamKind, size_t StreamNumber, const wchar_t* Parameter, const wchar_t* OldParameter)
typedef MediaInfoSet = Uint32 Function(
  Pointer<Void> handle,
  Pointer<WChar> toSet,
  Uint32 streamKind,
  Uint32 streamNumber,
  Pointer<WChar> parameter,
  Pointer<WChar> oldParameter,
);
typedef MediaInfoSetFT = int Function(
  Pointer<Void> handle,
  Pointer<WChar> toSet,
  int streamKind,
  int streamNumber,
  Pointer<WChar> parameter,
  Pointer<WChar> oldParameter,
);

//size_t          __stdcall MediaInfo_Output_Buffer_Get (void* Handle, const wchar_t* Value)
typedef MediaInfoOutputBufferGet = Uint32 Function(
  Pointer<Void> handle,
  Pointer<WChar> value,
);
typedef MediaInfoOutputBufferGetFT = int Function(
  Pointer<Void> handle,
  Pointer<WChar> value,
);

//size_t          __stdcall MediaInfo_Output_Buffer_GetI (void* Handle, size_t Pos)
typedef MediaInfoOutputBufferGetI = Uint32 Function(
  Pointer<Void> handle,
  Uint32 int,
);
typedef MediaInfoOutputBufferGetIFT = int Function(
  Pointer<Void> handle,
  int int,
);

//const wchar_t*     __stdcall MediaInfo_Option (void* Handle, const wchar_t* Option, const wchar_t* Value)
typedef MediaInfoOption = Pointer<WChar> Function(
  Pointer<Void> handle,
  Pointer<WChar> option,
  Pointer<WChar> value,
);
typedef MediaInfoOptionFT = Pointer<WChar> Function(
  Pointer<Void> handle,
  Pointer<WChar> option,
  Pointer<WChar> value,
);

//size_t          __stdcall MediaInfo_State_Get(void* Handle)
typedef MediaInfoStateGet = Uint32 Function(
  Pointer<Void> handle,
);
typedef MediaInfoStateGetFT = int Function(
  Pointer<Void> handle,
);

//size_t          __stdcall MediaInfo_Count_Get(void* Handle, MediaInfo_stream_t StreamKind, size_t StreamNumber)
typedef MediaInfoCountGet = Uint32 Function(
  Pointer<Void> handle,
  Uint32 streamKind,
  Uint32 streamNumber,
);
typedef MediaInfoCountGetFT = int Function(
  Pointer<Void> handle,
  int streamKind,
  int streamNumber,
);


typedef OpenFileForMediaInfo = int Function(
  Pointer<Void> myDlib,
  Pointer<Void> handle,
  Pointer<Utf8> path,
);