cmake_minimum_required(VERSION 3.10)

# Example Android build commands:
# export ANDROID_NDK=/Users/d/Library/Android/sdk/ndk/29.0.13113456
# export ANDROID_CMAKE=$ANDROID_NDK/build/cmake/android.toolchain.cmake
# mkdir build_android
# cd build_android
# cmake -DANDROID=ON -DCMAKE_TOOLCHAIN_FILE=$ANDROID_CMAKE ..
# cmake --build .
# NOTE THAT: CMAKE_TOOLCHAIN_FILE is required from the command line.
# Otherwise its too later for CMake to figure out which build system to use.
# https://developer.android.com/ndk/guides/cmake

# Handle Android toolchain before project() command
if(ANDROID)
    # Find Android NDK
    if(NOT DEFINED ENV{ANDROID_NDK})
        set(ANDROID_NDK "/Users/d/Library/Android/sdk/ndk/29.0.13113456")
        # message(FATAL_ERROR "ANDROID_NDK environment variable not set")
    else()
        set(ANDROID_NDK $ENV{ANDROID_NDK})
    endif()

    if(NOT DEFINED CMAKE_TOOLCHAIN_FILE)
        set(CMAKE_TOOLCHAIN_FILE 
            "${ANDROID_NDK}/build/cmake/android.toolchain.cmake" 
            CACHE PATH "Android toolchain file")
    endif()
    
    # set(CMAKE_ANDROID_ARCH_ABI "arm64-v8a" CACHE STRING "Android ABI")
    # set(CMAKE_ANDROID_API 21 CACHE STRING "Android API level")
    message(STATUS "ANDROID_NDK: ${ANDROID_NDK}")
    message(STATUS "CMAKE_ANDROID_ARCH_ABI: '${CMAKE_ANDROID_ARCH_ABI}'")
    message(STATUS "CMAKE_ANDROID_API: '${CMAKE_ANDROID_API}'")
endif()

project(qtsrt_dependencies)

message(STATUS CMAKE_SYSTEM_NAME "  ${CMAKE_SYSTEM_NAME}")

# Include the zlib configuration module
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake/modules")
include(zlib)
include(libvpx)

# Set Android-specific options if needed
if(ANDROID)
    # Android-specific settings
    set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
    set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
    set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
    set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
endif()

# Define the executable target
add_executable(qtsrt_dependencies src/main.cpp)

# Add dependencies to ensure correct build order
add_dependencies(qtsrt_dependencies zlib libvpx)

# Link libraries
target_include_directories(qtsrt_dependencies PRIVATE 
    ${ZLIB_INCLUDE_DIR}
    ${LIBVPX_INCLUDE_DIR}
)
target_link_libraries(qtsrt_dependencies PRIVATE 
    ${ZLIB_LIBRARY}
    ${LIBVPX_LIBRARY}
)
