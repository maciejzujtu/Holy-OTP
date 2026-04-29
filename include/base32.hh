/**
 * @file base32.hh
 * @brief Base32 decoder
 *
 * Decodes Base32-encoded strings to bytes using
 * RFC 4648 data encoding schema
 */

#ifndef BASE32_HH
#define BASE32_HH

I64 Base32_Decode(U8* in, U8* out);

#endif