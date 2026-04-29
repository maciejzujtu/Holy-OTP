#include "include/sha256.hh"

U32 K256[64] = {
    0x428A2F98, 0x71374491, 0xB5C0FBCF, 0xE9B5DBA5,
    0x3956C25B, 0x59F111F1, 0x923F82A4, 0xAB1C5ED5,
    0xD807AA98, 0x12835B01, 0x243185BE, 0x550C7DC3,
    0x72BE5D74, 0x80DEB1FE, 0x9BDC06A7, 0xC19BF174,
    0xE49B69C1, 0xEFBE4786, 0x0FC19DC6, 0x240CA1CC,
    0x2DE92C6F, 0x4A7484AA, 0x5CB0A9DC, 0x76F988DA,
    0x983E5152, 0xA831C66D, 0xB00327C8, 0xBF597FC7,
    0xC6E00BF3, 0xD5A79147, 0x06CA6351, 0x14292967,
    0x27B70A85, 0x2E1B2138, 0x4D2C6DFC, 0x53380D13,
    0x650A7354, 0x766A0ABB, 0x81C2C92E, 0x92722C85,
    0xA2BFE8A1, 0xA81A664B, 0xC24B8B70, 0xC76C51A3,
    0xD192E819, 0xD6990624, 0xF40E3585, 0x106AA070,
    0x19A4C116, 0x1E376C08, 0x2748774C, 0x34B0BCB5,
    0x391C0CB3, 0x4ED8AA4A, 0x5B9CCA4F, 0x682E6FF3,
    0x748F82EE, 0x78A5636F, 0x84C87814, 0x8CC70208,
    0x90BEFFFA, 0xA4506CEB, 0xBEF9A3F7, 0xC67178F2
};

U32 ROTR32(U32 x, U8 n) { return ( x >> n ) | ( x << (32 - n)); }

// Main

U0 SHA256_Init(SHA256_BUF* buf) {

    // First 32 bits of square root 
    // from 2nd to 19th primes
     
    buf->state[0] = 0x6A09E667;
    buf->state[1] = 0xBB67AE85;
    buf->state[2] = 0x3C6EF372;
    buf->state[3] = 0xA54FF53A;
    buf->state[4] = 0x510E527F;
    buf->state[5] = 0x9B05688C;
    buf->state[6] = 0x1F83D9AB;
    buf->state[7] = 0x5BE0CD19;
    buf->data_size = 0;
    buf->buf_size  = 0;
}

U0 SHA256_Transform(SHA256_BUF* buf, U8* block) {
    U32 W[64]; // Words
    U32 a, b, c, d, e, f, g, h;
    U32 aux, bux;

    I64 i;

    for ( i = 0; i < 16; i++ ) {
        W[i] =  (block[i*4+0] << 24) |
                (block[i*4+1] << 16) |
                (block[i*4+2] <<  8) |
                (block[i*4+3]);
    }

    for ( i = 16; i < 64; i++ ) {
        U32 sigma0 = ROTR32( W[i-15], 7 ) ^ ROTR32( W[i-15], 18 ) ^ (W[i-15] >> 3);
        U32 sigma1 = ROTR32( W[i-2], 17 ) ^ ROTR32( W[i-2], 19  ) ^ (W[i-2]  >> 10);
        W[i] = W[i-16] + sigma0 + W[i-7] + sigma1; 
    }

   a = buf->state[0]; 
   b = buf->state[1]; 
   c = buf->state[2]; 
   d = buf->state[3];
   e = buf->state[4]; 
   f = buf->state[5]; 
   g = buf->state[6]; 
   h = buf->state[7];

   for ( i = 0; i < 64; i++ ) {
        U32 Sigma1 = ROTR32( e, 6 ) ^ ROTR32( e, 11 ) ^ ROTR32( e, 25 );
        U32 Sigma0 = ROTR32( a, 2 ) ^ ROTR32( a, 13 ) ^ ROTR32( a, 22 );

        U32 ch = ( e & f ) ^ ( ~e & g );
        U32 maj = ( a & b) ^ ( a & c) ^ ( b & c );

        aux = h + Sigma1 + ch + K256[i] + W[i];
        bux = Sigma0 + maj;

        h = g;
        g = f;
        f = e;
        e = d + aux;
        d = c;
        c = b;
        b = a;
        a = aux + bux;
   }
   
   buf->state[0] += a;
   buf->state[1] += b;
   buf->state[2] += c;
   buf->state[3] += d;
   buf->state[4] += e;
   buf->state[5] += f;
   buf->state[6] += g;
   buf->state[7] += h;
}

U0 SHA256_Update(SHA256_BUF* buf, U8* block, I64 size) {
    I64 i;
    I64 idx;

    for (i = 0; i < size; i++) {
        idx = buf->buf_size;
        buf->buf[idx] = block[i];
        buf->buf_size++;

        if (buf->buf_size == 64) {
            SHA256_Transform(buf, buf->buf);
            buf->buf_size = 0;
        }
    }

    buf->data_size += size;
}

U0 SHA256_Finalize(SHA256_BUF* buf) {
    U64 bit_len;
    I64 i;
    U8  b;

    bit_len = buf->data_size * 8;

    b = 0x80;
    SHA256_Update(buf, &b, 1);
    b = 0x00;
    while ( buf->buf_size != 56 ) {
        SHA256_Update(buf, &b, 1);
    }

    for ( i = 7; i >= 0; i-- ) {
        b = (bit_len >> (i * 8)) & 0xFF;
        SHA256_Update(buf, &b, 1);
    }
}

U0 SHA256_Read(SHA256_BUF* buf, U8* hash) {
    I64 i;
    for ( i = 0; i < 8; i++ ) {
        hash[i*4+0] = (buf->state[i] >> 24) & 0xFF;
        hash[i*4+1] = (buf->state[i] >> 16) & 0xFF;
        hash[i*4+2] = (buf->state[i] >>  8) & 0xFF;
        hash[i*4+3] =  buf->state[i]        & 0xFF;
    }
}

U0 SHA256_ReadHex(SHA256_BUF* buf, U8* hex) {
    U8  hash[32];
    U8  *digits = "0123456789abcdef"; 
    I64 i;
    
    SHA256_Read(buf, hash);

    for (i = 0; i < 32; i++) {
        hex[i*2+0] = digits[(hash[i] >> 4) & 0xF];
        hex[i*2+1] = digits[ hash[i]       & 0xF];
    }
}