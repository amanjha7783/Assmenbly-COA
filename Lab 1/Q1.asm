.data
int1 : .asciiz "Enter first integer: "   # message to ask user for first number
int2 : .asciiz "Enter second integer: "  # message to ask user for second number
add_msg : .asciiz "\nAddition result: "  # message to display addition result
sub_msg : .asciiz "\nSubtraction result: " # message for subtraction result
mul_msg : .asciiz "\nMultiplication result: " # message for multiplication result
div_msg : .asciiz "\nDivision result: "  # message for division result

.text
main:
    li $v0, 4              # syscall code 4 → print string
    la $a0, int1           # load address of int1 message into $a0
    syscall                # execute → prints "Enter first integer: "

    li $v0, 5              # syscall code 5 → read integer
    syscall                # user enters number, stored in $v0

    move $s0, $v0          # store first input in $s0 (saved register)

    li $v0, 4              # print string again
    la $a0, int2           # load address of second message
    syscall                # prints "Enter second integer: "

    li $v0, 5              # syscall code 5 → read integer
    syscall                # read second number 

    move $s1, $v0          # store second input in $s1

    # -------- ADDITION --------
    add $t0, $s0, $s1      # $t0 = $s0 + $s1 (add two numbers)

    li $v0, 4              # print string
    la $a0, add_msg        # load addition message
    syscall                # display "Addition result: "

    li $v0, 1              # syscall code 1 → print integer
    move $a0, $t0          # move result to $a0
    syscall                # print addition result

    # -------- SUBTRACTION --------
    sub $t1, $s0, $s1      # $t1 = $s0 - $s1

    li $v0, 4              # print string
    la $a0, sub_msg        # load subtraction message
    syscall                # display message

    li $v0, 1              # print integer
    move $a0, $t1          # move subtraction result
    syscall                # print result

    # -------- MULTIPLICATION --------
    mul $t2, $s0, $s1      # $t2 = $s0 * $s1

    li $v0, 4              # print string
    la $a0, mul_msg        # load multiplication message
    syscall                # display message

    li $v0, 1              # print integer
    move $a0, $t2          # move multiplication result
    syscall                # print result

    # -------- DIVISION --------
    div $t3, $s0, $s1      # $t3 = $s0 / $s1 (quotient)

    li $v0, 4              # print string
    la $a0, div_msg        # load division message
    syscall                # display message

    li $v0, 1              # print integer
    move $a0, $t3          # move division result
    syscall                # print result