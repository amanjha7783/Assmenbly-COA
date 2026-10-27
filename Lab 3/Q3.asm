# Q3. The program should compute the following expression for a given integer
# N:
# Output = ((N×N)+10)÷2
# The computation must be performed using four subroutines, where each
# subroutine calls the next one (nested calls).

.data
prompt:     .asciiz "Enter N: "
resultMsg:  .asciiz "Output = "

.text
.globl main


main:
    li $v0, 4
    la $a0, prompt
    syscall

    li $v0, 5          # read N
    syscall
    move $a0, $v0

    jal square         # start subroutines

    move $t0, $v0

    li $v0, 4
    la $a0, resultMsg
    syscall

    li $v0, 1
    move $a0, $t0
    syscall

    li $v0, 10
    syscall

square:
    mul $a0, $a0, $a0      # N*N
    j addTen               # go to next



addTen:
    addi $a0, $a0, 10      # +10
    j divideTwo            # go to next


divideTwo:
    li $t1, 2
    div $a0, $t1
    mflo $a0               # result /2
    j returnResult         # go to next


returnResult:
    move $v0, $a0
    jr $ra                 # return to main

