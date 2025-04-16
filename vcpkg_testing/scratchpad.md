# vcpkg tutorials/scratch pad

Note that this document was edited using the GitHub friendly mark down [format](https://www.markdownguide.org/cheat-sheet/).

The initial setup/build was taken from this [Microsoft Tutorial](https://learn.microsoft.com/en-us/vcpkg/get_started/get-started?pivots=shell-bash).

## Pre-requisites

### MacOS
```bash
git clone https://github.com/microsoft/vcpkg.git
cd vcpkg && ./bootstrap-vcpkg.sh
brew install ninja
brew install pkg-config
xcode-select --install
```

Setup paths *like*:
```bash
export VCPKG_ROOT=/Users/d/src/vcpkg
export PATH=$VCPKG_ROOT:$PATH
```
You can add these to: `~/.zprofile`
Then...
```bash
source ~/.zprofile
```

## Build a CMake executable with dependencies

### Dependencies and Project File
1.  Create manifest (`vcpkg.json`) with a dependency to `fmt`:
```bash
mkdir helloworld && cd helloworld
vcpkg new --application
vcpkg add port fmt
```

`vcpkg.json`:
```json
{
    "dependencies": [
        "fmt"
    ]
}
```

`vcpkg-configuration.json` specifies the minimum versions of project dependencies.  
Both of these json files should be under source control.

2. Create project files (`CMakeLists.txt`)
```cmake
cmake_minimum_required(VERSION 3.10)

project(HelloWorld)

find_package(fmt CONFIG REQUIRED)
add_executable(HelloWorld helloworld.cpp)
target_link_libraries(HelloWorld PRIVATE fmt::fmt)
```

### Build and run

CMake can automatically link libraries installed by vcpkg when `CMAKE_TOOLCHAIN_FILE` is set to use [vcpkg's custom toolchain](https://learn.microsoft.com/en-us/vcpkg/users/buildsystems/cmake-integration).

### Prepare the CMake toolchain:

1. Create `CMakePresets.json`inside the project directory:
```json
{
  "version": 2,
  "configurePresets": [
    {
      "name": "vcpkg",
      "generator": "Ninja",
      "binaryDir": "${sourceDir}/build",
      "cacheVariables": {
        "CMAKE_TOOLCHAIN_FILE": "$env{VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake"
      }
    }
  ]
}
```

2. Create `CMakeUserPresets.json`inside the project directory:
```json
{
  "version": 2,
  "configurePresets": [
    {
      "name": "default",
      "inherits": "vcpkg",
      "environment": {
        "VCPKG_ROOT": "<path to vcpkg>"
      }
    }
  ]
}
```

`CMakePresets.json` should be source control, `CMakeUserPresets.json` contains user specific path and should not.

Note that...
```json
    "environment": {
        "VCPKG_ROOT": "<path to vcpkg>"
    }
```
... can be omitted if the variable is already exported (note: **needs testing**)  
E.g. 
```bash
export VCPKG_ROOT=/Users/d/src/vcpkg
```

### Run CMake configuration

3. Configure the build:
```bash
cmake --preset=default
````

Review errors like: 
```bash
cat ./build/vcpkg-manifest-install.log
```

4. Build the project:
```bash
cmake --build build
```

5.  Run the application
```bash
./build/HelloWorld
```
