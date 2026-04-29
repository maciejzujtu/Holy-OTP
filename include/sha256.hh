/**
 * @file sha256.hh
 * @brief SHA-256 cryptographic hash
 *
 * Implements the SHA-256 algorithm as defined in FIPS PUB 180-4 publication.
 * The algorithm are collectively known as SHA-2, the one here is SHA-256 which
 * produces a 256-bit digest from an arbitrary byte sequence.
 * 
 * @credits
 *  Pure C implementation by LekKit     - https://github.com/LekKit/sha256/ 
 *  Wikipedia pseudocode implementation - https://en.wikipedia.org/wiki/SHA-2#Pseudocode
 */

#ifndef SHA256_HH
#define SHA256_HH



class SHA256_BUF {
    /**
     * Total bytes fed to SHA256_Update so far. Used to
     * encode the message length during finalization.
     */
    U64 data_size;  
    /**
     * Eight 32-bit working variables seeded from the square of primes
     * 2-19 by SHA256_Init, later than mixed by SHA256_Transform on every
     * complete 64-byte block.
     */
    U32 state[8];
    /**
     * Buffer data accumuluted until a full 64-byte block is ready, later
     * then SHA256_Transform is called and the buffer is cleared.
     */
    U8  buf[64];
    /**
     * Current bytes count inside of buf variable. When buf is full
     * as in it reaches 64th index a SHA256_Transform is executed.
     */
    U8  buf_size;
};

U0  SHA256_Init     (SHA256_BUF* buf);
U0  SHA256_Transform(SHA256_BUF *buf, U8 *block);
U0  SHA256_Update   (SHA256_BUF* buf, U8* buf, I64 size);
U0  SHA256_Finalize (SHA256_BUF* buf);
U0  SHA256_Read     (SHA256_BUF* buf, U8* hash);
U0  SHA256_ReadHex  (SHA256_BUF* buf, U8* hex);



#endif