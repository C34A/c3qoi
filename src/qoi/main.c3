module qmain;

import std::io;

import qoi;
import qoi::decode;
import endian;

fn int main(int argc, char** argv) {
    io::printf("%d\n", $sizeof(QOIHeader));
    io::printf("%x %x\n", 1234, endian::byteswapu(1234));

    return 0;
}