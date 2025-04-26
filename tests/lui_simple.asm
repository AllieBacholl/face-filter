    .section .text
    .globl _start

_start:
    lui x1, 0x12345

    lui x2, 0x54321

    add x3, x1, x2
