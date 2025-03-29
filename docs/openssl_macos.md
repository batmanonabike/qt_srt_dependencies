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
1. Download the OpenSSL source code:
    ```bash
    curl -O https://www.openssl.org/source/openssl-1.1.1w.tar.gz
    tar -xzf openssl-1.1.1w.tar.gz
    cd openssl-1.1.1w
    ```

2. Configure the build for macOS:
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
- Replace `openssl-1.1.1w` with the desired version.
- Ensure you have sufficient permissions for installation.
