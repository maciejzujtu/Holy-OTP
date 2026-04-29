/**
 * @file main.hc
 * @brief Wires together the full pipeline of functions to create
 * TOTP code as per RFC 6238 standard built on RFC 4226 HOTP
 */

#include "src/sha256.hc"
#include "src/hmac.hc"
#include "src/base32.hc"
#include "src/totp.hc"
#include "config.hh"

extern "c" I32 sleep(I32 seconds);
extern "c" I32 fflush(I64 stream);

U0 PrintHex(U8 *buf, I64 len) {
    U8 *d = "0123456789abcdef";
    I64 i;
    I64 b;
    for (i = 0; i < len; i++) {
        b = cast<I64>(buf[i]);
        "%c%c", d[(b >> 4) & 0xF], d[b & 0xF];
    }
    "\n";
}

U0 Main() {
    SHA256_BUF buf;
    U8  msg[]  = "hello world";
    U8  hash[32];
    U8  hex[64];

    SHA256_Init(&buf);
    SHA256_Update(&buf, msg, 11);
    SHA256_Finalize(&buf);
    SHA256_Read(&buf, hash);
    SHA256_ReadHex(&buf, hex);

    "SHA256 (binary): ";
    PrintHex(hash, 32);

    "SHA256 (hex):    ";
    U8 *hp = hex;
    I64 i;
    for (i = 0; i < 64; i++)
        "%c", hp[i];
    "\n";

    U8 hmac_key[] = "key";
    U8 hmac_msg[] = "message";
    U8 hmac_out[32];

    HMAC_SHA256(hmac_key, 3, hmac_msg, 7, hmac_out);

    "HMAC-SHA256:     ";
    PrintHex(hmac_out, 32);
    "\n";

    I64 otp;
    I64 time_left;

    "Live TOTP Generator\n";
    "Press CTRL+C to exit the loop.\n\n";

    while (1) {
        otp = TOTP_Generate(TOTP_SECRET); 
        time_left = TOTP_STEP - (GetUnixTime() % TOTP_STEP);

        "\rTOTP: %06d  [Expires in: %02ds]   ", otp, time_left;
        fflush(0);
        sleep(1); 
    }
}