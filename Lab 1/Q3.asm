# Q3. Write an interactive program that inputs the coefficient of a quadratic equation,
# computes, and displays the roots of the quadratic equation. All input, computation, and
# output should be done using double-precision floating-point instructions and registers. The
# program should handle the case of complex roots and displays the results properly.

.data
msg_a:      .asciiz "Enter coefficient a: "     # prompt for a
msg_b:      .asciiz "Enter coefficient b: "     # prompt for b
msg_c:      .asciiz "Enter coefficient c: "     # prompt for c

msg_x1:     .asciiz "\nRoot 1 (x1): "           # label for first root
msg_x2:     .asciiz "\nRoot 2 (x2): "           # label for second root

msg_real:   .asciiz "\nRoots are Real:\n"       # message if roots are real
msg_complex:.asciiz "\nRoots are Complex:\n"    # message if roots are complex

plus_i:     .asciiz " + "                       # string for + in complex root
minus_i:    .asciiz " - "                       # string for - in complex root
str_i:      .asciiz "i"                         # imaginary unit i
newline:    .asciiz "\n"

const2:     .double 2.0                         # constant 2.0
const4:     .double 4.0                         # constant 4.0
const0:     .double 0.0                         # constant 0.0
 
.text
.globl main

main:
    li $v0, 4
    la $a0, msg_a
    syscall
    # print "Enter coefficient a"

    li $v0, 7
    syscall
    # read double → stored in $f0

    mov.d $f20, $f0
    # store a in $f20

    li $v0, 4
    la $a0, msg_b
    syscall
    # print "Enter coefficient b"

    li $v0, 7
    syscall
    # read double

    mov.d $f22, $f0
    # store b in $f22

    li $v0, 4
    la $a0, msg_c
    syscall
    # print "Enter coefficient c"

    li $v0, 7
    syscall
    # read double

    mov.d $f24, $f0
    # store c in $f24

    # -------- Load constants --------
    ldc1 $f2, const2      # load 2.0
    ldc1 $f4, const4      # load 4.0
    ldc1 $f6, const0      # load 0.0

    # -------- Compute 2a --------
    mul.d $f26, $f20, $f2   # f26 = 2 * a

    # -------- Compute -b --------
    sub.d $f28, $f6, $f22   # f28 = -b

    # -------- Compute b^2 --------
    mul.d $f8, $f22, $f22   # f8 = b * b

    # -------- Compute 4ac --------
    mul.d $f10, $f20, $f24  # f10 = a * c
    mul.d $f10, $f10, $f4   # f10 = 4 * a * c

    # -------- Compute discriminant --------
    sub.d $f30, $f8, $f10   # f30 = b^2 - 4ac

    # -------- Check if discriminant < 0 --------
    c.lt.d $f30, $f6        # if D < 0
    bc1t complex_roots      # branch if true

# ================= REAL ROOTS =================
real_roots:
    li $v0, 4
    la $a0, msg_real
    syscall
    # print "Roots are Real"

    sqrt.d $f0, $f30
    # f0 = sqrt(D)

    # -------- x1 = (-b + sqrt(D)) / 2a --------
    add.d $f12, $f28, $f0
    div.d $f12, $f12, $f26

    li $v0, 4
    la $a0, msg_x1
    syscall
    # print x1 label

    li $v0, 3
    syscall
    # print double (x1)

    # -------- x2 = (-b - sqrt(D)) / 2a --------
    sub.d $f12, $f28, $f0
    div.d $f12, $f12, $f26

    li $v0, 4
    la $a0, msg_x2
    syscall
    # print x2 label

    li $v0, 3
    syscall
    # print x2

    j exit
    # jump to exit

# ================= COMPLEX ROOTS =================
complex_roots:
    li $v0, 4
    la $a0, msg_complex
    syscall
    # print "Roots are Complex"

    div.d $f16, $f28, $f26
    # real part = -b / 2a

    abs.d $f30, $f30
    # take absolute value of discriminant

    sqrt.d $f0, $f30
    # sqrt(|D|)

    div.d $f18, $f0, $f26
    # imaginary part = sqrt(|D|)/2a

    # -------- x1 --------
    li $v0, 4
    la $a0, msg_x1
    syscall

    mov.d $f12, $f16
    li $v0, 3
    syscall
    # print real part

    li $v0, 4
    la $a0, plus_i
    syscall
    # print "+"

    mov.d $f12, $f18
    li $v0, 3
    syscall
    # print imaginary part

    li $v0, 4
    la $a0, str_i
    syscall
    # print "i"

    # -------- x2 --------
    li $v0, 4
    la $a0, msg_x2
    syscall

    mov.d $f12, $f16
    li $v0, 3
    syscall
    # print real part

    li $v0, 4
    la $a0, minus_i
    syscall
    # print "-"

    mov.d $f12, $f18
    li $v0, 3
    syscall
    # print imaginary part

    li $v0, 4
    la $a0, str_i
    syscall
    # print "i"

# ================= EXIT =================
exit:
    li $v0, 10
    syscall
    # terminate program