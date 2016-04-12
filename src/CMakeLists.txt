include_directories(${CMAKE_BINARY_DIR}/src/)
link_libraries(${PETSC_LIBRARIES})

add_executable(HelloWorld hello.F90) 


