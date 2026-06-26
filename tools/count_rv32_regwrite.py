#!/usr/bin/env python3
import sys


REGWRITE_OPCODES = {
    0x03,  # loads
    0x13,  # integer immediates
    0x17,  # auipc
    0x23,  # stores do not write rd, kept out below by opcode check
    0x33,  # register-register / M extension
    0x37,  # lui
    0x67,  # jalr
    0x6F,  # jal
}


def read_words(path):
    words = []
    with open(path, "r", encoding="utf-8") as f:
        for line in f:
            text = line.split("//", 1)[0].strip()
            if not text:
                continue
            token = text.split()[0]
            if len(token) >= 8:
                token = token[:8]
            try:
                words.append(int(token, 16))
            except ValueError:
                continue
    return words


def writes_register(instr):
    opcode = instr & 0x7F
    rd = (instr >> 7) & 0x1F
    if rd == 0:
        return False
    if opcode == 0x23:
        return False
    return opcode in REGWRITE_OPCODES


def main():
    if len(sys.argv) != 2:
        print("usage: count_rv32_regwrite.py <hex-file>", file=sys.stderr)
        return 2
    words = read_words(sys.argv[1])
    commits = sum(1 for instr in words if writes_register(instr))
    print(f"{len(words)} {commits}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
