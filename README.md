# TOTP Generator written in HolyC

I had to learn about OTP for one of my previous projects. Whilst the project in question is no longer maintained, the mechanism was interesting enough to learn more about, which made me dive back into it. Since my current university modules familiarized me with the C language, I decided to rewrite it into HolyC.

## Installing the Compiler

Obviously HolyC's `hcc` compiler needs to be installed on your system. You can download it from [HolyC repository](https://github.com/Jamesbarford/holyc-lang) and then just run the following commands:

```bash
git clone [https://github.com/Jamesbarford/holyc-lang.git](https://github.com/Jamesbarford/holyc-lang.git)
cd HolyC
make
sudo make install
```

## Usage

1. Open the `config.hh` file located in the project directory.
2. Replace the default placeholder string with your actual Base32 secret key:

```c
#ifndef CONFIG_HH
#define CONFIG_HH

U8* TOTP_SECRET = "JBSWY3DPEHPK3PXP"; // <-- Put your secret code here

#endif
```