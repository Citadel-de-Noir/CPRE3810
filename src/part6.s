.data
A: .word -1, 2, -3, 4, 5, 6, -7, -8, 9, -10
.space 216
B: .space 256
.text
.globl main
main:
lui x25, 0x10010
addi x25, x25, 0
addi x26, x25, 256
lw x1, 0(x25)
lw x2, 4(x25)
add x1, x1, x2
sw x1, 0(x26)
lw x2, 8(x25)
add x1, x1, x2
sw x1, 4(x26)
lw x2, 12(x25)
add x1, x1, x2
sw x1, 8(x26)
lw x2, 16(x25)
add x1, x1, x2
sw x1, 12(x26)
lw x2, 20(x25)
add x1, x1, x2
sw x1, 16(x26)
lw x2, 24(x25)
add x1, x1, x2
addi x27, x25, 512
sw x1, -4(x27)
# Stop here to inspect registers before adding an exit syscall.
