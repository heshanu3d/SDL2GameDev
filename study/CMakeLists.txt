sub_dir_list(study_sub_dirs ${CMAKE_CURRENT_LIST_DIR})

foreach(sub_dir ${study_sub_dirs})
    add_subdirectory(${sub_dir})
endforeach()