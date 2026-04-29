#include "include/sha256.hh"
#include "include/hmac.hh"
#include "include/base32.hh"
#include "include/totp.hh"

extern "c" I64 time(I64 *t);

/**
 * Calls libc time() which returns unix timestamp
 */
I64 GetUnixTime() {
    return time(0);
}

U0 U64_BigEndian(U64 val, U8 *out) {
    I64 i;
    for (i = 7; i >= 0; i--) {
        out[i] = val & 0xFF;
        val >>= 8;
    }
}

I64 TOTP_Generate(U8 *b32_secret) {
    U8  key[64];
    U8  counter[8];
    U8  hmac_out[32];
    I64 key_len;
    U64 T;
    I64 offset;
    U32 code;
    U8  *p;

    key_len = Base32_Decode(b32_secret, key);
    T = GetUnixTime() / TOTP_STEP;
    U64_BigEndian(T, counter);
    HMAC_SHA256(key, key_len, counter, 8, hmac_out);

    offset = hmac_out[31] & 0x0F;
    p = hmac_out + offset;

    code =  ((cast<U32>(p[0]) & 0x7F) << 24) |
            ((cast<U32>(p[1]) & 0xFF) << 16) |
            ((cast<U32>(p[2]) & 0xFF) <<  8) |
            ((cast<U32>(p[3]) & 0xFF));

    return code % 1000000;
}