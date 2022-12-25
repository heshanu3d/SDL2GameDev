add_exe(RecoverMemory)
#target_link_libraries(RecoverMemory PRIVATE tmx)
#set(tmx_out ${libtmx_dir}/out)
set(tmx_out ${tmx_dir})

target_link_libraries(RecoverMemory PRIVATE -L${tmx_out}/lib -ltmx -lxml2 -lzlibstatic)
target_include_directories(RecoverMemory PRIVATE ${tmx_out}/include)