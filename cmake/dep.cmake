macro(add_lib lib name url)
	set(LIB.${lib}.name ${name})
	set(LIB.${lib}.url ${url})
endmacro()

macro (download_lib lib)
	if (NOT EXISTS "${CMAKE_SOURCE_DIR}/dep/${LIB.${lib}.name}")
		execute_process(COMMAND wget ${LIB.${lib}.url}
				WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/dep)
	endif ()
endmacro ()

macro(unzip lib)
	string(REGEX REPLACE ".zip" "" lib_name "${LIB.${lib}.name}")
	if(NOT EXISTS "${CMAKE_SOURCE_DIR}/Third/${lib_name}")
		if (NOT EXISTS "${CMAKE_SOURCE_DIR}/dep/${LIB.${lib}.name}")
			message(STATUS "dep/${LIB.${lib}.name} is not exists, we'll download it first")
			download_lib(${lib})
		endif ()

		execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_SOURCE_DIR}/Third)
		execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_SOURCE_DIR}/Third/${lib_name})
		execute_process(COMMAND ${CMAKE_COMMAND} -E tar xzf ${CMAKE_SOURCE_DIR}/dep/${LIB.${lib}.name}
				WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/Third/${lib_name})
	endif()
	set(${lib}_dir ${CMAKE_SOURCE_DIR}/Third/${lib_name})
endmacro()

if (CMAKE_SYSTEM_NAME MATCHES "Windows")
	add_lib(SDL2 		SDL2-devel-2.26.1-mingw.zip			https://github.com/libsdl-org/SDL/releases/download/release-2.26.1/SDL2-devel-2.26.1-mingw.zip)
	add_lib(SDL2_ttf 	SDL2_ttf-devel-2.20.1-mingw.zip		https://github.com/libsdl-org/SDL_ttf/releases/download/release-2.20.1/SDL2_ttf-devel-2.20.1-mingw.zip)
	add_lib(SDL2_image	SDL2_image-devel-2.6.2-mingw.zip	https://github.com/libsdl-org/SDL_image/releases/download/release-2.6.2/SDL2_image-devel-2.6.2-mingw.zip)
	add_lib(SDL2_mixer 	SDL2_mixer-devel-2.6.2-mingw.zip	https://github.com/libsdl-org/SDL_mixer/releases/download/release-2.6.2/SDL2_mixer-devel-2.6.2-mingw.zip)
	add_lib(tmx 		tmx_1.2.0-win.zip					https://github.com/baylej/tmx/releases/download/tmx_1.2.0/tmx_1.2.0-win.zip)
	unzip(SDL2)
	unzip(SDL2_ttf)
	unzip(SDL2_image)
	unzip(SDL2_mixer)
	unzip(tmx)
elseif (CMAKE_SYSTEM_NAME MATCHES "Linux")
	add_lib(tmx tmx_1.2.0-linux.zip https://github.com/baylej/tmx/releases/download/tmx_1.2.0/tmx_1.2.0-linux.zip)
	unzip(tmx)
endif ()