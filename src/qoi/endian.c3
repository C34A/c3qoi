module endian;

import libc;

/**
 * @brief a big endian uint (32bit). use get/set_val to manipulate.
 */
struct BEUint {
    uint val;
}

$assert($sizeof(BEUint) == 4);

/**
 * @brief gets the value in a format compatible with the host system.
 * 
 * @return the value in host endianness
 */
fn uint BEUint.get_val(BEUint* this) {
    if (@is_little_endian()) {
        return byteswapu(this.val);
    } else {
        return this.val;
    }
}

/**
 * @brief Sets the value, converting endianness if necessary
 */
fn void BEUint.set_val(BEUint* this, uint newval) {
    if (@is_little_endian()) {
        this.val = byteswapu(newval);
    } else {
        this.val = newval;
    }
}

/**
 * @brief determine the host (target?) endianness
 * 
 * @return true if little endian, otherwise false
 */
macro bool is_little_endian() {
    uint test = 1;                     // 0x 01 00 00 00
    char* little_end = (char*)(&test); //    ^^
    return (bool)(*little_end) ? true : false;
}

/**
 * @brief swap bytes around to switch endianness
 */
fn uint byteswapu(uint in) {
    uint out;
    char* out_p = (char*)(&out);
    char* in_p = (char*)(&in);
    out_p[0] = in_p[3];
    out_p[1] = in_p[2];
    out_p[2] = in_p[1];
    out_p[3] = in_p[0];
    return out;
}