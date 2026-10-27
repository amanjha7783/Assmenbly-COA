
# Q2. Write a MIPS program that takes a number N = 25 stored in a register.
# 1. Performs:
# o Logical left shift by 2 bits
# o Logical right shift by 1 bit
# 2. Prints the original number and the shifted results.
# Instructions to be used: sll, srl

.data
    msg_orig:   .asciiz "Original Number: "     # string message to display original number
    msg_sll:    .asciiz "\nLeft Shift (<< 2): " # message for left shift result
    msg_srl:    .asciiz "\nRight Shift (>> 1): " # message for right shift result

.text
.globl main                                     # makes main visible as program entry point

main:
    
    li  $t0, 25          # load immediate value 25 into register $t0 (original number)
             
    li  $v0, 4           # syscall 4 → print string
    la  $a0, msg_orig    # load address of original message into $a0
    syscall              # print "Original Number

    li  $v0, 1           # syscall 1 → print integer
    move $a0, $t0        # move original number into argument register $a0
    syscall              # print value stored in $t0

    
    
    sll $t1, $t0, 2      # shift left logical: $t0 << 2 (multiply by 4)
    li  $v0, 4           # syscall 4 → print string
    la  $a0, msg_sll     # load address of left shift message
    syscall              # print left shift message

    li  $v0, 1           # syscall 1 → print integer
    move $a0, $t1        # move left shift result into $a0
    syscall              # print shifted value

    
    srl $t2, $t0, 1      # shift right logical: $t0 >> 1 (divide by 2)

    li  $v0, 4           # syscall 4 → print string
    la  $a0, msg_srl     # load address of right shift message
    syscall              # print right shift message

    li  $v0, 1           # syscall 1 → print integer
    move $a0, $t2        # move right shift result into $a0
    syscall              # print shifted value

  
    li  $v0, 10          # syscall 10 → exit program
    syscall              # terminate execution
