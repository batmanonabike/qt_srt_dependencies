# qtsrt_dependencies

This project is called `qtsrt_dependencies`, which demonstrates the integration of the zlib library using CMake.

## Project Structure

```
qtsrt_dependencies
├── CMakeLists.txt        # Main configuration file for CMake
├── cmake
│   └── modules
│       └── zlib.cmake    # CMake module for zlib configuration
├── src
│   └── main.cpp          # Entry point of the application
├── include
│   └── config.h         # Header file for configuration settings
└── README.md             # Project documentation
```

## Requirements

- CMake (version 3.10 or higher)
- zlib library

## Building the Project

To build the project, follow these steps:

1. Clone the repository:
   ```
   git clone <repository-url>
   cd qtsrt_dependencies
   ```

2. Create a build directory:
   ```
   mkdir build
   cd build
   ```

3. Run CMake to configure the project:
   ```
   cmake ..
   ```

4. Build the project:
   ```
   cmake --build .
   ```

## Building the Project for Android

### To build for Android using Qt Creator:

1. Open your project in Qt Creator
2. Configure the project for your Android kit
3. In Build Settings, add these CMake arguments:
```CMake
-DCMAKE_TOOLCHAIN_FILE=/Users/d/Library/Android/sdk/ndk/29.0.13113456/build/cmake/android.toolchain.cmake
-DANDROID=ON
-DCMAKE_SYSTEM_NAME=Android
-DCMAKE_ANDROID_ARCH_ABI=arm64-v8a
-DCMAKE_ANDROID_API=21
```

### To build for Android from the command line:

```bash
export ANDROID_NDK=/Users/d/Library/Android/sdk/ndk/29.0.13113456
mkdir -p build/android
cd build/android
cmake -DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK/build/cmake/android.toolchain.cmake \
      -DANDROID=ON \
      -DCMAKE_SYSTEM_NAME=Android \
      -DCMAKE_ANDROID_ARCH_ABI=arm64-v8a \
      -DCMAKE_ANDROID_API=21 \
      ../..
make
```

**Make sure your ANDROID_NDK environment variable is set correctly before running these commands.**

## Running the Application

After building the project, you can run the application with the following command:
```
./qtsrt_dependencies
```

## Usage

The application utilizes the zlib library for compression and decompression tasks. Refer to the source code in `src/main.cpp` for implementation details.

## License

This project is licensed under the MIT License. See the LICENSE file for more information.