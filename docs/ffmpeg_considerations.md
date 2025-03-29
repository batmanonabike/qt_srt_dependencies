

# FFmpeg Dependencies, Build Order, and Tooling

Below is a table listing the dependencies required for FFmpeg, the order in which they should be built, and the required tooling for each library.

| Library         | Dependencies                     | Build Order | Required Tooling          |
|-----------------|----------------------------------|-------------|---------------------------|
| zlib           | None                             | 1           | GCC, Make                 |
| libx264        | zlib                             | 2           | GCC, Make, Yasm/Nasm      |
| libx265        | zlib                             | 3           | GCC, CMake, Make          |
| libvpx         | zlib                             | 4           | GCC, Make                 |
| libfdk-aac     | zlib                             | 5           | GCC, Autotools            |
| libmp3lame     | zlib                             | 6           | GCC, Autotools            |
| libopus        | zlib                             | 7           | GCC, Autotools            |
| libvorbis      | zlib                             | 8           | GCC, Autotools            |
| libtheora      | libvorbis, zlib                  | 9           | GCC, Autotools            |
| libass         | zlib, freetype                   | 10          | GCC, Autotools            |
| freetype       | zlib                             | 11          | GCC, CMake, Make          |
| libaom         | zlib                             | 12          | GCC, CMake, Make          |
| openssl        | zlib                             | 13          | GCC, Perl, Make           |
| FFmpeg         | All of the above dependencies    | 14          | GCC, Yasm/Nasm, Make      |

### Notes:
1. Ensure that each dependency is built and installed before proceeding to the next.
2. Use appropriate configuration flags for each library to ensure compatibility with FFmpeg.
3. Verify the installation paths and environment variables for each dependency before building FFmpeg.
4. Install the required tooling for each library before starting the build process.

### Integrating zlib Build into CMake

To integrate the zlib build process into CMake, you can use the `ExternalProject` module. This allows you to automate the download, build, and installation of zlib as part of your CMake project. Below is an example of how to achieve this:

```cmake
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
```

### Benefits of Using CMake for Dependency Management
1. **Chaining Builds**: CMake's `ExternalProject` module allows you to define dependencies between projects, ensuring that each dependency is built in the correct order.
2. **Automation**: The build, configuration, and installation steps are automated, reducing manual intervention.
3. **Portability**: CMake works across multiple platforms, making it easier to manage builds on different operating systems.
4. **Reproducibility**: By specifying exact versions and build steps, you ensure consistent builds across environments.

### Notes:
1. Replace the `SHA256` hash with the correct value for the zlib version you are using.
2. Ensure that `CMAKE_JOB_POOL_COMPILE` is set to the desired number of parallel jobs or replace it with a fixed number.
3. Use `ExternalProject_Add_StepDependencies` to chain builds with other dependencies if needed.
4. Update the `INSTALL_COMMAND` if you need to customize the installation process.
