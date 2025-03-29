include(ExternalProject)

# Define zlib version and installation directoryÍ
set(ZLIB_VERSION 1.2.13)
set(ZLIB_INSTALL_DIR ${CMAKE_BINARY_DIR}/zlib)

# Add ExternalProject for zlib
ExternalProject_Add(
    zlib
    URL https://zlib.net/zlib-${ZLIB_VERSION}.tar.gz
    URL_HASH SHA256=7a62b6c5a7b7b8c1b8c1b8c1b8c1b8c1b8c1b8c1b8c1b8c1b8c1b8c1b8c1b8c1
    PREFIX ${CMAKE_BINARY_DIR}/zlib_build
    CONFIGURE_COMMAND <SOURCE_DIR>/configure --prefix=${ZLIB_INSTALL_DIR}
    BUILD_COMMAND make -j${CMAKE_JOB_POOL_COMPILE}
    INSTALL_COMMAND make install
)

# Add zlib include and library paths for dependent targets
set(ZLIB_INCLUDE_DIR ${ZLIB_INSTALL_DIR}/include)
set(ZLIB_LIBRARY ${ZLIB_INSTALL_DIR}/lib/libz.a)

# Example: Linking zlib to a target
# target_include_directories(your_target PRIVATE ${ZLIB_INCLUDE_DIR})
# target_link_libraries(your_target PRIVATE ${ZLIB_LIBRARY})
