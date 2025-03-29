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

## Running the Application

After building the project, you can run the application with the following command:
```
./qtsrt_dependencies
```

## Usage

The application utilizes the zlib library for compression and decompression tasks. Refer to the source code in `src/main.cpp` for implementation details.

## License

This project is licensed under the MIT License. See the LICENSE file for more information.