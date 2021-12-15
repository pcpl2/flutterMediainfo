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

//TODO
/* 
size_t          __stdcall MediaInfoA_Open_Buffer_Init (void* Handle, MediaInfo_int64u File_Size, MediaInfo_int64u File_Offset)
{
    return MediaInfo_Open_Buffer_Init(Handle, File_Size, File_Offset);
}

size_t          __stdcall MediaInfoA_Open_Buffer_Continue (void* Handle, MediaInfo_int8u* Buffer, size_t Buffer_Size)
{
    return MediaInfo_Open_Buffer_Continue(Handle, Buffer, Buffer_Size);
}

MediaInfo_int64u __stdcall MediaInfoA_Open_Buffer_Continue_GoTo_Get (void* Handle)
{
    return MediaInfo_Open_Buffer_Continue_GoTo_Get(Handle);
}

size_t          __stdcall MediaInfoA_Open_Buffer_Finalize (void* Handle)
{
    return MediaInfo_Open_Buffer_Finalize(Handle);
}

size_t          __stdcall MediaInfoA_Open_NextPacket (void* Handle)
{
    return MediaInfo_Open_NextPacket(Handle);
}

size_t          __stdcall MediaInfoA_Save (void* Handle)
{
    return MediaInfo_Save(Handle);
}

void            __stdcall MediaInfoA_Close (void* Handle)
{
    MediaInfo_Close(Handle);
}

const char*     __stdcall MediaInfoA_Inform (void* Handle, size_t Reserved)
{
        return WC2MB(Handle, MediaInfo_Inform(Handle, 0));
}

const char*     __stdcall MediaInfoA_GetI (void* Handle, MediaInfo_stream_t StreamKind, size_t StreamNumber, size_t  Parameter, MediaInfo_info_C KindOfInfo)
{
    return WC2MB(Handle, MediaInfo_GetI(Handle, StreamKind, StreamNumber, Parameter, KindOfInfo));
}

const char*     __stdcall MediaInfoA_Get (void* Handle, MediaInfo_stream_t StreamKind, size_t StreamNumber, const char* Parameter, MediaInfo_info_C KindOfInfo, MediaInfo_info_C KindOfSearch)
{
    return WC2MB(Handle, MediaInfo_Get(Handle, StreamKind, StreamNumber, MB2WC(Handle, 0, Parameter), KindOfInfo, KindOfSearch));
}

size_t          __stdcall MediaInfoA_SetI (void* Handle, const char* ToSet, MediaInfo_stream_t StreamKind, size_t StreamNumber, size_t  Parameter, const char* OldParameter)
{
    return MediaInfo_SetI(Handle, MB2WC(Handle, 0, ToSet), StreamKind, StreamNumber, Parameter, MB2WC(Handle, 1, OldParameter));
}

size_t          __stdcall MediaInfoA_Set (void* Handle, const char* ToSet, MediaInfo_stream_t StreamKind, size_t StreamNumber, const char* Parameter, const char* OldParameter)
{
    return MediaInfo_Set(Handle, MB2WC(Handle, 0, ToSet), StreamKind, StreamNumber, MB2WC(Handle, 1, Parameter), MB2WC(Handle, 2, OldParameter));
}

size_t          __stdcall MediaInfoA_Output_Buffer_Get (void* Handle, const char* Value)
{
    return MediaInfo_Output_Buffer_Get(Handle, MB2WC(Handle, 0, Value));
}

size_t          __stdcall MediaInfoA_Output_Buffer_GetI (void* Handle, size_t Pos)
{
    return MediaInfo_Output_Buffer_GetI(Handle, Pos);
}

const char*     __stdcall MediaInfoA_Option (void* Handle, const char* Option, const char* Value)
{
    return WC2MB(Handle, MediaInfo_Option(Handle, MB2WC(Handle, 0, Option), MB2WC(Handle, 1, Value)));
}
*/
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
/*

size_t          __stdcall MediaInfoA_State_Get(void* Handle)
{
    return MediaInfo_State_Get(Handle);
}

size_t          __stdcall MediaInfoA_Count_Get(void* Handle, MediaInfo_stream_t StreamKind, size_t StreamNumber)
{
    return MediaInfo_Count_Get(Handle, StreamKind, StreamNumber);
}
*/

//TODO Dyamic load functions
void loadFromDylib(DynamicLibrary dylib) {}
