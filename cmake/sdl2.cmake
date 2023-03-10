include(cmake/dep.cmake)

add_library(_SDL2_static INTERFACE)
add_library(_SDL2 INTERFACE)

MACRO(sub_dir_list result curdir)
	FILE(GLOB children RELATIVE ${curdir} ${curdir}/*)
	SET(dirlist "")
	FOREACH(child ${children})
		IF(IS_DIRECTORY ${curdir}/${child})
			LIST(APPEND dirlist ${child})
		ENDIF()
	ENDFOREACH()
	SET(${result} ${dirlist})
ENDMACRO()

set(target_suffix)

if (CMAKE_SYSTEM_NAME MATCHES "Linux")
	set (target_suffix "_linux")
	find_package(SDL2 REQUIRED)
	target_link_libraries(_SDL2_static INTERFACE SDL2::SDL2)
	target_link_libraries(_SDL2 INTERFACE SDL2::SDL2)

	macro (sdl_lib_load lib)
		set(sdl_lib_linux_path /usr/lib/x86_64-linux-gnu)
		if (NOT TARGET ${lib}::${lib})
			add_library(${lib}::${lib} SHARED IMPORTED)
			set_target_properties(${lib}::${lib} PROPERTIES
					IMPORTED_LOCATION ${sdl_lib_linux_path}/lib${lib}.so)
		endif ()
		if (NOT TARGET ${lib}::${lib}-static)
			add_library(${lib}::${lib}-static STATIC IMPORTED)
			set_target_properties(${lib}::${lib}-static PROPERTIES
					IMPORTED_LOCATION ${sdl_lib_linux_path}/lib${lib}.a)
		endif ()
		target_link_libraries(_SDL2_static INTERFACE ${lib}::${lib}-static)
		target_link_libraries(_SDL2 INTERFACE ${lib}::${lib})
	endmacro ()
elseif (CMAKE_SYSTEM_NAME MATCHES "Windows")
	target_link_libraries(_SDL2_static INTERFACE SDL2::SDL2main -static-libgcc -static-libstdc++ -Wl,-Bstatic -lstdc++ -lpthread -Wl,-Bdynamic)
	target_link_libraries(_SDL2 INTERFACE SDL2::SDL2main)
	macro (sdl_lib_load lib)
		if (${lib}_dir)
			sub_dir_list(sub_dirs ${${lib}_dir})
			foreach(dir ${sub_dirs})
				string(REGEX MATCHALL "${lib}-" ret "${dir}")
				if (ret)
					set(_lib_dir_sym ${dir})
				endif()
			endforeach()

			if (_lib_dir_sym)
				set(${lib}_DIR ${${lib}_dir}/${_lib_dir_sym}/x86_64-w64-mingw32)
				message(STATUS ${${lib}_DIR})
				find_package(${lib} REQUIRED HINTS ${${lib}_DIR})
				get_target_property(${lib}_dll ${lib}::${lib} IMPORTED_LOCATION)

				target_link_libraries(_SDL2_static INTERFACE ${lib}::${lib}-static)
				target_link_libraries(_SDL2 INTERFACE ${lib}::${lib})

				message(${lib}-hints:${${lib}_DIR})
				message(${lib}_dll:${${lib}_dll})
				unset(_lib_dir_sym)
			endif ()
		else()
			message(ERROR "could not find the ${lib} directories")
		endif()
		if (NOT lib_list)
			set(lib_list)
		endif()
		list(APPEND lib_list ${lib})
	endmacro ()
endif ()

sdl_lib_load(SDL2)
sdl_lib_load(SDL2_image)
sdl_lib_load(SDL2_ttf)
sdl_lib_load(SDL2_mixer)


#set(SDL2_DIR ${CMAKE_SOURCE_DIR}/Third/SDL2-devel-2.26.1-mingw/x86_64-w64-mingw32)
#set(sdl2_ROOT ${SDL2_DIR}/lib/cmake)
#find_package(sdl2 REQUIRED HINTS ${CMAKE_SOURCE_DIR}/Third/SDL2-devel-2.26.1-mingw/x86_64-w64-mingw32)
#get_target_property(SDL2_dll SDL2::SDL2 IMPORTED_LOCATION)
#
#set(SDL2_image_DIR ${CMAKE_SOURCE_DIR}/Third/SDL2_image-devel-2.6.2-mingw/x86_64-w64-mingw32)
#set(sdl2_image_ROOT ${SDL2_image_DIR}/lib/cmake)
#find_package(sdl2_image REQUIRED)
#get_target_property(SDL2_image_dll SDL2_image::SDL2_image IMPORTED_LOCATION)

# for debug

#get_target_property(sdl2_p1 SDL2::SDL2-static INTERFACE_INCLUDE_DIRECTORIES)
#get_target_property(sdl2_p2 SDL2::SDL2-static INTERFACE_LINK_LIBRARIES)
#get_target_property(sdl2_p3 SDL2::SDL2-static INTERFACE_LINK_DIRECTORIES)
#get_target_property(sdl2_p4 SDL2::SDL2-static IMPORTED_LINK_INTERFACE_LANGUAGES)
#get_target_property(sdl2_p5 SDL2::SDL2-static IMPORTED_IMPLIB)
#get_target_property(sdl2_p6 SDL2::SDL2-static IMPORTED_LOCATION)
#get_target_property(sdl2main_p1 SDL2::SDL2main IMPORTED_LOCATION)
#get_target_property(sdl2main_p2 SDL2::SDL2main INTERFACE_LINK_OPTIONS)

# message(sdl2_p1:${sdl2_p1})
#message(sdl2_p2:${sdl2_p2})
#message(sdl2_p3:${sdl2_p3})
#message(sdl2_p4:${sdl2_p4})
#message(sdl2_p5:${sdl2_p5})
#message(sdl2_p6:${sdl2_p6})
#message(sdl2main_p1:${sdl2main_p1})
#message(sdl2main_p2:${sdl2main_p2})
#message(SDL2_LIBRARIES:${SDL2_LIBRARIES})