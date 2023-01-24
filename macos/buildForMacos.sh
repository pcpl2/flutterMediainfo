#!/usr/bin/env bash

rm -rf nu_cmake
mkdir nu_cmake
cd nu_cmake
cmake ../../nativeUtils
make
