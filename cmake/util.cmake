set(out_dir ${CMAKE_SOURCE_DIR}/bin)
macro(add_exe _target)
    file(GLOB _${_target}_src_files "${CMAKE_CURRENT_LIST_DIR}/*.cpp" "${CMAKE_CURRENT_LIST_DIR}/*.c")
    message(_${_target}_src_files : ${_${_target}_src_files})
    add_executable(${_target} ${_${_target}_src_files})
    target_link_libraries(${_target} PRIVATE SDL2::SDL2main SDL2::SDL2 SDL2_image::SDL2_image)
    set_target_properties(${_target} PROPERTIES
            RUNTIME_OUTPUT_DIRECTORY ${out_dir}
            LIBRARY_OUTPUT_DIRECTORY ${out_dir}
            )
#    if (EXISTS "${sdl2_dll}" AND EXISTS "${sdl2_image_dll}")
#        message("both ${sdl2_dll} and ${sdl2_image_dll} exists")
#    else()
        add_custom_command(TARGET ${_target}
                POST_BUILD
                COMMAND ${CMAKE_COMMAND} -E copy ${sdl2_dll} ${out_dir}
                COMMAND ${CMAKE_COMMAND} -E copy ${sdl2_image_dll} ${out_dir}
                )
        message("either ${sdl2_dll} or ${sdl2_image_dll} not exists, move them")
#    endif()
endmacro()
macro(add_study_exe _target)
    set(study_dir ${CMAKE_SOURCE_DIR}/study)
    file(GLOB _${_target}_src_files "${CMAKE_CURRENT_LIST_DIR}/*.cpp" "${CMAKE_CURRENT_LIST_DIR}/*.c")
    message(_${_target}_src_files : ${_${_target}_src_files})
    add_executable(${_target} ${_${_target}_src_files})
    target_link_libraries(${_target} PRIVATE SDL2::SDL2main SDL2::SDL2 SDL2_image::SDL2_image)
    set_target_properties(${_target} PROPERTIES
            RUNTIME_OUTPUT_DIRECTORY ${study_dir}
            LIBRARY_OUTPUT_DIRECTORY ${study_dir}
            )
#    if (EXISTS "${sdl2_dll}" AND EXISTS "${sdl2_image_dll}")
#        message("both ${sdl2_dll} and ${sdl2_image_dll} exists")
#    else()
        add_custom_command(TARGET ${_target}
                POST_BUILD
                COMMAND ${CMAKE_COMMAND} -E copy ${sdl2_dll} ${study_dir}
                COMMAND ${CMAKE_COMMAND} -E copy ${sdl2_image_dll} ${study_dir}
                )
        message("either ${sdl2_dll} or ${sdl2_image_dll} not exists, move them")
#    endif()

endmacro()

macro(add_exe_static _target)
    file(GLOB _${_target}_static_src_files "${CMAKE_CURRENT_LIST_DIR}/*.cpp" "${CMAKE_CURRENT_LIST_DIR}/*.c")
    message(_${_target}_static_src_files : ${_${_target}_static_src_files})
    add_executable(${_target}_static ${_${_target}_static_src_files})
    target_link_libraries(${_target}_static PRIVATE SDL2::SDL2main SDL2::SDL2-static SDL2_image::SDL2_image-static)
    set_target_properties(${_target}_static PROPERTIES
            RUNTIME_OUTPUT_DIRECTORY ${out_dir}
            )
endmacro()

macro(build_all)
    add_custom_target(build_all
            COMMAND "D:/IDE/JetBrains/CLion 2021.3.2/bin/cmake/win/bin/cmake.exe" --build . -j
            )
endmacro()

if (EXISTS "${CMAKE_SOURCE_DIR}/bin" AND IS_DIRECTORY "${CMAKE_SOURCE_DIR}/bin")
    message("${CMAKE_SOURCE_DIR}/bin exists already, won't create")
else()
    execute_process( COMMAND ${CMAKE_COMMAND} -E make_directory "${CMAKE_SOURCE_DIR}/bin")
    message(STATUS "create ${CMAKE_SOURCE_DIR}/bin")
endif()

