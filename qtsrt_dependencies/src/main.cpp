#include <iostream>
#include <zlib.h>

int main() {
    std::cout << "Hello, qtsrt_dependencies!" << std::endl;

    // Example usage of zlib
    const char* original = "Hello, zlib!";
    uLong originalLength = strlen(original) + 1; // +1 for null terminator
    uLong compressedLength = compressBound(originalLength);
    Bytef* compressed = new Bytef[compressedLength];

    if (compress(compressed, &compressedLength, reinterpret_cast<const Bytef*>(original), originalLength) == Z_OK) {
        std::cout << "Compression successful!" << std::endl;
    } else {
        std::cerr << "Compression failed!" << std::endl;
    }

    delete[] compressed;
    return 0;
}