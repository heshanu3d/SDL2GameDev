cmake_minimum_required(VERSION 3.21)
project(test)

set(CMAKE_CXX_STANDARD 17)
include(cmake/sdl2.cmake)
include(cmake/util.cmake)

link_libraries(SDL2::SDL2main SDL2::SDL2)

add_subdirectory(01_hello_SDL)

