/// Kind of information.
enum MediaInfoInfoType {
  // InfoKind = Unique name of parameter.
  mediaInfoInfoName,
  // InfoKind = Value of parameter.
  mediaInfoInfoText,
  // InfoKind = Unique name of measure unit of parameter.
  mediaInfoInfoMeasure,
  // InfoKind = See infooptions_t.
  mediaInfoInfoOptions,
  // InfoKind = Translated name of parameter.
  mediaInfoInfoNameText,
  // InfoKind = Translated name of measure unit.
  mediaInfoInfoMeasureText,
  // InfoKind = More information about the parameter.
  mediaInfoInfoInfo,
  // InfoKind = How this parameter is supported, could be N (No), B (Beta), R (Read only), W (Read/Write)
  mediaInfoInfoHowTo,
  // InfoKind = Domain of this piece of information.
  mediaInfoDomain,
  // Count of elements in c++ //TODO Remove it
  mediaInfoInfoMax,
}
