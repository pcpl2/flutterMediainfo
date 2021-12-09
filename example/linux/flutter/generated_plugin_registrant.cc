//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <mediainfo/mediainfo_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) mediainfo_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "MediainfoPlugin");
  mediainfo_plugin_register_with_registrar(mediainfo_registrar);
}
