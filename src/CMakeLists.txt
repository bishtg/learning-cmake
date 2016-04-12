include_directories(${CMAKE_BINARY_DIR}/src/)
include_directories(${NETCDF_INCLUDE_DIR})
link_libraries(${PETSC_LIBRARIES})
link_libraries(${NETCDF_LIBRARY})
link_libraries(${NETCDF_F90_LIBRARIES})

add_executable(HelloWorld hello.F90) 


