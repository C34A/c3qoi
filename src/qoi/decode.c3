module qoi::decode;

import qoi;
import std::io;
import libc;
import std::mem;

// todo: tests!

struct PixelRGBA {
    char r;
    char g;
    char b;
    char a;
}

fn PixelRGBA* decode(char[] data) {
    QOIHeader* header = (QOIHeader*)(&data);
    io::printf("%.*s", 4, &header.magic);

}

fn PixelRGBA* file_decode(char[] filename) {
    CFile file = libc::fopen(filename.ptr, "rb");
    libc::fseek(file, libc::SEEK_END);
    ulong size = libc::ftell(file);
    libc::fseek(file, libc::SEEK_SET);
    char* data = libc::malloc(size);
    for (ulong i = 0; i < size; i++) {
        
    }
}

private fn bool is_end(char* data) {
    ulong* p = (ulong*)(data);
    return *p == (ulong)(1);    
}