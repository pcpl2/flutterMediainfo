#include <iostream>
#include <dlfcn.h>
#include <stdint.h>

extern "C" __attribute__((visibility("default"))) __attribute__((used))
int32_t
openFileForMediaInfo(void *miDylib, void *miInstance, char *path)
{
    typedef unsigned long long MediaInfo_int64u;
    typedef unsigned char MediaInfo_int8u;

    size_t (*MediaInfo_Open_Buffer_Init)(void *, MediaInfo_int64u, MediaInfo_int64u);
    MediaInfo_Open_Buffer_Init = (size_t(*)(void *, MediaInfo_int64u, MediaInfo_int64u))dlsym(miDylib, "MediaInfo_Open_Buffer_Init");

    size_t (*MediaInfo_Open_Buffer_Continue)(void *, MediaInfo_int8u *, size_t);
    MediaInfo_Open_Buffer_Continue = (size_t(*)(void *, MediaInfo_int8u *, size_t))dlsym(miDylib, "MediaInfo_Open_Buffer_Continue");

    MediaInfo_int64u (*MediaInfo_Open_Buffer_Continue_GoTo_Get)(void *);
    MediaInfo_Open_Buffer_Continue_GoTo_Get = (MediaInfo_int64u(*)(void *))dlsym(miDylib, "MediaInfo_Open_Buffer_Continue_GoTo_Get");

    size_t (*MediaInfo_Open_Buffer_Finalize)(void *);
    MediaInfo_Open_Buffer_Finalize = (size_t(*)(void *))dlsym(miDylib, "MediaInfo_Open_Buffer_Finalize");

    FILE *F = fopen(path, "rb");
    if (F == 0)
        return 1;

    unsigned char *From_Buffer = new unsigned char[7 * 188];
    size_t From_Buffer_Size;

    fseek(F, 0, SEEK_END);
    long F_Size = ftell(F);
    fseek(F, 0, SEEK_SET);

    // Preparing to fill MediaInfo with a buffer
    MediaInfo_Open_Buffer_Init(miInstance, F_Size, 0);

    // The parsing loop
    do
    {
        // Reading data somewhere, do what you want for this.
        From_Buffer_Size = fread(From_Buffer, 1, 7 * 188, F);

        // Sending the buffer to MediaInfo
        size_t Status = MediaInfo_Open_Buffer_Continue(miInstance, From_Buffer, From_Buffer_Size);
        if (Status & 0x08) // Bit3=Finished
            break;

        // Testing if there is a MediaInfo request to go elsewhere
        if (MediaInfo_Open_Buffer_Continue_GoTo_Get(miInstance) != (MediaInfo_int64u)-1)
        {
            fseek(F, (long)MediaInfo_Open_Buffer_Continue_GoTo_Get(miInstance), SEEK_SET); // Position the file
            MediaInfo_Open_Buffer_Init(miInstance, F_Size, ftell(F));                      // Informing MediaInfo we have seek
        }
    } while (From_Buffer_Size > 0);

    // Finalizing
    MediaInfo_Open_Buffer_Finalize(miInstance); // This is the end of the stream, MediaInfo must finnish some work
    return 0;
}
