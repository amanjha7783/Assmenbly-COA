.data
msg1:      .asciiz "Enter first number: "
msg2:      .asciiz "Enter second number: "
msg_res:   .asciiz "\nCount of even numbers: "

.text
.globl main

main:
    # -------- Input first number --------
    li $v0, 4
    la $a0, msg1
    syscall

    li $v0, 5
    syscall
    move $t0, $v0      # first number

    # -------- Input second number --------
    li $v0, 4
    la $a0, msg2
    syscall

    li $v0, 5
    syscall
    move $t1, $v0      # second number

    li $t2, 0          # counter = 0

loop:
    bgt $t0, $t1, end_loop   # if start > end → stop

    andi $t3, $t0, 1         # check even/odd
    bne $t3, $zero, skip     # if odd → skip

    addi $t2, $t2, 1         # counter++

skip:
    addi $t0, $t0, 1         # next number
    j loop

end_loop:
    # -------- Print Result --------
    li $v0, 4
    la $a0, msg_res
    syscall

    li $v0, 1
    move $a0, $t2
    syscall

    # -------- Exit --------
    li $v0, 10
    # syscallP