include(ExternalProject)

# Define libvpx version and installation directory
set(LIBVPX_VERSION 1.14.1)
set(LIBVPX_INSTALL_DIR ${CMAKE_BINARY_DIR}/libvpx)

# libvpx depends on zlib, ensure it's included
if(NOT TARGET zlib)
    include(${CMAKE_CURRENT_LIST_DIR}/zlib.cmake)
endif()

# Set common configure options
set(LIBVPX_CONFIGURE_OPTIONS
    --prefix=${LIBVPX_INSTALL_DIR}
    --disable-examples
    --disable-unit-tests
    --disable-docs
    --enable-pic
    --enable-vp8
    --enable-vp9
    --enable-static
    --disable-shared
)

# Configure based on platform
if(ANDROID)
    # Debug the Android ABI value
    message(STATUS "Android ABI for libvpx: '${CMAKE_ANDROID_ARCH_ABI}' ✅")
    
    # Android-specific configuration
    if(CMAKE_ANDROID_ARCH_ABI STREQUAL "armeabi-v7a")
        set(LIBVPX_TARGET "armv7-android-gcc")
    elseif(CMAKE_ANDROID_ARCH_ABI STREQUAL "arm64-v8a")
        set(LIBVPX_TARGET "arm64-android-gcc")
        message(STATUS "Setting libvpx target to arm64-android-gcc for arm64-v8a")
    elseif(CMAKE_ANDROID_ARCH_ABI STREQUAL "x86")
        set(LIBVPX_TARGET "x86-android-gcc")
    elseif(CMAKE_ANDROID_ARCH_ABI STREQUAL "x86_64")
        set(LIBVPX_TARGET "x86_64-android-gcc")
    else()
        # Force arm64-android-gcc if we can't determine the right target
        message(WARNING "Unknown Android architecture: '${CMAKE_ANDROID_ARCH_ABI}', defaulting to arm64-android-gcc")
        set(LIBVPX_TARGET "arm64-android-gcc")
    endif()
    
    message(STATUS "Selected libvpx target: ${LIBVPX_TARGET}")
    
    list(APPEND LIBVPX_CONFIGURE_OPTIONS --target=${LIBVPX_TARGET})
    
    ExternalProject_Add(
        libvpx
        DEPENDS zlib
        URL https://chromium.googlesource.com/webm/libvpx/+archive/12f3a2ac603e8f10742105519e0cd03c3b8f71dd.tar.gz
        PREFIX ${CMAKE_BINARY_DIR}/libvpx_build
        CONFIGURE_COMMAND cd <SOURCE_DIR> && 
                          export CFLAGS="-I${ZLIB_INCLUDE_DIR}" &&
                          export LDFLAGS="-L${ZLIB_INSTALL_DIR}/lib" &&
                          <SOURCE_DIR>/configure ${LIBVPX_CONFIGURE_OPTIONS}
        BUILD_COMMAND make -j${CMAKE_JOB_POOL_COMPILE}
        INSTALL_COMMAND make install
        BUILD_IN_SOURCE 1
    )
else()
    # Configuration for non-Android platforms
    # Determine target based on host system
    if(APPLE)
        if(CMAKE_SYSTEM_PROCESSOR MATCHES "arm64")
            set(LIBVPX_TARGET "arm64-darwin-gcc")
        else()
            set(LIBVPX_TARGET "x86_64-darwin-gcc")
        endif()
    elseif(UNIX)
        if(CMAKE_SYSTEM_PROCESSOR MATCHES "aarch64")
            set(LIBVPX_TARGET "arm64-linux-gcc")
        elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "arm")
            set(LIBVPX_TARGET "armv7-linux-gcc")
        elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "x86_64")
            set(LIBVPX_TARGET "x86_64-linux-gcc")
        else()
            set(LIBVPX_TARGET "x86-linux-gcc")
        endif()
    elseif(WIN32)
        if(CMAKE_SYSTEM_PROCESSOR MATCHES "AMD64")
            set(LIBVPX_TARGET "x86_64-win64-gcc")
        else()
            set(LIBVPX_TARGET "x86-win32-gcc")
        endif()
    endif()
    
    list(APPEND LIBVPX_CONFIGURE_OPTIONS --target=${LIBVPX_TARGET})

    # TODO: Use the correct URL for the libvpx.  Test this path.
    ExternalProject_Add(
        libvpx
        DEPENDS zlib
        URL https://github.com/webmproject/libvpx/archive/v${LIBVPX_VERSION}.tar.gz
        PREFIX ${CMAKE_BINARY_DIR}/libvpx_build
        CONFIGURE_COMMAND cd <SOURCE_DIR> && 
                          export CFLAGS="-I${ZLIB_INCLUDE_DIR}" &&
                          export LDFLAGS="-L${ZLIB_INSTALL_DIR}/lib" &&
                          <SOURCE_DIR>/configure ${LIBVPX_CONFIGURE_OPTIONS}
        BUILD_COMMAND make -j${CMAKE_JOB_POOL_COMPILE}
        INSTALL_COMMAND make install
        BUILD_IN_SOURCE 1
    )
endif()

# Set variables for consumers
set(LIBVPX_INCLUDE_DIR ${LIBVPX_INSTALL_DIR}/include)
set(LIBVPX_LIBRARY ${LIBVPX_INSTALL_DIR}/lib/libvpx.a)