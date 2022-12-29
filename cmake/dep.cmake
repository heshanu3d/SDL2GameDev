if (CMAKE_SYSTEM_NAME MATCHES "Windows")
#	include(ExternalProject)

#	ExternalProject_Add(libSDL2
#			DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/dep_download
#			URL https://github.com/libsdl-org/SDL/releases/download/release-2.26.1/SDL2-devel-2.26.1-mingw.zip
#			)
#	ExternalProject_Add(libSDL2_ttf_download
#			DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/dep
#			URL https://github.com/libsdl-org/SDL_ttf/releases/download/release-2.20.1/SDL2_ttf-devel-2.20.1-mingw.zip
#			)
#	ExternalProject_Add(libSDL2_image_download
#			DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/dep
#			URL https://github.com/libsdl-org/SDL_image/releases/download/release-2.6.2/SDL2_image-devel-2.6.2-mingw.zip
#			)
#	ExternalProject_Add(libSDL2_mixer_download
#			DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/dep
#			URL https://github.com/libsdl-org/SDL_mixer/releases/download/release-2.6.2/SDL2_mixer-devel-2.6.2-mingw.zip
#			)
#	ExternalProject_Add(libtmx_download
#			DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/dep
#			URL https://github.com/baylej/tmx/releases/download/tmx_1.2.0/tmx_1.2.0-win.zip
#			)

	macro(unzip lib target)
		string(REGEX REPLACE ".zip" "" target_name "${target}")
		if(NOT EXISTS "${CMAKE_SOURCE_DIR}/Third/${target_name}")
			execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_SOURCE_DIR}/Third)
			execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_SOURCE_DIR}/Third/${target_name})
			execute_process(COMMAND ${CMAKE_COMMAND} -E tar xzf ${CMAKE_SOURCE_DIR}/dep/${target}
					WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/Third/${target_name})
		endif()
		set(${lib}_dir ${CMAKE_SOURCE_DIR}/Third/${target_name})
	endmacro()

	unzip(SDL2 			SDL2-devel-2.26.1-mingw.zip)
	unzip(SDL2_ttf 		SDL2_ttf-devel-2.20.1-mingw.zip)
	unzip(SDL2_image	SDL2_image-devel-2.6.2-mingw.zip)
	unzip(SDL2_mixer 	SDL2_mixer-devel-2.6.2-mingw.zip)
	unzip(tmx 			tmx_1.2.0-win.zip)

	set(tmx_dir ${CMAKE_SOURCE_DIR}/Third/tmx_1.2.0-win)
endif()