.text
.globl main
main:
addi x1, x0, 1
addi x2, x0, 2
addi x3, x0, 3
addi x4, x0, 4
addi x5, x0, 5
addi x6, x0, 6
addi x7, x0, 7
addi x8, x0, 8
addi x9, x0, 9
addi x10, x0, 10
add x11, x1, x2
sub x12, x11, x3
add x13, x12, x4
sub x14, x13, x5
add x15, x14, x6
sub x16, x15, x7
add x17, x16, x8
sub x18, x17, x9
add x19, x18, x10
addi x20, x0, -35
add x21, x19, x20
lui x22, 0xFEED2
addi x22, x22, 80