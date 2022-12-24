set(libtmx_dir ${CMAKE_SOURCE_DIR}/Third/tmx-tmx_1.2.0)
add_custom_target(libtmx
        COMMAND ${cmake} -G "MinGW Makefiles" -S ${libtmx_dir} -B ${libtmx_dir}/build -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=${libtmx_dir}/out -DCMAKE_PREFIX_PATH=${libtmx_dir}/out
        COMMAND cd ${libtmx_dir}/build
        COMMAND ${cmake} --build . -j
        COMMAND ${cmake} --build . --target install
        # copy dll. TODO. dll
        COMMAND ${CMAKE_COMMAND} -E copy_directory ${libtmx_dir}/out/bin ${CMAKE_SOURCE_DIR}/bin
        # copy all out files to project_root_path
#        COMMAND ${CMAKE_COMMAND} -E copy_directory ${libtmx_dir}/out ${CMAKE_SOURCE_DIR}
        )
add_dependencies(libtmx install_libtmx_deps)

set(zlib_dir ${CMAKE_SOURCE_DIR}/Third/zlib-1.2.13)
add_custom_target(zlib
        COMMAND ${cmake} -G "MinGW Makefiles" -S ${zlib_dir} -B ${zlib_dir}/build -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=Off -DCMAKE_INSTALL_PREFIX=${zlib_dir}/out
        COMMAND cd ${zlib_dir}/build
        COMMAND ${cmake} --build . -j
        COMMAND ${cmake} --build . --target install
        )

set(libxml2_dir ${CMAKE_SOURCE_DIR}/Third/libxml2-master)
add_custom_target(libxml2
        COMMAND cd ${libxml2_dir}/win32
    #        no run_debug and docb
        COMMAND cscript configure.js prefix=${libxml2_dir}/out compiler=mingw c14n=no catalog=no debug=no ftp=no http=no html=yes xpath=no xptr=no xinclude=no iconv=no icu=no iso8859x=no zlib=no lzma=no xml_debug=no mem_debug=no schemas=no schematron=no regexps=no modules=no pattern=no valid=no sax1=no legacy=no python=no walker=no push=yes tree=yes output=yes writer=yes reader=yes
        COMMAND ${make} -f Makefile.mingw -j
        COMMAND ${CMAKE_COMMAND} -E make_directory ${libxml2_dir}/win32/out/include/libxml2/libxml ${libxml2_dir}/win32/out/lib
        COMMAND ${CMAKE_COMMAND} -E copy_if_different ${libxml2_dir}/win32/bin.mingw/libxml2.a ${libxml2_dir}/win32/out/lib
        COMMAND ${CMAKE_COMMAND} -E copy_directory  ${libxml2_dir}/include/libxml ${libxml2_dir}/win32/out/include/libxml2/libxml
        )

add_custom_target(install_libtmx_deps
        COMMAND ${CMAKE_COMMAND} -E make_directory ${libtmx_dir}/out
        COMMAND ${CMAKE_COMMAND} -E copy_directory ${libxml2_dir}/win32/out ${libtmx_dir}/out
        COMMAND ${CMAKE_COMMAND} -E copy_directory ${zlib_dir}/out ${libtmx_dir}/out
        )
add_dependencies(install_libtmx_deps zlib libxml2)

add_library(tmx INTERFACE)
set_target_properties(tmx PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES ${libtmx_dir}/out/include
#        INTERFACE_LINK_LIBRARIES 
#        INTERFACE_LINK_DIRECTORIES "${_sdl2_libdirs}"
        IMPORTED_IMPLIB "${libtmx_dir}/out/lib/libzlib.dll.a" "${libtmx_dir}/out/lib/libxml2.a" "${libtmx_dir}/out/lib/libtmx.a"
        IMPORTED_LOCATION "${libtmx_dir}/out/bin/libzlib.dll" # TODO. dll
        )
add_dependencies(tmx libtmx)

add_library(tmx-static INTERFACE)
set_target_properties(tmx PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES ${libtmx_dir}/out/include
        #        INTERFACE_LINK_LIBRARIES
        #        INTERFACE_LINK_DIRECTORIES "${_sdl2_libdirs}"
        IMPORTED_IMPLIB "${libtmx_dir}/out/lib/libzlibstatic.a" "${libtmx_dir}/out/lib/libxml2.a" "${libtmx_dir}/out/lib/libtmx.a"
        )
add_dependencies(tmx-static libtmx)