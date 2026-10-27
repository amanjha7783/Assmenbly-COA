# Q3. Write a MIPS program that Calls a procedure using jal and performs a simple arithmetic
# operation inside the procedure. Also returns the result to the main program using jr $ra.

.data
msg_res: .asciiz "The sum calculated in the procedure is: "

.text
.globl main

main:
    
    li  $a0, 10          # first number
    li  $a1, 5           # second number

    jal add_nums         # call procedure

    move $t0, $v0        # store returned result

    li  $v0, 4           # print string
    la  $a0, msg_res
    syscall

    li  $v0, 1           # print integer
    move $a0, $t0
    syscall

    li  $v0, 10          # exit
    syscall


# -------- PROCEDURE --------
add_nums:
    add $v0, $a0, $a1    # result = a0 + a1
    jr  $ra              # return to main