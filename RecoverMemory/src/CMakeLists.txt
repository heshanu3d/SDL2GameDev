add_exe(RecoverMemory)

execute_process(COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_SOURCE_DIR}/RecoverMemory/assets/ ${CMAKE_SOURCE_DIR}/bin)