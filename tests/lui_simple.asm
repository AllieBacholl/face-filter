.section .text
.globl _start

_start:
    lui x5, 0x12345       # Load upper immediate into x5
    sw x5, 0(x0)          # Store x5 at address 0 (for checking)
    li a0, 10             # Exit syscall
    ecall