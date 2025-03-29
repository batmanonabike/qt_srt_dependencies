# Building OpenSSL for macOS

Note that this document was edited using the GitHub friendly mark down [format](https://www.markdownguide.org/cheat-sheet/).

Follow these steps to build OpenSSL on macOS:

## Prerequisites
1. Install Xcode Command Line Tools:
    ```bash
    xcode-select --install
    ```
2. Install Homebrew if not already installed:
    ```bash
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```
3. Install required dependencies:
    ```bash
    brew install perl make
    ```

## Steps to Build OpenSSL
1. Download the OpenSSL source code (the sha below is 3.4):
    ```bash
    cd libs
    git clone https://github.com/openssl/openssl.git
    cd openssl
    git checkout a26d85337dbdcd33c971f38eb3fa5150e75cea87
    ```

2. Configure the build for macOS:
    ```bash
    ./Configure darwin64-arm64-cc --prefix=/usr/local/openssl
    ```
    Or, if not on Apple Silicon:  
    ```bash
    ./Configure darwin64-x86_64-cc --prefix=/usr/local/openssl
    ```

3. Build and install OpenSSL:
    ```bash
    make
    make test
    sudo make install
    ```

4. Update your environment to use the new OpenSSL version:
    ```bash
    export PATH="/usr/local/openssl/bin:$PATH"
    export LDFLAGS="-L/usr/local/openssl/lib"
    export CPPFLAGS="-I/usr/local/openssl/include"
    ```

5. Verify the installation:
    ```bash
    openssl version
    ```

## Notes
