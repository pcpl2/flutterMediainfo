cmake_minimum_required(VERSION 3.10)

set(PROJECT_NAME "native_utils")
project(${PROJECT_NAME} LANGUAGES CXX)

find_package(${PROJECT_NAME})
add_library(${PROJECT_NAME} SHARED ../nativeUtils/FileOpen.cpp)
target_link_libraries ( ${PROJECT_NAME} ${nativeUtils_LIBRARIES} )

install(TARGETS ${PROJECT_NAME} DESTINATION "${CMAKE_CURRENT_BINARY_DIR}/../libs")