# Q1. Write a MIPS assembly program that loads two 32-bit integers and Performs the
# following operations:
# (i)
# o Bitwise AND
# o Bitwise OR
# o Bitwise XOR
# o Bitwise NOR
# (ii) Stores the results in registers $t2, $t3, $t4, and $t5 respectively.
# (iii)Display all results in hexadecimal format.
# Instructions to be used: and, or, xor, nor, li, move, syscall

.data
num1:       .word   12345678
# store first 32-bit integer in memory

num2:       .word   87654321
# store second 32-bit integer in memory

msg_and:    .asciiz "\nBitwise AND result: "
# message to display AND result

msg_or:     .asciiz "\nBitwise OR  result: "
# message to display OR result

msg_xor:    .asciiz "\nBitwise XOR result: "
# message to display XOR result

msg_nor:    .asciiz "\nBitwise NOR result: "
# message to display NOR result


.text
.globl main

main:
    lw  $t0, num1
    # load value of num1 into register $t0

    lw  $t1, num2
    # load value of num2 into register $t1


    # -------- Bitwise Operations --------
    and $t2, $t0, $t1
    # $t2 = $t0 AND $t1 (bitwise AND)

    or  $t3, $t0, $t1
    # $t3 = $t0 OR $t1 (bitwise OR)

    xor $t4, $t0, $t1
    # $t4 = $t0 XOR $t1 (bitwise XOR)

    nor $t5, $t0, $t1
    # $t5 = NOT($t0 OR $t1) (bitwise NOR)


    # -------- Display AND Result --------
    li  $v0, 4
    # syscall 4 → print string

    la  $a0, msg_and
    # load address of AND message

    syscall
    # print message

    li  $v0, 34
    # syscall 34 → print integer in HEX format

    move $a0, $t2
    # move AND result into $a0

    syscall
    # print result in hexadecimal


    # -------- Display OR Result --------
    li  $v0, 4
    la  $a0, msg_or
    syscall
    # print OR message

    li  $v0, 34
    move $a0, $t3
    syscall
    # print OR result in HEX


    # -------- Display XOR Result --------
    li  $v0, 4
    la  $a0, msg_xor
    syscall
    # print XOR message

    li  $v0, 34
    move $a0, $t4
    syscall
    # print XOR result in HEX


    # -------- Display NOR Result --------
    li  $v0, 4
    la  $a0, msg_nor
    syscall
    # print NOR message

    li  $v0, 34
    move $a0, $t5
    syscall
    # print NOR result in HEX


    # -------- Exit Program --------
    li  $v0, 10
    # syscall 10 → terminate program

    syscall