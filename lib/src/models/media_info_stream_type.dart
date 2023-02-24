/// Media info Stream types
enum MediaInfoStreamType {
  // General data | StreamKind = General.
  mediaInfoStreamGeneral,
  // Video data | StreamKind = Video.
  mediaInfoStreamVideo,
  // Audio data | StreamKind = Audio.
  mediaInfoStreamAudio,
  // Subtitles / Text data | StreamKind = Text.
  mediaInfoStreamText,
  // Other data | StreamKind = Chapters.
  mediaInfoStreamOther,
  // Image data | StreamKind = Image.
  mediaInfoStreamImage,
  // Menu data | StreamKind = Menu.
  mediaInfoStreamMenu,
  // Count of elements in c++ //TODO Remove it
  mediaInfoStreamMax,
}
