import 'dart:ffi';

import 'package:ffi/ffi.dart';

//void*           __stdcall MediaInfoA_New ()
typedef MediaInfoANew = Pointer<Void> Function();
typedef MediaInfoInit = Pointer<Void> Function();

//void*           __stdcall MediaInfoA_New_Quick (const char* File, const char* Options)
typedef MediaInfoANewQuick = Pointer<Void> Function(
  Pointer<Utf8> file,
  Pointer<Utf8> options,
);
typedef MediaInfoNewQuick = Pointer<Void> Function(
  Pointer<Utf8> file,
  Pointer<Utf8> options,
);

//void            __stdcall MediaInfoA_Delete (void* Handle)
typedef MediaInfoADelete = Void Function(
  Pointer<Void> handle,
);
typedef MediaInfoDelete = void Function(
  Pointer<Void> handle,
);

//size_t          __stdcall MediaInfoA_Open (void* Handle, const char* File)
typedef MediaInfoAOpen = Uint32 Function(
  Pointer<Void> handle,
  Pointer<Utf8> file,
);
typedef MediaInfoOpen = int Function(
  Pointer<Void> handle,
  Pointer<Utf8> file,
);

//size_t          __stdcall MediaInfoA_Open_Buffer (void* Handle, const unsigned char* Begin, size_t  Begin_Size, const unsigned char* End, size_t  End_Size)
typedef MediaInfoAOpenBuffer = Uint32 Function(
  Pointer<Void> handle,
  Pointer<Utf8> begin,
  Uint32 beginSize,
  Pointer<Utf8> end,
  Uint32 endSize,
);
typedef MediaInfoOpenBuffer = int Function(
  Pointer<Void> handle,
  Pointer<Utf8> begin,
  int beginSize,
  Pointer<Utf8> end,
  int endSize,
);

//size_t          __stdcall MediaInfoA_Open_Buffer_Init (void* Handle, MediaInfo_int64u File_Size, MediaInfo_int64u File_Offset)
typedef MediaInfoAOpenBufferInit = Uint32 Function(
  Pointer<Void> handle,
  Uint64 fileSize,
  Uint64 fileOffset,
);
typedef MediaInfoOpenBufferInit = int Function(
  Pointer<Void> handle,
  int fileSize,
  int fileOffset,
);

//size_t          __stdcall MediaInfoA_Open_Buffer_Continue (void* Handle, MediaInfo_int8u* Buffer, size_t Buffer_Size)
typedef MediaInfoAOpenBufferContinue = Uint32 Function(
  Pointer<Void> handle,
  Pointer<Uint8> buffer,
  Uint32 bufferSize,
);
typedef MediaInfoOpenBufferContinue = int Function(
  Pointer<Void> handle,
  Pointer<Uint8> buffer,
  int bufferSize,
);

//MediaInfo_int64u __stdcall MediaInfoA_Open_Buffer_Continue_GoTo_Get (void* Handle)
typedef MediaInfoAOpenBufferContinueGoToGet = Uint64 Function(
  Pointer<Void> handle,
);
typedef MediaInfoOpenBufferContinueGoToGet = int Function(
  Pointer<Void> handle,
);

//size_t          __stdcall MediaInfoA_Open_Buffer_Finalize (void* Handle)
typedef MediaInfoAOpenBufferFinalize = Uint32 Function(
  Pointer<Void> handle,
);
typedef MediaInfoOpenBufferFinalize = int Function(
  Pointer<Void> handle,
);

//size_t          __stdcall MediaInfoA_Open_NextPacket (void* Handle)
typedef MediaInfoAOpenNextPacket = Uint32 Function(
  Pointer<Void> handle,
);
typedef MediaInfoOpenNextPacket = int Function(
  Pointer<Void> handle,
);

//size_t          __stdcall MediaInfoA_Save (void* Handle)
typedef MediaInfoASave = Uint32 Function(
  Pointer<Void> handle,
);
typedef MediaInfoSave = int Function(
  Pointer<Void> handle,
);

//void            __stdcall MediaInfoA_Close (void* Handle)
typedef MediaInfoAClose = Void Function(
  Pointer<Void> handle,
);
typedef MediaInfoClose = void Function(
  Pointer<Void> handle,
);

//const char*     __stdcall MediaInfoA_Inform (void* Handle, size_t Reserved)
typedef MediaInfoAInform = Pointer<Utf8> Function(
  Pointer<Void> handle,
  Uint32 reserved,
);
typedef MediaInfoInform = Pointer<Utf8> Function(
  Pointer<Void> handle,
  int reserved,
);

//const char*     __stdcall MediaInfoA_GetI (void* Handle, MediaInfo_stream_t StreamKind, size_t StreamNumber, size_t  Parameter, MediaInfo_info_C KindOfInfo)
typedef MediaInfoAGetI = Pointer<Utf8> Function(
  Pointer<Void> handle,
  Uint32 streamKind,
  Uint32 streamNumber,
  Uint32 parameter,
  Uint32 kindOfInfo,
);
typedef MediaInfoGetI = Pointer<Utf8> Function(
  Pointer<Void> handle,
  int streamKind,
  int streamNumber,
  int parameter,
  int kindOfInfo,
);

//const char*     __stdcall MediaInfoA_Get (void* Handle, MediaInfo_stream_t StreamKind, size_t StreamNumber, const char* Parameter, MediaInfo_info_C KindOfInfo, MediaInfo_info_C KindOfSearch)
typedef MediaInfoAGet = Pointer<Utf8> Function(
  Pointer<Void> handle,
  Uint32 streamKind,
  Uint32 streamNumber,
  Pointer<Utf8> parameter,
  Uint32 kindOfInfo,
  Uint32 kindOfSearch,
);
typedef MediaInfoGet = Pointer<Utf8> Function(
  Pointer<Void> handle,
  int streamKind,
  int streamNumber,
  Pointer<Utf8> parameter,
  int kindOfInfo,
  int kindOfSearch,
);

//size_t          __stdcall MediaInfoA_SetI (void* Handle, const char* ToSet, MediaInfo_stream_t StreamKind, size_t StreamNumber, size_t  Parameter, const char* OldParameter)
typedef MediaInfoASetI = Uint32 Function(
  Pointer<Void> handle,
  Pointer<Utf8> toSet,
  Uint32 streamKind,
  Uint32 streamNumber,
  Uint32 parameter,
  Pointer<Utf8> oldParameter,
);
typedef MediaInfoSetI = int Function(
  Pointer<Void> handle,
  Pointer<Utf8> toSet,
  int streamKind,
  int streamNumber,
  int parameter,
  Pointer<Utf8> oldParameter,
);

//size_t          __stdcall MediaInfoA_Set (void* Handle, const char* ToSet, MediaInfo_stream_t StreamKind, size_t StreamNumber, const char* Parameter, const char* OldParameter)
typedef MediaInfoASet = Uint32 Function(
  Pointer<Void> handle,
  Pointer<Utf8> toSet,
  Uint32 streamKind,
  Uint32 streamNumber,
  Pointer<Utf8> parameter,
  Pointer<Utf8> oldParameter,
);
typedef MediaInfoSet = int Function(
  Pointer<Void> handle,
  Pointer<Utf8> toSet,
  int streamKind,
  int streamNumber,
  Pointer<Utf8> parameter,
  Pointer<Utf8> oldParameter,
);

//size_t          __stdcall MediaInfoA_Output_Buffer_Get (void* Handle, const char* Value)
typedef MediaInfoAOutputBufferGet = Uint32 Function(
  Pointer<Void> handle,
  Pointer<Utf8> value,
);
typedef MediaInfoOutputBufferGet = int Function(
  Pointer<Void> handle,
  Pointer<Utf8> value,
);

//size_t          __stdcall MediaInfoA_Output_Buffer_GetI (void* Handle, size_t Pos)
typedef MediaInfoAOutputBufferGetI = Uint32 Function(
  Pointer<Void> handle,
  Uint32 int,
);
typedef MediaInfoOutputBufferGetI = int Function(
  Pointer<Void> handle,
  int int,
);

//const char*     __stdcall MediaInfoA_Option (void* Handle, const char* Option, const char* Value)
typedef MediaInfoAOption = Pointer<Utf8> Function(
  Pointer<Void> handle,
  Pointer<Utf8> option,
  Pointer<Utf8> value,
);
typedef MediaInfoOption = Pointer<Utf8> Function(
  Pointer<Void> handle,
  Pointer<Utf8> option,
  Pointer<Utf8> value,
);

//size_t          __stdcall MediaInfoA_State_Get(void* Handle)
typedef MediaInfoAStateGet = Uint32 Function(
  Pointer<Void> handle,
);
typedef MediaInfoStateGet = int Function(
  Pointer<Void> handle,
);

//size_t          __stdcall MediaInfoA_Count_Get(void* Handle, MediaInfo_stream_t StreamKind, size_t StreamNumber)
typedef MediaInfoACountGet = Uint32 Function(
  Pointer<Void> handle,
  Uint32 streamKind,
  Uint32 streamNumber,
);
typedef MediaInfoCountGet = int Function(
  Pointer<Void> handle,
  int streamKind,
  int streamNumber,
);
