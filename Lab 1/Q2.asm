# Q2.Write an assembly program to convert a temperature from Fahrenheit to Celsius (input
# and output have to be floating point values).
# Formula: Temperature in
# degrees Celsius = (Temperature in degrees Fahrenheit - 32) * 5 / 9.


.data   
inputtemp: .asciiz "Enter temperature in Fahrenheit : "   # message to ask user for Fahrenheit input
outputtemp: .asciiz "\nTemperature in Celsius : "       # message to display Celsius output
const32:   .float 32.0             # constant value 32.0 used in formula
const5:    .float 0.55555556        # constant value 5/9 (approx) used for conversion

.text

    li $v0, 4               # syscall code 4 → print string
    la $a0, inputtemp       # load address of input message into $a0
    syscall         # print "Enter temperature in Fahrenheit : "

    
    li $v0, 6       # syscall code 6 → read float value 
    # Note: syscall 6 reads a float value from user input and stores it in the $f0 register
    syscall       # user enters float, stored in $f0 register


    lwc1 $f2, const32    # load 32.0 into floating register $f2
    lwc1 $f3, const5      # load 5/9 value into $f3

    sub.s $f4, $f0, $f2     # $f4 = $f0 - 32 → (F - 32) 
    mul.s $f12, $f4, $f3    # $f12 = $f4 * (5/9) → final Celsius value

    li $v0, 4              # syscall code 4 → print string

    la $a0, outputtemp       # load output message
    syscall         # print "Temperature in Celsius : "

    li $v0, 2        # syscall code 2 → print float
    syscall         # print value stored in $f12 (Celsius result)

    li $v0, 10      # syscall code 10 → exit program
    syscall          # terminate program
    

