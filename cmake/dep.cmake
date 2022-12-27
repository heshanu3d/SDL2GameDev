include(ExternalProject)

ExternalProject_Add(libSDL2
        DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/dep_download
        URL https://github.com/libsdl-org/SDL/releases/download/release-2.26.1/SDL2-devel-2.26.1-mingw.zip
        )
ExternalProject_Add(libSDL2_ttf_download
        DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/dep
        URL https://github.com/libsdl-org/SDL_ttf/releases/download/release-2.20.1/SDL2_ttf-devel-2.20.1-mingw.zip
        )
ExternalProject_Add(libSDL2_image_download
        DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/dep
        URL https://github.com/libsdl-org/SDL_image/releases/download/release-2.6.2/SDL2_image-devel-2.6.2-mingw.zip
        )
ExternalProject_Add(libSDL2_mixer_download
        DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/dep
        URL https://github.com/libsdl-org/SDL_mixer/releases/download/release-2.6.2/SDL2_mixer-devel-2.6.2-mingw.zip
        )
ExternalProject_Add(libtmx_download
        DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/dep
        URL https://github.com/baylej/tmx/releases/download/tmx_1.2.0/tmx_1.2.0-win.zip
        )

macro(unzip target)
    string(REGEX REPLACE ".zip" "" target_name "${target}")
    add_custom_target(prepare_dir_${target_name}
            COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_SOURCE_DIR}/Third
            )
    add_custom_target(unzip_${target_name}
            COMMAND ${CMAKE_COMMAND} -E tar xzf ${CMAKE_SOURCE_DIR}/dep/${target}
            DEPENDS ${CMAKE_SOURCE_DIR}/dep/${target} prepare_dir_${target_name}
            WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/Third
            )
endmacro()

macro(unzip_withdirname target)
    string(REGEX REPLACE ".zip" "" target_name "${target}")
    add_custom_target(prepare_dir_${target_name}
            COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_SOURCE_DIR}/Third
            COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_SOURCE_DIR}/Third/${target_name})
    add_custom_target(unzip_${target_name}
            COMMAND ${CMAKE_COMMAND} -E tar xzf ${CMAKE_SOURCE_DIR}/dep/${target}
            DEPENDS ${CMAKE_SOURCE_DIR}/dep/${target} prepare_dir_${target_name}
            WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/Third/${target_name}
            )
endmacro()

set(zip_file_list SDL2-devel-2.26.1-mingw.zip
        SDL2_ttf-devel-2.20.1-mingw.zip
        SDL2_image-devel-2.6.2-mingw.zip
        SDL2_mixer-devel-2.6.2-mingw.zip
        tmx_1.2.0-win.zip)

unzip(SDL2-devel-2.26.1-mingw.zip)
unzip(SDL2_ttf-devel-2.20.1-mingw.zip)
unzip(SDL2_image-devel-2.6.2-mingw.zip)
unzip(SDL2_mixer-devel-2.6.2-mingw.zip)
unzip_withdirname(tmx_1.2.0-win.zip)

add_custom_target(unZipAll ALL)
foreach(zip_file ${zip_file_list})
    string(REGEX REPLACE ".zip" "" zip_file_name "${zip_file}")
    add_dependencies(unZipAll unzip_${zip_file_name})
endforeach()