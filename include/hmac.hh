/**
 * @file hmac.hh
 * @brief HMAC-SHA256 message authenticator
 *
 * Implementation of HMAC as defined in RFC 2104, using
 * built in SHA-256 hashing function.
 */

#ifndef HMAC_HH
#define HMAC_HH

U0 HMAC_SHA256(U8* key, I64 key_len, U8* msg, I64 msg_len, U8* out);

#endif