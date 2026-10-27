# Q3. Write an interactive program that inputs the coefficient of a quadratic equation,
# computes, and displays the roots of the quadratic equation. All input, computation, and
# output should be done using double-precision floating-point instructions and registers. The
# program should handle the case of complex roots and displays the results properly.

.data                                                # Data Segment
    msg_a:      .asciiz "Enter coefficient a: "      # Prompt for coefficient a
    msg_b:      .asciiz "Enter coefficient b: "     #  Prompt for coefficient b
    msg_c:      .asciiz "Enter coefficient c: "     #  Prompt for coefficient c
    msg_x1:     .asciiz "\nRoot 1 (x1): "           # Message for root 1
    msg_x2:     .asciiz "\nRoot 2 (x2): "           # Message for root 2
    msg_real:   .asciiz "\nRoots are Real:\n"       # Message for real roots
    msg_complex:.asciiz "\nRoots are Complex:\n"    # Message for complex roots
    plus_i:     .asciiz " + "                   # String for complex part
    minus_i:    .asciiz " - "                   # String for complex part
    str_i:      .asciiz "i"                     # String for imaginary unit
    newline:    .asciiz "\n"                    # Newline character

    const2:     .double 2.0             # Constant 2.0
    const4:     .double 4.0             # Constant 4.0
    const0:     .double 0.0             # Constant 0.0
 
.text                                   # Code Segment
.globl main                             # Main Label

main:                           # Main Program Entry Point
   
    li $v0, 4                   # Print String syscall
    la $a0, msg_a               # Load address of msg_a
    syscall                     # Make syscall
    
    li $v0, 7               # Read Double syscall
    syscall                 # Make syscall
    mov.d $f20, $f0         # Store coefficient a in $f20
    li $v0, 4               # Print String syscall
    la $a0, msg_b           # Load address of msg_b
    syscall                 # Make syscall
    
    li $v0, 7           # Read Double syscall
    syscall             # Make syscall
    mov.d $f22, $f0     # Store coefficient b in $f22
    li $v0, 4           # Print String syscall
    la $a0, msg_c       # Load address of msg_c
    syscall             # Make syscall
    
    li $v0, 7               # Read Double syscall
    syscall                 # Make syscall
    mov.d $f24, $f0         # Store coefficient c in $f24
    
    ldc1 $f2, const2        # Load constant 2.0
    ldc1 $f4, const4        # Load constant 4.0
    ldc1 $f6, const0        # Load constant 0.0

    mul.d $f26, $f20, $f2       # Calculate 2a and store in $f26
    sub.d $f28, $f6, $f22       # Calculate -b and store in $f28
    mul.d $f8, $f22, $f22       # Calculate b^2 and store in $f8
    mul.d $f10, $f20, $f24      # Calculate ac and store in $f10
    mul.d $f10, $f10, $f4       # Calculate 4ac and store in $f10
    sub.d $f30, $f8, $f10       # Calculate discriminant (b^2 - 4ac) and store in $f30

    
    c.lt.d $f30, $f6        # Compare discriminant with 0
    bc1t complex_roots      # If discriminant < 0, go to complex_roots

    
    real_roots:             # Label for real roots
        li $v0, 4           # Print String syscall
        la $a0, msg_real    # Load address of msg_real
        syscall             # Make syscall

        sqrt.d $f0, $f30            # Calculate sqrt(discriminant) and store in $f0
        
        add.d $f12, $f28, $f0       # Calculate -b + sqrt(discriminant)
        div.d $f12, $f12, $f26      # Calculate root 1
        
        li $v0, 4               # Print String syscall
        la $a0, msg_x1          # Load address of msg_x1
        syscall                 # Make syscall
        li $v0, 3               # Print Double syscall
        syscall                 # Make syscall

        sub.d $f12, $f28, $f0       # Calculate -b - sqrt(discriminant)
        div.d $f12, $f12, $f26      # Calculate root 2

        li $v0, 4               # Print String syscall  
        la $a0, msg_x2          # Load address of msg_x2
        syscall                 # Make syscall
        li $v0, 3               # Print Double syscall
        syscall                 # Make syscall
        
        j exit          # Jump to exit

    
    complex_roots:                  # Label for complex roots                   
        li $v0, 4                   # Print String syscall 
        la $a0, msg_complex         # Load address of msg_complex
        syscall

       
        div.d $f16, $f28, $f26      #  Calculate real part: -b / (2a)

        
        abs.d $f30, $f30        # Take absolute value of discriminant`
        sqrt.d $f0, $f30        # Calculate sqrt(|discriminant|)
        div.d $f18, $f0, $f26    # Calculate imaginary part: sqrt(-discriminant) / (2a)
        li $v0, 4               # Print String syscall
        la $a0, msg_x1          # Load address of msg_x1
        syscall                 # Make syscall

        mov.d $f12, $f16     # Move real part to $f12
        li $v0, 3            # Print Double
        syscall              # Make syscall

        li $v0, 4               # Print String syscall                   
        la $a0, plus_i          # Load address of plus_i
        syscall

        mov.d $f12, $f18    # Move imaginary part to $f12   
        li $v0, 3           # Print Double                         
        syscall

        li $v0, 4           # Print String syscall  
        la $a0, str_i       # Load address of str_i                                
        syscall

        li $v0, 4           # Print String syscall 
        la $a0, msg_x2      # Load address of msg_x2            
        syscall

        mov.d $f12, $f16    # Move real part to $f12
        li $v0, 3           # Print Double
        syscall

        li $v0, 4         # Print String syscall
        la $a0, minus_i   # Load address of minus_i
        syscall

        mov.d $f12, $f18    # Move imaginary part to $f12
        li $v0, 3           # Print Double
        syscall

        li $v0, 4       #  Print String syscall
        la $a0, str_i   # Load address of str_i
        syscall

    
    exit:                   # Exit Program
        li $v0, 10          # Exit syscall
        syscall