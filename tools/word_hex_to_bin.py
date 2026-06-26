#!/usr/bin/env python3
import sys


def clean_word(line):
    line = line.split("//", 1)[0]
    line = line.split("#", 1)[0]
    line = line.strip()
    if not line or line.startswith("@"):
        return None
    token = line.split()[0]
    if token.lower().startswith("0x"):
        token = token[2:]
    if len(token) > 8:
        raise ValueError(f"word is wider than 32 bits: {token}")
    return int(token, 16)


def main():
    if len(sys.argv) != 3:
        print("usage: word_hex_to_bin.py <instr.hex> <out.bin>", file=sys.stderr)
        return 2

    words = []
    with open(sys.argv[1], "r", encoding="utf-8") as f:
        for line in f:
            word = clean_word(line)
            if word is not None:
                words.append(word)

    with open(sys.argv[2], "wb") as f:
        for word in words:
            f.write(word.to_bytes(4, byteorder="little", signed=False))

    print(f"Converted {len(words)} words to {sys.argv[2]}")


if __name__ == "__main__":
    raise SystemExit(main())
