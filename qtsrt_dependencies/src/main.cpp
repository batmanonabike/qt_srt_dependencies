#include <iostream>
#include <zlib.h>
#include <vpx/vpx_encoder.h>
#include <vpx/vp8cx.h>

// Simple VP8/VP9 encoder initialization example
bool initialize_vpx() {
    vpx_codec_ctx_t codec;
    vpx_codec_enc_cfg_t cfg;
    vpx_codec_err_t res;
    
    // Initialize the config with default values for VP8
    res = vpx_codec_enc_config_default(vpx_codec_vp8_cx(), &cfg, 0);
    if (res) {
        std::cerr << "Failed to get default encoder config: " 
                  << vpx_codec_err_to_string(res) << std::endl;
        return false;
    }
    
    // Set basic configuration values
    cfg.g_w = 640;  // width
    cfg.g_h = 480;  // height
    cfg.rc_target_bitrate = 800;  // bitrate in kbps
    
    // Initialize encoder
    res = vpx_codec_enc_init(&codec, vpx_codec_vp8_cx(), &cfg, 0);
    if (res) {
        std::cerr << "Failed to initialize encoder: " 
                  << vpx_codec_err_to_string(res) << std::endl;
        return false;
    }
    
    // Clean up
    vpx_codec_destroy(&codec);
    return true;
}

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

    // Test libvpx
    if (initialize_vpx()) {
        std::cout << "libvpx initialized successfully!" << std::endl;
    } else {
        std::cerr << "libvpx initialization failed!" << std::endl;
    }

    return 0;
}
