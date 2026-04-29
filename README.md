# HolyC TOTP Generator

This project is a fully functional Time-Based One-Time Password (TOTP) generator written entirely in HolyC, implementing HMAC-SHA256 and Base32 decoding from scratch. It features a live command-line interface that continuously updates your 2FA code and countdown timer natively on macOS and Linux.

## Installing the Compiler

To build this project, you need the `hcc` compiler installed on your system. You can download and install it directly from the [HolyC GitHub repository](https://github.com/Jamesbarford/holyc-lang) by running the following commands:

```bash
git clone [https://github.com/Jamesbarford/holyc-lang.git](https://github.com/Jamesbarford/holyc-lang.git)
cd HolyC
make
sudo make install