#include "include/flutter_media_info/flutter_media_info_plugin.h"

#include <flutter_linux/flutter_linux.h>
#include <gtk/gtk.h>

#include <cstring>

#define FLUTTER_MEDIA_INFO_PLUGIN(obj) \
  (G_TYPE_CHECK_INSTANCE_CAST((obj), flutter_media_info_plugin_get_type(), \
                              FlutterMediaInfoPlugin))

struct _FlutterMediaInfoPlugin {
  GObject parent_instance;
};

G_DEFINE_TYPE(FlutterMediaInfoPlugin, flutter_media_info_plugin, g_object_get_type())

static void flutter_media_info_plugin_dispose(GObject* object) {
  G_OBJECT_CLASS(flutter_media_info_plugin_parent_class)->dispose(object);
}

static void flutter_media_info_plugin_class_init(FlutterMediaInfoPluginClass* klass) {
  G_OBJECT_CLASS(klass)->dispose = flutter_media_info_plugin_dispose;
}

static void flutter_media_info_plugin_init(FlutterMediaInfoPlugin* self) {}

void flutter_media_info_plugin_register_with_registrar(FlPluginRegistrar* registrar) {
}
