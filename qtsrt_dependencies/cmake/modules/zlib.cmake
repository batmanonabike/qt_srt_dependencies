include(ExternalProject)

# Define zlib version and installation directory
set(ZLIB_VERSION 1.3.1)
set(ZLIB_INSTALL_DIR ${CMAKE_BINARY_DIR}/zlib)

# Configure based on platform
if(ANDROID)
    # Android-specific configuration
    ExternalProject_Add(
        zlib
        URL https://github.com/madler/zlib/releases/download/v1.3.1/zlib-1.3.1.tar.gz
        URL_HASH SHA256=9a93b2b7dfdac77ceba5a558a580e74667dd6fede4585b91eefb60f03b72df23
        PREFIX ${CMAKE_BINARY_DIR}/zlib_build
        CMAKE_ARGS
            -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE}
            -DCMAKE_INSTALL_PREFIX=${ZLIB_INSTALL_DIR}
            -DCMAKE_SYSTEM_NAME=${CMAKE_SYSTEM_NAME}
            -DCMAKE_SYSTEM_VERSION=${CMAKE_SYSTEM_VERSION}
            -DCMAKE_ANDROID_ARCH_ABI=${CMAKE_ANDROID_ARCH_ABI}
            -DCMAKE_ANDROID_NDK=${CMAKE_ANDROID_NDK}
            -DCMAKE_ANDROID_STL_TYPE=${CMAKE_ANDROID_STL_TYPE}
    )
else()
    # Original configuration for non-Android platforms
    ExternalProject_Add(
        zlib
        URL https://github.com/madler/zlib/releases/download/v1.3.1/zlib-1.3.1.tar.gz
        URL_HASH SHA256=9a93b2b7dfdac77ceba5a558a580e74667dd6fede4585b91eefb60f03b72df23
        PREFIX ${CMAKE_BINARY_DIR}/zlib_build
        CONFIGURE_COMMAND <SOURCE_DIR>/configure --prefix=${ZLIB_INSTALL_DIR}
        BUILD_COMMAND make -j${CMAKE_JOB_POOL_COMPILE}
        INSTALL_COMMAND make install
    )
endif()

# Add zlib include and library paths for dependent targets
set(ZLIB_INCLUDE_DIR ${ZLIB_INSTALL_DIR}/include)
set(ZLIB_LIBRARY ${ZLIB_INSTALL_DIR}/lib/libz.a)
