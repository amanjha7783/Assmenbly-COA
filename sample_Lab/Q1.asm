.data 
  int1: .asciiz "Enter the first number "
  int2: .asciiz "Enter the second number "
  add_msg: .asciiz "\nAdd two number "
  sub_msg: .asciiz "\nsubstract two number "
    

.text 
  main:

    li $v0, 4
    la $a0, int1
    syscall

    li $v0, 5

    syscall

    move $s0 , $v0

    li $v0, 4
    la $a0, int2
    syscall

    li $v0, 5
    syscall

    move $s1 , $v0

    add $t0 , $s0, $s1
    li $v0, 4
    la $a0, add_msg

    syscall

    move $a0 , $t0

    li $v0, 1      # print integer
    syscall

    sub $t1 , $s0, $s1
    li $v0 , 4
    la $a0 , sub_msg

    syscall

    move $a0 , $t1

    li $v0 , 1
    syscall
    
    li $v0 ,10
    syscall