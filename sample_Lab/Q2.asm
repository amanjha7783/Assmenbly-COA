.data
  inputtemp: .asciiz "Enter the input value "
  outputtemp: .asciiz "output value is "
  const32: .float 32.0
  const5: .float 0.555556

.text
.globl main
main:

    li $v0, 4
    la $a0, inputtemp
    syscall

    li $v0, 6        # read float
    syscall          # value → $f0

    lwc1 $f1, const32
    lwc1 $f2, const5

    sub.s $f4, $f0, $f1
    mul.s $f5, $f4, $f2

    li $v0, 4
    la $a0, outputtemp
    syscall

    mov.s $f12, $f5
    li $v0, 2        # print float
    syscall

    li $v0, 10
    syscall
