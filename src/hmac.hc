#include "include/sha256.hh"
#include "include/hmac.hh"

U0 HMAC_SHA256(U8 *key, I64 key_len, U8 *msg, I64 msg_len, U8 *out) {
    U8         k[64];
    U8         ipad_key[64];
    U8         opad_key[64];
    U8         inner[32];
    SHA256_BUF buf;
    I64        i;

    MemSet(k, 0, 64);
    if ( key_len > 64 ) {
        SHA256_Init(&buf);
        SHA256_Update(&buf, key, key_len);
        SHA256_Finalize(&buf);
        SHA256_Read(&buf, k);
    } else {
        MemCpy(k, key, key_len); 
    }

    for ( i = 0; i < 64; i++ ) {
        ipad_key[i] = k[i] ^ 0x36;
        opad_key[i] = k[i] ^ 0x5C;
    }

    SHA256_Init(&buf);
    SHA256_Update(&buf, ipad_key, 64);
    SHA256_Update(&buf, msg, msg_len);
    SHA256_Finalize(&buf);
    SHA256_Read(&buf, inner);

    SHA256_Init(&buf);
    SHA256_Update(&buf, opad_key, 64);
    SHA256_Update(&buf, inner, 32);
    SHA256_Finalize(&buf);
    SHA256_Read(&buf, out); 
}