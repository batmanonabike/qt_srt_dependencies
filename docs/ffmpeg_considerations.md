

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


### Building zlib on MacOS

Below is a script to build and install zlib on MacOS. Ensure you have the necessary tools installed, such as `gcc` and `make`.

```bash
#!/bin/bash

# Exit on errorÍ
set -e

# Variables
ZLIB_VERSION="1.2.13"
ZLIB_URL="https://zlib.net/zlib-$ZLIB_VERSION.tar.gz"
INSTALL_DIR="/usr/local/zlib"

# Download zlib
echo "Downloading zlib version $ZLIB_VERSION..."
curl -O $ZLIB_URL

# Extract the archive
echo "Extracting zlib-$ZLIB_VERSION.tar.gz..."
tar -xzf zlib-$ZLIB_VERSION.tar.gz
cd zlib-$ZLIB_VERSION

# Configure and build
echo "Configuring and building zlib..."
./configure --prefix=$INSTALL_DIR
make -j$(sysctl -n hw.ncpu)

# Install
echo "Installing zlib to $INSTALL_DIR..."
sudo make install

# Cleanup
cd ..
rm -rf zlib-$ZLIB_VERSION zlib-$ZLIB_VERSION.tar.gz

echo "zlib $ZLIB_VERSION has been successfully built and installed to $INSTALL_DIR."
```

### Notes:
1. Update the `ZLIB_VERSION` variable to the desired version if needed.
2. Modify the `INSTALL_DIR` variable to specify a custom installation path.
3. Ensure you have `curl` installed for downloading the source archive.
4. Run the script with appropriate permissions (e.g., `sudo`) to install zlib system-wide.
