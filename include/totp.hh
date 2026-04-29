/**
 * @file totp.hh
 * @brief TOTP time-based one-time password
 *
 * Implementation of TOTP as defined in RFC 6238, using
 * built-in HMAC-SHA256 as the underlying MAC function.
 */

#ifndef TOTP_HH
#define TOTP_HH

#define TOTP_STEP   30  /** New code generates every 30 seconds */
#define TOTP_DIGITS 6   /** Number of digits in the output code */

I64 TOTP_Generate(U8 *b32_secret);

#endif