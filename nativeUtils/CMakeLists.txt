cmake_minimum_required(VERSION 3.10)

set(PROJECT_NAME "nativeUtils")
set(CMAKE_OSX_ARCHITECTURES "x86_64;arm64" CACHE STRING "" FORCE)
project(${PROJECT_NAME} LANGUAGES CXX)

find_package(${PROJECT_NAME})
add_library(${PROJECT_NAME} SHARED ../nativeUtils/FileOpen.cpp)
target_link_libraries ( ${PROJECT_NAME} ${nativeUtils_LIBRARIES} )

install(TARGETS ${PROJECT_NAME} DESTINATION "${CMAKE_CURRENT_SOURCE_DIR}/../nativeUtils/nu_libs")
