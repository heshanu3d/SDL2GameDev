set(out_dir ${CMAKE_SOURCE_DIR}/bin)
macro(add_exe _target)
    file(GLOB _${_target}_src_files "${CMAKE_CURRENT_LIST_DIR}/*.cpp" "${CMAKE_CURRENT_LIST_DIR}/*.c")
    message(_${_target}_src_files : ${_${_target}_src_files})
    add_executable(${_target} ${_${_target}_src_files})
    set_target_properties(${_target} PROPERTIES
            RUNTIME_OUTPUT_DIRECTORY ${out_dir}
            LIBRARY_OUTPUT_DIRECTORY ${out_dir}
            )
    add_custom_command(TARGET ${_target}
            POST_BUILD
            COMMAND ${CMAKE_COMMAND} -E copy ${sdl2_dll} ${out_dir}
            )
endmacro()

if (EXISTS "${CMAKE_SOURCE_DIR}/bin" AND IS_DIRECTORY "${CMAKE_SOURCE_DIR}/bin")
    message("${CMAKE_SOURCE_DIR}/bin exists already, won't create")
else()
    execute_process( COMMAND ${CMAKE_COMMAND} -E make_directory "${CMAKE_SOURCE_DIR}/bin")
    message(STATUS "create ${CMAKE_SOURCE_DIR}/bin")
endif()

