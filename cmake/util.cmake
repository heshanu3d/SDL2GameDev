set(out_dir ${CMAKE_SOURCE_DIR}/bin)

macro(copy_dll target dll dst)
    get_filename_component(_dll_name ${dll} NAME)
    if (EXISTS "${dst}/${_dll_name}")
#        message(STATUS "${dll} already exists")
    else()
        add_custom_command(TARGET ${target}
                POST_BUILD
                COMMAND ${CMAKE_COMMAND} -E copy ${dll} ${dst})
#        message(STATUS "${dll} didn't exists, move them")
    endif()
    unset(_dll_name)
endmacro()

macro(copy_all_sdl_dll target dst)
    foreach(lib ${lib_list})
        copy_dll(${target} ${${lib}_dll} ${dst})
    endforeach()
endmacro()

macro(add_exe _target)
    file(GLOB _${_target}_src_files "${CMAKE_CURRENT_LIST_DIR}/*.cpp" "${CMAKE_CURRENT_LIST_DIR}/*.c")
#    message(_${_target}_src_files : ${_${_target}_src_files})
    add_executable(${_target} ${_${_target}_src_files})
    target_link_libraries(${_target} PRIVATE _SDL2)
    set_target_properties(${_target} PROPERTIES
            RUNTIME_OUTPUT_DIRECTORY ${out_dir}
            LIBRARY_OUTPUT_DIRECTORY ${out_dir}
            )
    copy_all_sdl_dll(${_target} ${out_dir})
endmacro()
macro(add_study_exe _target)
    set(study_dir ${CMAKE_SOURCE_DIR}/study)
    file(GLOB _${_target}_src_files "${CMAKE_CURRENT_LIST_DIR}/*.cpp" "${CMAKE_CURRENT_LIST_DIR}/*.c")
#    message(_${_target}_src_files : ${_${_target}_src_files})
    add_executable(${_target}${target_suffix} ${_${_target}_src_files})
    target_link_libraries(${_target}${target_suffix} PRIVATE _SDL2)
    set_target_properties(${_target}${target_suffix} PROPERTIES
            RUNTIME_OUTPUT_DIRECTORY ${study_dir}
            LIBRARY_OUTPUT_DIRECTORY ${study_dir}
            )
    copy_all_sdl_dll(${_target} ${study_dir})

endmacro()

macro(add_exe_static _target)
    file(GLOB _${_target}_static_src_files "${CMAKE_CURRENT_LIST_DIR}/*.cpp" "${CMAKE_CURRENT_LIST_DIR}/*.c")
#    message(_${_target}_static_src_files : ${_${_target}_static_src_files})
    add_executable(${_target}_static ${_${_target}_static_src_files})
    target_link_libraries(${_target}_static PRIVATE _SDL2_static)
    set_target_properties(${_target}_static PROPERTIES
            RUNTIME_OUTPUT_DIRECTORY ${out_dir}
            )
endmacro()

macro(build_all)
    add_custom_target(build_all
            COMMAND ${cmake} ..
            COMMAND ${cmake} --build . -j
            )
endmacro()

if (EXISTS "${CMAKE_SOURCE_DIR}/bin" AND IS_DIRECTORY "${CMAKE_SOURCE_DIR}/bin")
    message("${CMAKE_SOURCE_DIR}/bin exists already, won't create")
else()
    execute_process( COMMAND ${CMAKE_COMMAND} -E make_directory "${CMAKE_SOURCE_DIR}/bin")
    message(STATUS "create ${CMAKE_SOURCE_DIR}/bin")
endif()

