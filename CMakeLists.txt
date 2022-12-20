cmake_minimum_required(VERSION 3.21)
project(test)

set(CMAKE_CXX_STANDARD 17)
include(cmake/sdl2.cmake)
include(cmake/util.cmake)

add_subdirectory(study)

build_all()
