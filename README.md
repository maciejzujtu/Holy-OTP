# TOTP Generator written in HolyC

I had to learn about OTP for one of my previous projects. Whilst the project in question is no longer maintained, the mechanism was interesting enough to learn more about, which made me dive back into it. Since my current university modules familiarized me with the C language, I decided to rewrite it into HolyC.

## Installing the Compiler

In order to build this project, you need the `hcc` compiler installed on your system. You can download and install it directly from the [HolyC repository](https://github.com/Jamesbarford/holyc-lang) by running the following commands:

```bash
git clone [https://github.com/Jamesbarford/holyc-lang.git](https://github.com/Jamesbarford/holyc-lang.git)
cd HolyC
make
sudo make install
```

## Usage

Before compiling and running the generator, you need to configure your secret key.

1. Open the `config.hh` file located in the project directory.
2. Replace the default placeholder string with your actual Base32 secret key:

```c
#ifndef CONFIG_HH
#define CONFIG_HH

U8* TOTP_SECRET = "JBSWY3DPEHPK3PXP"; // <-- Put your secret code here

#endif
```

3. Compile and run the project using the included Makefile. Open your terminal in the project root and run:

```bash
make
./bin/main
```

The program will output test hashes to verify the cryptography is working correctly, followed by a live, continuously updating terminal dashboard displaying your active TOTP code and a countdown timer. To exit the loop, simply press `CTRL+C`.