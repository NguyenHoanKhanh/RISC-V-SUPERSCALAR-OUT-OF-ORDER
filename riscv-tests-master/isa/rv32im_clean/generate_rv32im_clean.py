#!/usr/bin/env python3
"""Generate RV32IM-clean ISA tests from riscv-tests macro tests."""

from __future__ import annotations

import re
import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
OUT = ROOT / "isa" / "rv32im_clean"
DATA_BASE = 0x4000

RV32UI = [
    "add", "addi", "and", "andi", "or", "ori", "xor", "xori",
    "sll", "slli", "srl", "srli", "sra", "srai",
    "slt", "slti", "sltu", "sltiu", "sub",
    "lb", "lbu", "lh", "lhu", "lw", "sb", "sh", "sw",
]
RV32UM = ["mul", "mulh", "mulhsu", "mulhu", "div", "divu", "rem", "remu"]


def git_show(path: str) -> str:
    return subprocess.check_output(
        ["git", "-c", f"safe.directory={ROOT.as_posix()}", "-C", str(ROOT), "show", f"HEAD:{path}"],
        text=True,
    )


def src_text(name: str, group: str) -> str:
    if group == "rv32um":
        return (ROOT / "isa" / "rv32um" / f"{name}.S").read_text()
    wrapper = (ROOT / "isa" / "rv32ui" / f"{name}.S").read_text()
    include = re.search(r'#include\s+"\.\./rv64ui/([^"]+)"', wrapper)
    if include:
        return git_show(f"isa/rv64ui/{include.group(1)}")
    return wrapper
    return git_show(f"isa/rv64ui/{name}.S")


def mask32(v: int) -> int:
    return v & 0xFFFFFFFF


def eval_expr(expr: str) -> int:
    expr = expr.strip()
    if not re.fullmatch(r"[0-9a-fA-FxX<>\-+ ()]+", expr):
        raise ValueError(expr)
    return mask32(eval(expr, {"__builtins__": None}, {}))


def sext_imm(v: int) -> int:
    v &= 0xFFF
    return v - 0x1000 if v & 0x800 else v


def args_of(line: str) -> tuple[str, list[str]] | None:
    m = re.search(r"\b(TEST_[A-Z0-9_]+)\s*\((.*)\)\s*;", line)
    if not m:
        return None
    args, cur, depth = [], "", 0
    for ch in m.group(2):
        if ch == "," and depth == 0:
            args.append(cur.strip())
            cur = ""
        else:
            cur += ch
            if ch == "(":
                depth += 1
            elif ch == ")":
                depth -= 1
    args.append(cur.strip())
    return m.group(1), args


def li32(rd: str, expr: str | int) -> list[str]:
    val = mask32(expr if isinstance(expr, int) else eval_expr(expr))
    nibbles = [(val >> shift) & 0xF for shift in range(28, -1, -4)]
    first = 0
    while first < 7 and nibbles[first] == 0:
        first += 1
    out = [f"  addi {rd}, x0, {nibbles[first]}"]
    for nib in nibbles[first + 1 :]:
        out.append(f"  slli {rd}, {rd}, 4")
        if nib:
            out.append(f"  ori {rd}, {rd}, {nib}")
    return out


def nops(n: str | int) -> list[str]:
    return ["  addi x0, x0, 0"] * int(n)


def check(testnum: str, reg: str, expected: str | int) -> list[str]:
    tid = int(testnum.strip())
    out = [f"  # check test {tid}"]
    out += li32("x7", expected)
    out.append(f"  bne {reg}, x7, fail_{tid}")
    return out


def rr(inst: str, result: str, val1: str, val2: str, dest="x14", src1="x11", src2="x12") -> list[str]:
    out = li32(src1, val1)
    if src2 != src1:
        out += li32(src2, val2)
    out.append(f"  {inst} {dest}, {src1}, {src2}")
    return out


def imm(inst: str, result: str, val1: str, imm_expr: str, dest="x14", src="x13") -> list[str]:
    out = li32(src, val1)
    out.append(f"  {inst} {dest}, {src}, {sext_imm(eval_expr(imm_expr))}")
    return out


def label_offsets(text: str) -> dict[str, int]:
    labels, off = {}, 0
    in_data = False
    for raw in text.splitlines():
        line = raw.split("#", 1)[0].strip()
        if "RVTEST_DATA_BEGIN" in line:
            in_data = True
        if not in_data:
            continue
        m = re.match(r"([A-Za-z_][\w]*):(?:\s*\.word\s+(.+))?", line)
        if m:
            labels[m.group(1)] = off
            if m.group(2):
                off += 4
            continue
        m = re.match(r"\.word\s+(.+)", line)
        if m:
            off += 4
    return labels


def data_words(text: str) -> list[int]:
    words, in_data = [], False
    for raw in text.splitlines():
        line = raw.split("#", 1)[0].strip()
        if "RVTEST_DATA_BEGIN" in line:
            in_data = True
        elif "RVTEST_DATA_END" in line:
            in_data = False
        if not in_data:
            continue
        m = re.search(r"\.word\s+(.+)", line)
        if m:
            words.append(eval_expr(m.group(1)))
    return words


def base_load(labels: dict[str, int], base: str, rd="x2") -> list[str]:
    return li32(rd, DATA_BASE + labels[base])


def expand(macro: str, a: list[str], labels: dict[str, int]) -> list[str]:
    out: list[str] = []
    if macro == "TEST_SRL":
        t, v, sh = a
        res = mask32(eval_expr(v)) >> int(sh)
        out += rr("srl", str(res), v, sh)
        out += check(t, "x14", res)
    elif macro == "TEST_SRLI":
        t, v, sh = a
        res = mask32(eval_expr(v)) >> int(sh)
        out += imm("srli", str(res), v, sh)
        out += check(t, "x14", res)
    elif macro == "TEST_RR_OP":
        t, inst, res, v1, v2 = a
        out += rr(inst, res, v1, v2)
        out += check(t, "x14", res)
    elif macro == "TEST_RR_SRC1_EQ_DEST":
        t, inst, res, v1, v2 = a
        out += rr(inst, res, v1, v2, "x11", "x11", "x12")
        out += check(t, "x11", res)
    elif macro == "TEST_RR_SRC2_EQ_DEST":
        t, inst, res, v1, v2 = a
        out += rr(inst, res, v1, v2, "x12", "x11", "x12")
        out += check(t, "x12", res)
    elif macro == "TEST_RR_SRC12_EQ_DEST":
        t, inst, res, v1 = a
        out += rr(inst, res, v1, v1, "x11", "x11", "x11")
        out += check(t, "x11", res)
    elif macro == "TEST_RR_DEST_BYPASS":
        t, n, inst, res, v1, v2 = a
        out += rr(inst, res, v1, v2, "x14", "x1", "x2") + nops(n) + ["  addi x6, x14, 0"]
        out += check(t, "x6", res)
    elif macro in ("TEST_RR_SRC12_BYPASS", "TEST_RR_SRC21_BYPASS"):
        t, n1, n2, inst, res, v1, v2 = a
        if macro == "TEST_RR_SRC12_BYPASS":
            out += li32("x1", v1) + nops(n1) + li32("x2", v2) + nops(n2)
        else:
            out += li32("x2", v2) + nops(n1) + li32("x1", v1) + nops(n2)
        out += [f"  {inst} x14, x1, x2"] + check(t, "x14", res)
    elif macro == "TEST_RR_ZEROSRC1":
        t, inst, res, v = a
        out += li32("x1", v) + [f"  {inst} x2, x0, x1"] + check(t, "x2", res)
    elif macro == "TEST_RR_ZEROSRC2":
        t, inst, res, v = a
        out += li32("x1", v) + [f"  {inst} x2, x1, x0"] + check(t, "x2", res)
    elif macro == "TEST_RR_ZEROSRC12":
        t, inst, res = a
        out += [f"  {inst} x1, x0, x0"] + check(t, "x1", res)
    elif macro == "TEST_RR_ZERODEST":
        t, inst, v1, v2 = a
        out += rr(inst, "0", v1, v2, "x0", "x1", "x2") + check(t, "x0", 0)
    elif macro == "TEST_IMM_OP":
        t, inst, res, v1, im = a
        out += imm(inst, res, v1, im) + check(t, "x14", res)
    elif macro == "TEST_IMM_SRC1_EQ_DEST":
        t, inst, res, v1, im = a
        out += imm(inst, res, v1, im, "x11", "x11") + check(t, "x11", res)
    elif macro == "TEST_IMM_DEST_BYPASS":
        t, n, inst, res, v1, im = a
        out += imm(inst, res, v1, im, "x14", "x1") + nops(n) + ["  addi x6, x14, 0"]
        out += check(t, "x6", res)
    elif macro == "TEST_IMM_SRC1_BYPASS":
        t, n, inst, res, v1, im = a
        out += li32("x1", v1) + nops(n) + [f"  {inst} x14, x1, {sext_imm(eval_expr(im))}"]
        out += check(t, "x14", res)
    elif macro == "TEST_IMM_ZEROSRC1":
        t, inst, res, im = a
        out += [f"  {inst} x1, x0, {sext_imm(eval_expr(im))}"] + check(t, "x1", res)
    elif macro == "TEST_IMM_ZERODEST":
        t, inst, v1, im = a
        out += li32("x1", v1) + [f"  {inst} x0, x1, {sext_imm(eval_expr(im))}"] + check(t, "x0", 0)
    elif macro in ("TEST_LD_OP", "TEST_LD_DEST_BYPASS", "TEST_LD_SRC1_BYPASS"):
        if macro == "TEST_LD_OP":
            t, inst, res, off, base = a
            out += base_load(labels, base, "x2") + [f"  {inst} x14, {int(off)}(x2)"]
            out += check(t, "x14", res)
        else:
            t, n, inst, res, off, base = a
            out += base_load(labels, base, "x13")
            if macro == "TEST_LD_SRC1_BYPASS":
                out += nops(n)
            out += [f"  {inst} x14, {int(off)}(x13)"]
            if macro == "TEST_LD_DEST_BYPASS":
                out += nops(n) + ["  addi x6, x14, 0"]
                out += check(t, "x6", res)
            else:
                out += check(t, "x14", res)
    elif macro in ("TEST_ST_OP", "TEST_ST_SRC12_BYPASS", "TEST_ST_SRC21_BYPASS"):
        if macro == "TEST_ST_OP":
            t, load, store, res, off, base = a
            out += base_load(labels, base, "x2") + li32("x1", res)
            out += [f"  {store} x1, {int(off)}(x2)", f"  {load} x14, {int(off)}(x2)"]
            out += check(t, "x14", res)
        else:
            t, n1, n2, load, store, res, off, base = a
            if macro == "TEST_ST_SRC12_BYPASS":
                out += li32("x13", res) + nops(n1) + base_load(labels, base, "x12") + nops(n2)
                out += [f"  {store} x13, {int(off)}(x12)", f"  {load} x14, {int(off)}(x12)"]
            else:
                out += base_load(labels, base, "x2") + nops(n1) + li32("x1", res) + nops(n2)
                out += [f"  {store} x1, {int(off)}(x2)", f"  {load} x14, {int(off)}(x2)"]
            out += check(t, "x14", res)
    return out


def generate_one(name: str, group: str) -> None:
    text = src_text(name, group)
    labels = label_offsets(text)
    words = data_words(text)
    body = []
    skipped = []
    fail_ids = []
    for raw in text.splitlines():
        parsed = args_of(raw)
        if not parsed:
            continue
        macro, args = parsed
        lines = expand(macro, args, labels)
        if lines:
            tid = int(args[0].strip())
            fail_ids.append(tid)
            body += [f"test_{tid}:"] + lines + [""]
        elif macro != "TEST_PASSFAIL":
            skipped.append(raw.strip())

    out = [
        "# Auto-generated RV32IM-clean benchmark.",
        f"# Source: {group}/{name}.S",
        "# Scoreboard: x31 = 1 pass / -1 fail, x30 = failing test id.",
        "# RV32IM performance window: count retired instructions and cycles from",
        "# benchmark_start/rv32im_perf_begin through benchmark_end/rv32im_perf_end.",
        "# IPC is measured externally as commit_count / cycle_count.",
    ]
    if skipped:
        out += ["# Skipped custom framework forms:"] + [f"#   {s.replace('TEST_', 'SKIPPED_')}" for s in skipped]
    out += [
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
        "  addi x30, x0, 0",
        "benchmark_start:",
        "rv32im_perf_begin:",
        "",
    ]
    out += body
    out += [
        "benchmark_end:",
        "rv32im_perf_end:",
        "pass:",
        "rv32im_scoreboard_finalize:",
        "  addi x31, x0, 1",
        "pass_loop:",
        "  beq x0, x0, pass_loop",
        "",
    ]
    for tid in fail_ids:
        out += [
            f"fail_{tid}:",
            f"  addi x30, x0, {tid}",
            "  addi x31, x0, -1",
            f"fail_loop_{tid}:",
            f"  beq x0, x0, fail_loop_{tid}",
            "",
        ]
    if words:
        out += [f"  .org 0x{DATA_BASE:x}", "tdat:"]
        for w in words:
            out.append(f"  .word 0x{w:08x}")
    (OUT / f"{name}.S").write_text("\n".join(out) + "\n")


def main() -> None:
    OUT.mkdir(exist_ok=True)
    for name in RV32UI:
        generate_one(name, "rv32ui")
    for name in RV32UM:
        generate_one(name, "rv32um")
    tests = RV32UI + RV32UM
    (OUT / "Makefrag").write_text(
        "# Makefrag for RV32IM clean tests\n"
        "rv32im_clean_sc_tests = \\\n\t"
        + " \\\n\t".join(tests)
        + " \\\n\n"
        "rv32im_clean_p_tests = $(addprefix rv32im_clean-p-, $(rv32im_clean_sc_tests))\n"
        "rv32im_clean_v_tests = $(addprefix rv32im_clean-v-, $(rv32im_clean_sc_tests))\n"
    )


if __name__ == "__main__":
    main()
