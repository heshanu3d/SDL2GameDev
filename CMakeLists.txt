cmake_minimum_required(VERSION 3.16)
project(test)

set(CMAKE_CXX_STANDARD 17)
include(cmake/sdl2.cmake)
include(cmake/tmx.cmake)
include(cmake/util.cmake)

add_subdirectory(study)
add_subdirectory(RecoverMemory)

build_all()
