#add_exe(01_hello_SDL)
add_study_exe(01_hello_SDL)
add_exe_static(01_hello_SDL${target_suffix})

#add_executable(01_hello_SDL_static 01_hello_SDL.cpp)
#set_target_properties(01_hello_SDL
#        PROPERTIES
#        RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin
#        LIBRARY_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin
#        )
#add_custom_command(TARGET 01_hello_SDL
#        POST_BUILD
#        COMMAND ${CMAKE_COMMAND} -E copy ${sdl2_dll} ${CMAKE_SOURCE_DIR}/bin
#        )