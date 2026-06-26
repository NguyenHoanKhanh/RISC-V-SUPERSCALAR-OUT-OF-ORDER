from pathlib import Path


OUT_DIR = Path("riscv-tests-master/isa/rv32i_mips_friendly")

R_TMP = [20, 21, 22, 23, 24, 25, 26, 27, 28, 29]
PRODUCER_PAD = 6
BRANCH_PAD = 24
BRANCH_RECOVERY_PAD = 24
MEMORY_PAD = 8
FAIL_PAD = 14
USEFUL_FILLER_PERIOD = 8


def s32(v):
    v &= 0xFFFFFFFF
    return v - 0x100000000 if v & 0x80000000 else v


def u32(v):
    return v & 0xFFFFFFFF


def imm12(v):
    if not -2048 <= v <= 2047:
        raise ValueError(f"immediate out of range: {v}")
    return v


def asm_li(rd, value):
    value = s32(value)
    if -2048 <= value <= 2047:
        return [f"  addi x{rd}, x0, {value}"]
    hi = (value + 0x800) >> 12
    lo = value - (hi << 12)
    if hi < 0:
        hi &= 0xFFFFF
    return [f"  lui x{rd}, {hi}", f"  addi x{rd}, x{rd}, {lo}"]


def filler(state, n=5, comment=None):
    lines = []
    if comment:
        lines.append(f"  # {comment}")
    for _ in range(n):
        if (state["idx"] % USEFUL_FILLER_PERIOD) == 0:
            rd = R_TMP[(state["idx"] // USEFUL_FILLER_PERIOD) % len(R_TMP)]
            value = ((state["idx"] * 7) + 3) & 0x7FF
            lines.append(f"  addi x{rd}, x0, {value}")
        else:
            lines.append("  addi x0, x0, 0")
        state["idx"] += 1
    return lines


def header():
    return [
        "# Auto-generated RV32I MIPS-friendly benchmark.",
        "# Purpose: keep producer/consumer spacing safe for the in-order source,",
        "# but replace a small fraction of NOP padding with independent useful instructions.",
        "",
        "  .section .text",
        "  .option norvc",
        "  .text",
        "  .globl _start",
        "  .globl rv32im_scoreboard_init",
        "  .globl benchmark_start",
        "  .globl benchmark_end",
        "  .globl rv32im_perf_begin",
        "  .globl rv32im_perf_end",
        "  .globl rv32im_scoreboard_finalize",
        "_start:",
        "rv32im_scoreboard_init:",
        "  addi x31, x0, 0",
        *filler({"idx": 0}, PRODUCER_PAD, "friendly: scoreboard init spacing"),
        "  addi x30, x0, 0",
        *filler({"idx": PRODUCER_PAD}, PRODUCER_PAD, "friendly: scoreboard init spacing"),
        "benchmark_start:",
        "rv32im_perf_begin:",
        "",
    ]


def footer():
    return [
        "rv32im_scoreboard_finalize:",
        "benchmark_end:",
        "rv32im_perf_end:",
        "  addi x31, x0, 1",
        "pass_loop:",
        "  beq x0, x0, pass_loop",
        "  addi x0, x0, 0",
        "",
    ]


def fail_block(test_id, state):
    return [
        f"fail_{test_id}:",
        f"  addi x30, x0, {test_id}",
        *filler(state, FAIL_PAD, "friendly: useful fail-path cushion"),
        "  addi x31, x0, -1",
        f"fail_loop_{test_id}:",
        f"  beq x0, x0, fail_loop_{test_id}",
        "  addi x0, x0, 0",
        "",
    ]


def check_result(test_id, expected, state):
    lines = []
    lines += filler(state, PRODUCER_PAD, "friendly: producer-result spacing")
    lines += asm_li(7, expected)
    lines += filler(state, BRANCH_PAD, "friendly: branch operand spacing")
    lines += [
        f"  beq x14, x7, mips_friendly_pass_{test_id}",
    ]
    lines += filler(state, BRANCH_RECOVERY_PAD, "friendly: taken-branch recovery cushion before local fail path")
    lines += fail_block(test_id, state)
    lines += [f"mips_friendly_pass_{test_id}:"]
    lines += [""]
    return lines


def binary_tests(op):
    base = [(0, 0), (1, 2), (7, 5), (-4, 9), (31, -8), (-12, -3)]
    if op in ("sll", "sra"):
        base = [(1, 0), (1, 1), (3, 2), (-16, 1), (0x7F, 3), (-1, 4)]
    if op == "srl":
        base = [(1, 0), (1, 1), (3, 2), (16, 1), (0x7F, 3), (255, 4)]
    return base


def immediate_tests(op):
    base = [(0, 0), (1, 2), (7, -3), (-4, 9), (31, -8), (-12, 11)]
    if op in ("slli", "srai"):
        base = [(1, 0), (1, 1), (3, 2), (-16, 1), (0x7F, 3), (-1, 4)]
    if op in ("srli", "srl_ext"):
        base = [(1, 0), (1, 1), (3, 2), (16, 1), (0x7F, 3), (255, 4)]
    return base


def calc_r(op, a, b):
    if op == "add":
        return s32(a + b)
    if op == "sub":
        return s32(a - b)
    if op == "and":
        return s32(a & b)
    if op == "or":
        return s32(a | b)
    if op == "xor":
        return s32(a ^ b)
    if op == "sll":
        return s32(u32(a) << (b & 31))
    if op == "srl":
        return s32(u32(a) >> (b & 31))
    if op == "sra":
        return s32(s32(a) >> (b & 31))
    if op == "slt":
        return 1 if s32(a) < s32(b) else 0
    if op == "sltu":
        return 1 if u32(a) < u32(b) else 0
    raise ValueError(op)


def calc_i(op, a, imm):
    if op == "addi":
        return s32(a + imm)
    if op == "andi":
        return s32(a & imm)
    if op == "ori":
        return s32(a | imm)
    if op == "xori":
        return s32(a ^ imm)
    if op == "slli":
        return s32(u32(a) << (imm & 31))
    if op in ("srli", "srl_ext"):
        return s32(u32(a) >> (imm & 31))
    if op in ("srai", "sra_ext"):
        return s32(s32(a) >> (imm & 31))
    if op == "slti":
        return 1 if s32(a) < imm else 0
    if op == "sltiu":
        return 1 if u32(a) < u32(imm) else 0
    raise ValueError(op)


def gen_r(op):
    state = {"idx": 0}
    lines = header()
    for tid, (a, b) in enumerate(binary_tests(op), 2):
        lines += [f"test_{tid}:"]
        lines += asm_li(11, a)
        lines += filler(state, PRODUCER_PAD, "friendly: source register spacing")
        lines += asm_li(12, b)
        lines += filler(state, PRODUCER_PAD, "friendly: source register spacing")
        lines += [f"  {op} x14, x11, x12"]
        lines += check_result(tid, calc_r(op, a, b), state)
    lines += footer()
    return "\n".join(lines)


def gen_i(op):
    real_op = {"srl_ext": "srli", "sra_ext": "srai"}.get(op, op)
    state = {"idx": 0}
    lines = header()
    for tid, (a, imm) in enumerate(immediate_tests(op), 2):
        imm = imm & 31 if real_op in ("slli", "srli", "srai") else imm12(imm)
        lines += [f"test_{tid}:"]
        lines += asm_li(11, a)
        lines += filler(state, PRODUCER_PAD, "friendly: source register spacing")
        lines += [f"  {real_op} x14, x11, {imm}"]
        lines += check_result(tid, calc_i(op, a, imm), state)
    lines += footer()
    return "\n".join(lines)


def gen_lw():
    state = {"idx": 0}
    lines = header()
    values = [3, 8, 15, 31, 64, 127]
    for tid, val in enumerate(values, 2):
        off = (tid - 2) * 4
        lines += [f"test_{tid}:"]
        lines += asm_li(10, off)
        lines += filler(state, PRODUCER_PAD, "friendly: address spacing")
        lines += asm_li(11, val)
        lines += filler(state, PRODUCER_PAD, "friendly: store-data spacing")
        lines += [f"  sw x11, 0(x10)"]
        lines += filler(state, MEMORY_PAD, "friendly: memory write/read spacing")
        lines += [f"  lw x14, 0(x10)"]
        lines += check_result(tid, val, state)
    lines += footer()
    return "\n".join(lines)


def gen_sw():
    state = {"idx": 0}
    lines = header()
    values = [5, 12, 21, 42, 77, 99]
    for tid, val in enumerate(values, 2):
        off = 64 + (tid - 2) * 4
        lines += [f"test_{tid}:"]
        lines += asm_li(10, off)
        lines += filler(state, PRODUCER_PAD, "friendly: address spacing")
        lines += asm_li(11, val)
        lines += filler(state, PRODUCER_PAD, "friendly: store-data spacing")
        lines += [f"  sw x11, 0(x10)"]
        lines += filler(state, MEMORY_PAD, "friendly: memory write/read spacing")
        lines += [f"  lw x14, 0(x10)"]
        lines += check_result(tid, val, state)
    lines += footer()
    return "\n".join(lines)


def main():
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    r_ops = ["add", "sub", "and", "or", "xor", "sll", "srl", "sra", "slt", "sltu"]
    i_ops = ["addi", "andi", "ori", "xori", "slli", "srli", "srai", "slti", "sltiu", "srl_ext", "sra_ext"]
    for op in r_ops:
        (OUT_DIR / f"{op}.S").write_text(gen_r(op) + "\n", encoding="ascii")
    for op in i_ops:
        (OUT_DIR / f"{op}.S").write_text(gen_i(op) + "\n", encoding="ascii")
    (OUT_DIR / "lw.S").write_text(gen_lw() + "\n", encoding="ascii")
    (OUT_DIR / "sw.S").write_text(gen_sw() + "\n", encoding="ascii")
    print(f"Generated {len(list(OUT_DIR.glob('*.S')))} benchmarks in {OUT_DIR}")


if __name__ == "__main__":
    main()
