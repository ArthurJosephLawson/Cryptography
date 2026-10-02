# Cryptography

**A small toolkit of interactive Bash scripts for encoding, decoding, hashing, key generation and file encryption.** Each tool has the same menu-driven interface and a colourful terminal banner.

![Shell](https://img.shields.io/badge/shell-bash-4EAA25) ![Platform](https://img.shields.io/badge/platform-Linux-lightgrey) ![Purpose](https://img.shields.io/badge/purpose-educational-blue)

> **Educational use only.** These scripts are for learning and experimenting. Most of what they do (Base64, hex, ROT13, Caesar, Morse) is *encoding*, not encryption, and offers no secrecy. Don't rely on this repo to protect anything sensitive. See [Security notes](#security-notes).

## Tools

| Script | What it does |
| --- | --- |
| [`encode.sh`](encode.sh) | Encode text: binary, base 5, decimal ASCII, hex, Base64, Caesar shift, ROT13, URL encoding, Morse, reverse, or any base from 2 to 36 |
| [`decode.sh`](decode.sh) | Reverse the above: binary, base 5, decimal ASCII, hex, Base64, Caesar shift, ROT13, URL decoding, reverse, any custom base, Morse |
| [`analyser.sh`](analyser.sh) | Analyse a piece of text: letter frequency, brute-force all 26 Caesar shifts, or character count |
| [`hashes.sh`](hashes.sh) | Hash text or a file with MD5, SHA-1, SHA-256, SHA-512 or BLAKE2 |
| [`keygen.sh`](keygen.sh) | Generate a random alphanumeric password, a 256-bit hex key, a 256-bit Base64 key, or a UUID |
| [`encryptor.sh`](encryptor.sh) | Encrypt or decrypt a file with AES-256-CBC via OpenSSL |
| [`multilayer.sh`](multilayer.sh) | Take an unknown string and try decoding it as Base64, hex and ROT13 in one go |

## Requirements

- Linux (the scripts read `/proc` and use GNU tools)
- Bash 4 or newer
- `python3` (Caesar shifts and URL encoding)
- `openssl` (key generation and file encryption)
- `xxd`, `base64`, `od`, `awk` and the usual coreutils (`md5sum`, `sha*sum`, `b2sum`)

All of these are preinstalled on most distributions. On Debian or Ubuntu, `xxd` may need `sudo apt install xxd`.

## Getting started


```bash
git clone https://github.com/ArthurJosephLawson/Cryptography.git
cd Cryptography
chmod +x *.sh      # only needed if the executable bit was lost
./encode.sh
```

Every tool is interactive. It prints its banner, asks for input, shows a numbered menu, and asks for your choice. There are no command-line arguments to remember.

## Usage examples

**Encode text as Base64**

```
$ ./encode.sh
Input: hello
Choice: 5
aGVsbG8=
```

**Brute-force a Caesar cipher**

```
$ ./analyser.sh
Input text: Khoor Zruog
Choice: 2
Shift 0: Khoor Zruog
...
Shift 23: Hello World
```

**Encrypt a file**


```
$ ./encryptor.sh
Choice: 1
File: notes.txt
enter AES-256-CBC encryption password:
Encrypted → notes.txt.enc
```

To decrypt, choose `2`, give the `.enc` file and an output name, and enter the same password.

## Details worth knowing

- **Input is one line.** Tools read a single line from the prompt. For binary, decimal and base-N decoding, separate values with spaces.
- **Morse** is letters only. Words are separated by `/` when decoding.
- **`keygen.sh`** passwords use `A-Za-z0-9` only, at the length you choose. Hex and Base64 keys are fixed at 32 bytes. The UUID comes from the kernel (`/proc/sys/kernel/random/uuid`).
- **`hashes.sh`** treats the input as a file if a file with that path exists, and as plain text otherwise.
- **`multilayer.sh`** makes one pass through three decoders and prints each result. It doesn't recurse into nested layers.
- **Banner options:** set `NO_COLOR=1` to disable colour, or `NO_BANNER_CLEAR=1` to stop the screen being cleared on start.

## Security notes

- **Encoding is not encryption.** Base64, hex, URL encoding, Morse, ROT13, Caesar and reversal are trivially reversible. They hide nothing.
- **`encryptor.sh` is a learning tool.** It uses AES-256-CBC with a salt, but without authentication (no MAC) and without an explicit modern key-derivation setting (`-pbkdf2`). For real files, use a maintained tool such as `age` or GnuPG.
- **MD5 and SHA-1 are broken** for security purposes. They're included for checksums and demonstration.
- **The banner is decoration.** The "ENCRYPTED / ACTIVE SESSION" line has no technical meaning.

## About the name

This repository is called "Cryptography" partly for its aesthetic appeal, as the in-tool disclaimer says. Think of it as a terminal toy box for playing with codes, not a security library.

## Licence


No licence file is included yet. Add one (for example MIT) to say how others may use the code.
