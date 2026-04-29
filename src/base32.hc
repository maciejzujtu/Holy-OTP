#include "include/base32.hh"

I64 Base32_Decode(U8 *in, U8* out) {
    I64 acc    = 0;
    I64 bits   = 0;
    I64 length = 0;
    I64 val;
    I64 i;
    U8  c;

    for ( i = 0; in[i] != '\0'; i++ ) {
        c = in[i];

        if ( c >= 'a' && c <= 'z' )
            c -= 32;

        if      (c >= 'A' && c <= 'Z') val = c - 'A';
        else if (c >= '2' && c <= '7') val = c - '2' + 26;
        else                           continue;

        acc   = (acc << 5) | val;
        bits += 5;

        if (bits >= 8) {
            bits          -= 8;
            out[length++]  = (acc >> bits) & 0xFF;  // ✓ out_len → length
        }
    }

    return length;
}