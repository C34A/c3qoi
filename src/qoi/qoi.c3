module qoi;

import endian;
import std::io;

enum QOIChannels: char {
    RGB = 3,
    RGBA = 4,
}

enum QOIColorspace: char {
    SRGB_LINEAR_ALPHA = 0,
    LINEAR = 1,
}

fn char[] QOIColorspace.to_string(QOIColorspace* this) {
    io::printf("t %hhu s %lu\n", *this, $sizeof(QOIColorspace));
    switch (*this) {
        case SRGB_LINEAR_ALPHA:
            return "SRGB w/ linear alpha";
        case LINEAR:
            return "linear";
        default:
            return "unknown colorspace";
    }
}

fn char[] QOIChannels.to_string(QOIChannels* this) {
    switch (*this) {
        case RGB:
            return "RGB";
        case RGBA:
            return "RGBA";
        default:
            return "unknown channels";
    }
}

struct QOIHeader @packed {
    char[4] magic; // "qoif"
    BEUint width;    // width big endian
    BEUint height;   // height big endian
    QOIChannels channels;
    QOIColorspace colorspace;
}

// *technically* this might not be necessary...
$assert($sizeof(QOIHeader) == 14);
$assert($sizeof(QOIHeader.colorspace) == 1);