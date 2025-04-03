cmake_minimum_required(VERSION 3.10)

project(qtsrt_dependencies)

# Android configuration block - must be before project()
if(ANDROID AND NOT DEFINED CMAKE_TOOLCHAIN_FILE)
    # Find Android NDK
    if(DEFINED ENV{ANDROID_NDK})
        set(ANDROID_NDK $ENV{ANDROID_NDK})
    elseif(EXISTS "/Users/$ENV{USER}/Library/Android/sdk/ndk")
        # Find the latest NDK version
        file(GLOB NDK_VERSIONS "/Users/$ENV{USER}/Library/Android/sdk/ndk/*")
        list(SORT NDK_VERSIONS)
        list(REVERSE NDK_VERSIONS)
        list(GET NDK_VERSIONS 0 ANDROID_NDK)
    else()
        message(FATAL_ERROR "Android NDK not found. Please set ANDROID_NDK environment variable.")
    endif()

    # Set default Android settings
    set(CMAKE_TOOLCHAIN_FILE "${ANDROID_NDK}/build/cmake/android.toolchain.cmake" CACHE PATH "Android toolchain file")
    set(CMAKE_ANDROID_ARCH_ABI "arm64-v8a" CACHE STRING "Android ABI")
    set(CMAKE_ANDROID_API 21 CACHE STRING "Android API level")
    
    # Configure a new cmake process with the toolchain file
    set(RECONFIGURE_ARGS 
        "-DANDROID=ON"
        "-DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE}"
        "-DCMAKE_ANDROID_ARCH_ABI=${CMAKE_ANDROID_ARCH_ABI}"
        "-DCMAKE_ANDROID_API=${CMAKE_ANDROID_API}"
    )
    
    message(STATUS "Reconfiguring with Android toolchain: ${CMAKE_TOOLCHAIN_FILE}")
    execute_process(
        COMMAND ${CMAKE_COMMAND} ${RECONFIGURE_ARGS} ${CMAKE_SOURCE_DIR}
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
        RESULT_VARIABLE reconfigure_result
    )
    
    if(NOT reconfigure_result EQUAL 0)
        message(FATAL_ERROR "Failed to reconfigure with Android toolchain")
    endif()
    
    return()
endif()

# Print Android configuration if in Android mode
if(ANDROID)
    message(STATUS "Building for Android:")
    message(STATUS "  NDK path: ${ANDROID_NDK}")
    message(STATUS "  ABI: ${CMAKE_ANDROID_ARCH_ABI}")
    message(STATUS "  API level: ${CMAKE_ANDROID_API}")
endif()

# Include the zlib configuration module
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake/modules")
include(zlib)

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

# Link the zlib library
target_include_directories(qtsrt_dependencies PRIVATE ${ZLIB_INCLUDE_DIR})
target_link_libraries(qtsrt_dependencies PRIVATE ${ZLIB_LIBRARY})