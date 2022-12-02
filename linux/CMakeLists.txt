cmake_minimum_required(VERSION 3.10)
set(PROJECT_NAME "flutter_media_info")
project(${PROJECT_NAME} LANGUAGES CXX)

# This value is used when generating builds using this plugin, so it must
# not be changed
set(PLUGIN_NAME "flutter_media_info_plugin")

add_library(${PLUGIN_NAME} SHARED
  "flutter_media_info_plugin.cc",
  "src/FileOpen.cpp"
)
apply_standard_settings(${PLUGIN_NAME})
set_target_properties(${PLUGIN_NAME} PROPERTIES
  CXX_VISIBILITY_PRESET hidden)
target_compile_definitions(${PLUGIN_NAME} PRIVATE FLUTTER_PLUGIN_IMPL)
target_include_directories(${PLUGIN_NAME} INTERFACE
  "${CMAKE_CURRENT_SOURCE_DIR}/include")
target_link_libraries(${PLUGIN_NAME} PRIVATE flutter)
target_link_libraries(${PLUGIN_NAME} PRIVATE PkgConfig::GTK)

# List of absolute paths to libraries that should be bundled with the plugin
set(flutter_media_info_bundled_libraries
  ""
  PARENT_SCOPE
)

set(BUILD_BUNDLE_DIR "${PROJECT_BINARY_DIR}/../../bundle")
if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
    set(CMAKE_INSTALL_PREFIX "${BUILD_BUNDLE_DIR}" CACHE PATH "..." FORCE)
endif()
set(INSTALL_BUNDLE_LIB_DIR "${CMAKE_INSTALL_PREFIX}")
set(MediaInfo_BRIDGE "libmediainfo.so")
set(LibZen_BRIDGE "libzen.so.0")
set(LibMMS_BRIDGE "libmms.so.0")
set(MediaInfo_BRIDGE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/libs/${MediaInfo_BRIDGE}")
set(LibZen_BRIDGE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/libs/${LibZen_BRIDGE}")
set(LibMMS_BRIDGE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/libs/${LibMMS_BRIDGE}")
install(CODE "file(REMOVE_RECURSE \"${INSTALL_BUNDLE_LIB_DIR}/${MediaInfo_BRIDGE}\")" COMPONENT Runtime)
install(CODE "file(REMOVE_RECURSE \"${INSTALL_BUNDLE_LIB_DIR}/${LibZen_BRIDGE}\")" COMPONENT Runtime)
install(CODE "file(REMOVE_RECURSE \"${INSTALL_BUNDLE_LIB_DIR}/${LibMMS_BRIDGE}\")" COMPONENT Runtime)
install(FILES "${MediaInfo_BRIDGE_PATH}" DESTINATION "${INSTALL_BUNDLE_LIB_DIR}" COMPONENT Runtime)
install(FILES "${LibZen_BRIDGE_PATH}" DESTINATION "${INSTALL_BUNDLE_LIB_DIR}" COMPONENT Runtime)
install(FILES "${LibMMS_BRIDGE_PATH}" DESTINATION "${INSTALL_BUNDLE_LIB_DIR}" COMPONENT Runtime)
