# Q1. Write a MIPS assembly language program that performs the following:
# 1. In main:
# o Read an integer n from the user.
# o Pass n as an argument to a subprogram named factorial.
# 2. In the subprogram factorial:
# o Use the stack to save all required registers.
# o Compute the factorial of n using an iterative approach.
# o Return the result to main using $v0.
# 3. Back in main:
# o Print the factorial result.
# o Properly terminate the program.

.data   
number: .asciiz "Enter a number: "
result: .asciiz "Factorial is: "

.text
.globl main

main:
    # Print number
    li $v0, 4
    la $a0, number
    syscall

    # Read integer n
    li $v0, 5
    syscall
    move $a0, $v0        # pass n as argument to factorial

    # Call factorial subprogram
    jal factorial

    move $t0, $v0        # save result

    # Print result message
    li $v0, 4
    la $a0, result
    syscall

    # Print factorial value
    li $v0, 1
    move $a0, $t0
    syscall

    # Exit program
    li $v0, 10
    syscall


# ---------------- FACTORIAL SUBPROGRAM ----------------
factorial:
    # Create stack frame
    addi $sp, $sp, -12    # allocate space for 3 registers
    sw $ra, 8($sp)       # save return address
    sw $s0, 4($sp)       # save $s0
    sw $s1, 0($sp)       # save $s1

    move $s0, $a0        # s0 = n
    li $s1, 1            # s1 = result = 1

factorial_loop:
    blez $s0, factorial_done
    mul $s1, $s1, $s0   # result *= n
    addi $s0, $s0, -1   # n--
    j factorial_loop

factorial_done:
    move $v0, $s1       # return result in $v0

    # Restore registers
    lw $s1, 0($sp)
    lw $s0, 4($sp)
    lw $ra, 8($sp)
    addi $sp, $sp, 12

    jr $ra               # return to main
