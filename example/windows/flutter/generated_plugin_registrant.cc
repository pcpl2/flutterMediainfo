//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <file_selector_windows/file_selector_plugin.h>
#include <mediainfo/mediainfo_plugin.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  FileSelectorPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FileSelectorPlugin"));
  MediainfoPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("MediainfoPlugin"));
}
