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
mkdir build_android
cd build_android
cmake -DANDROID=ON ..
cmake --build .
```

**Make sure your ANDROID_NDK environment variable is set correctly before running these commands.**

## Running the Application

After building the project, you can run the application with the following command:
```
./qtsrt_dependencies
```

## Usage

The application utilizes the zlib library for compression and decompression tasks. Refer to the source code in `src/main.cpp` for implementation details.

## Android considerations

`add_executable` in CMake will build executables for Android when using the Android toolchain. However, there are important considerations:

### How It Works for Android
When building with the Android NDK toolchain:
  - The executable is compiled for the target architecture (arm64-v8a)
  - The binary format is Android-compatible (ELF)
  - It will use proper Android dynamic linker paths

### Important Considerations
1. Deployment: Android executables aren't packaged as APKs - they're raw binaries that must be:
    - Deployed manually via `adb push`
    - Executed with proper permissions via `adb shell`

2. Use Cases: Native executables on Android are typically for:
   - Command-line utilities
   - Background services
   - Native components that are called from Java/Kotlin

3. For a Complete Android App: If you're building an Android application, you would typically:

   - Use add_library(... SHARED ...) instead of add_executable
   - Package the library with Gradle into an APK
   
For your current setup with CLI tools or native utilities, add_executable is appropriate. For a complete Android application, you'd need additional packaging steps.
