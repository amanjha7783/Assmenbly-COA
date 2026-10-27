# Q2 second part 

.text
.globl square
.globl cube

# square subprogram
square:
    addi $sp, $sp, -4
    sw   $ra, 0($sp)

    mul  $v0, $a0, $a0

    lw   $ra, 0($sp)
    addi $sp, $sp, 4
    jr   $ra


# cube subprogram
cube:
    addi $sp, $sp, -4
    sw   $ra, 0($sp)

    mul  $t0, $a0, $a0
    mul  $v0, $t0, $a0

    lw   $ra, 0($sp)
    addi $sp, $sp, 4
    jr   $ra
