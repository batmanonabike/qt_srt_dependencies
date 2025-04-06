#!/bin/bash
# filepath: /Users/d/src/qt_srt_dependencies_07/qtsrt_dependencies/test_android.sh

file build_android/qtsrt_dependencies

# which adb
# Push to Android device
adb push build_android/qtsrt_dependencies /data/local/tmp/

# Set executable permissions
adb shell chmod 755 /data/local/tmp/qtsrt_dependencies

# Run the executable
adb shell /data/local/tmp/qtsrt_dependencies
