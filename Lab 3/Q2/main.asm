#Q2. Create a utility file utils.asm that contains the following subprograms:
#1. square – returns the square of a number
#2. cube – returns the cube of a number
#Write a main.asm program that:
# Reads an integer n
# Calls both square and cube
# Prints both results
#Note:-
# Use stack to save $ra in both utility subprograms
# Do not redefine any utility subprogram in main.asm

.data
prompt: .asciiz "Enter a number: "
sqmsg:  .asciiz "\nSquare is: "
cumsg:  .asciiz "\nCube is: "

.text
.globl main

main:
    # Read number
    li  $v0, 4
    la  $a0, prompt
    syscall

    li  $v0, 5
    syscall
    move $t0, $v0          # store n

    # Call square(n)
    move $a0, $t0
    jal  square
    move $t1, $v0          # store square

    # Call cube(n)
    move $a0, $t0
    jal  cube
    move $t2, $v0          # store cube

    # Print square
    li  $v0, 4
    la  $a0, sqmsg
    syscall

    li  $v0, 1
    move $a0, $t1
    syscall

    # Print cube
    li  $v0, 4
    la  $a0, cumsg
    syscall

    li  $v0, 1
    move $a0, $t2
    syscall

    # Exit
    li  $v0, 10
    syscall
