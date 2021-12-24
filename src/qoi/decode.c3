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
    QOIHeader* header = (QOIHeader*)(data.ptr);
    io::printf("%s\n", libc::memcmp(&header.magic, "qoif", 4) == 0 ? "valid" : "invalid");
    io::printf("%dx%d\n", header.width.get_val(), header.height.get_val());
    int i = $sizeof(QOIHeader);
    int j = $sizeof(header);
    io::printf("debug i %d j %d\n", i, j);
    io::printf("colorspace: %s (%d) %d\n", header.colorspace.to_string(), (int)(header.colorspace), (int)($sizeof(QOIHeader)));
    io::printf("channels: %s (%hhu)\n", header.channels.to_string(), header.channels);
    return null;
}

fn PixelRGBA* file_decode(char[] filename) {
    CFile file = libc::fopen(filename.ptr, "rb");
    libc::fseek(file, 0, libc::SEEK_END);
    ulong size = libc::ftell(file);
    libc::rewind(file);
    char* data = libc::malloc(size);
    libc::fread(data, 1, size, file);
    return decode(data[0..size-1]);
}

private fn bool is_end(char* data) {
    ulong* p = (ulong*)(data);
    return *p == (ulong)(1);    
}