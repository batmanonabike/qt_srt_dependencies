#!/bin/bash
# filepath: /Users/d/src/qt_srt_dependencies_07/qtsrt_dependencies/build_android.sh

# Exit on error, but enable more debugging
set -e
# Uncomment this line for detailed debugging
# set -x

# Set NDK path - edit this if needed
export ANDROID_NDK=/Users/d/Library/Android/sdk/ndk/29.0.13113456
export ANDROID_CMAKE=$ANDROID_NDK/build/cmake/android.toolchain.cmake

echo "=== Using Android NDK at: $ANDROID_NDK ==="
echo "=== Using Android toolchain at: $ANDROID_CMAKE ==="

# Verify toolchain existence
if [ ! -f "$ANDROID_CMAKE" ]; then
    echo "❌ ERROR: Toolchain file not found at: $ANDROID_CMAKE"
    echo "Please check your NDK installation"
    exit 1
fi

# Clean build directory
echo "=== Cleaning build directory ==="
rm -rf build_android
mkdir -p build_android
cd build_android

# Configure with CMake
echo "=== Configuring with CMake ==="
cmake -DANDROID=ON \
      -DCMAKE_TOOLCHAIN_FILE=$ANDROID_CMAKE \
      -DCMAKE_ANDROID_ARCH_ABI=arm64-v8a \
      -DCMAKE_ANDROID_API=21 \
      ..

# Dump full cache for debugging
echo "=== Complete CMake cache dump ==="
cmake -LA -N . > cmake_cache.txt
cat cmake_cache.txt

# Check system name safely (won't exit if grep finds nothing)
echo "=== Safely checking system name ==="
if grep -q "CMAKE_SYSTEM_NAME:STRING=Android" cmake_cache.txt; then
    echo "✅ Building for Android!"
    SYSTEM_NAME="Android"
else
    # Try alternative detection
    SYSTEM_NAME=$(grep "CMAKE_SYSTEM_NAME:STRING=" cmake_cache.txt | cut -d= -f2 || echo "Unknown")
    echo "🚨 WARNING: System name is: $SYSTEM_NAME (expected Android)"
    echo "Will attempt to continue build anyway..."
fi

echo "=== Available targets ==="
cmake --build . --target help || true

echo "=== Building with verbose output ==="
cmake --build . --verbose

echo "=== Checking if executable was created ==="
if [ -f "qtsrt_dependencies" ]; then
    echo "✅ Executable created successfully!"
    echo "Executable location: $(pwd)/qtsrt_dependencies"
    file qtsrt_dependencies
else
    echo "❌ Executable not found!"
    echo "Searching for any executables:"
    find . -type f -executable
fi

echo "=== Available targets ==="
cmake --build . --target help

echo "=== Building ==="
cmake --build .

echo "=== Build complete ==="
echo "Executable location: $(pwd)/qtsrt_dependencies"
