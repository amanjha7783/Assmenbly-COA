.data   
number: .asciiz "Enter a number: "
result: .asciiz "Factorial is: "

.text
.globl main

# ---------------- MAIN PROGRAM ----------------
main:

    # Print input message
    li $v0, 4
    la $a0, number
    syscall

    # Read integer n
    li $v0, 5
    syscall
    move $a0, $v0        # pass n as argument to function

    # Call factorial function
    jal factorial

    move $t0, $v0        # store returned result

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


# ---------------- FACTORIAL FUNCTION ----------------
factorial:

    move $t0, $a0        # t0 = n
    li   $t1, 1          # t1 = result = 1

loop:
    blez $t0, done       # if n <= 0 → finish
    mul  $t1, $t1, $t0   # result = result * n
    addi $t0, $t0, -1    # n--
    j loop

done:
    move $v0, $t1        # return result in $v0
    jr $ra               # return to main
