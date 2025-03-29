cmake_minimum_required(VERSION 3.10)

project(qtsrt_dependencies)

# Include the zlib configuration module
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake/modules")
include(zlib)

# Define the executable target
add_executable(qtsrt_dependencies src/main.cpp)

# Link the zlib library
target_include_directories(qtsrt_dependencies PRIVATE ${ZLIB_INCLUDE_DIR})
target_link_libraries(qtsrt_dependencies PRIVATE ${ZLIB_LIBRARY})

# target_link_libraries(qtsrt_dependencies PRIVATE zlib)