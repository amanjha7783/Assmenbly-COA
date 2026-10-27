.data
prompt: .asciiz "Enter a number: "
sqmsg:  .asciiz "\nSquare is: "
cumsg:  .asciiz "\nCube is: "

.text
.globl main

main:

    # Print input message
    li $v0, 4
    la $a0, prompt
    syscall

    # Read integer
    li $v0, 5
    syscall
    move $t0, $v0          # store input number

    # Call square function
    move $a0, $t0
    jal square
    move $t1, $v0          # save square result

    # Call cube function
    move $a0, $t0
    jal cube
    move $t2, $v0          # save cube result

    # Print square message
    li $v0, 4
    la $a0, sqmsg
    syscall

    # Print square value
    li $v0, 1
    move $a0, $t1
    syscall

    # Print cube message
    li $v0, 4
    la $a0, cumsg
    syscall

    # Print cube value
    li $v0, 1
    move $a0, $t2
    syscall

    # Exit program
    li $v0, 10
    syscall


# ---------- FUNCTIONS ----------

square:
    mul $v0, $a0, $a0      # return n*n in $v0
    jr $ra                 # return to main


cube:
    mul $t3, $a0, $a0      # t3 = n*n
    mul $v0, $t3, $a0      # v0 = n*n*n
    jr $ra                 # return to main
