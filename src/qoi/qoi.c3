module qoi;

import endian;

enum QOIChannels: char {
    RGB = 3,
    RGBA = 4,
}

enum QOIColorspace: char {
    SRGB_LINEAR_ALPHA = 0,
    LINEAR = 1,
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