.data
msg_input:  .asciiz "Enter a number: "
msg_res:    .asciiz "\nResult: "

.text
.globl main

main:
    # -------- Input --------
    li $v0, 4
    la $a0, msg_input
    syscall

    li $v0, 5
    syscall
    move $t0, $v0      # store input

    # -------- Check Even/Odd --------
    andi $t1, $t0, 1   # check LSB

    beq $t1, $zero, call_even
    # if even → call even function

    jal odd_func
    # call odd function
    j print_result

call_even:
    jal even_func
    # call even function

# -------- Print Result --------
print_result:
    move $t2, $v0      # get result from function

    li $v0, 4
    la $a0, msg_res
    syscall

    li $v0, 1
    move $a0, $t2
    syscall

    li $v0, 10
    syscall


# -------- EVEN FUNCTION --------
even_func:
    mul $v0, $t0, $t0   # square → return in $v0
    jr $ra              # return

# -------- ODD FUNCTION --------
odd_func:
    mul $v0, $t0, $t0
    mul $v0, $v0, $t0   # cube → return in $v0
    jr $ra              # return