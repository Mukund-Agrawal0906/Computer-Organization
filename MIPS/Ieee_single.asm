.data
prompt: .asciiz "Enter a floating-point number: "
result: .asciiz "IEEE 754 representation in hexadecimal: "

.text
.globl main
main:
    # Print prompt
    li $v0, 4
    la $a0, prompt
    syscall
    
    # Read input float
    li $v0, 6
    syscall
    mov.s $f12, $f0   # Move input to $f12
    
    # Convert to IEEE 754 single precision
    mfc1 $t0, $f12     # Move the float to $t0
    srl $t1, $t0, 31   # Shift right $t0 by 31 bits, result in $t1
    sll $t2, $t1, 31   # Shift left $t1 by 31 bits, result in $t2
    sll $t3, $t0, 1    # Shift left $t0 by 1 bit, result in $t3
    andi $t4, $t3, 0x80000000   # Bitwise AND $t3 with 0x80000000, result in $t4
    beq $t4, $zero, normalize   # If $t4 is zero, branch to normalize
    
    # Handle the case of a negative number
    srl $t5, $t3, 24   # Shift right $t3 by 24 bits, result in $t5
    addi $t6, $t5, 126  # Add $t5 to 126, result in $t6
    sll $t7, $t6, 23   # Shift left $t6 by 23 bits, result in $t7
    or $t8, $t2, $t7   # Bitwise OR $t2 with $t7, result in $t8
    j end
    
normalize:
    # Handle the case of a positive number
    slt $t9, $t0, 0    # Set $t9 to 1 if $t0 is less than zero, else set it to 0
    beq $t9, $zero, normalize_positive
    
    # Handle the case of a negative number
    sll $t5, $t0, 1    # Shift left $t0 by 1 bit, result in $t5
    sltu $t6, $zero, $t5    # Set $t6 to 1 if $zero is less than $t5, else set it to 0
    beq $t6, $zero, normalize_negative
    
normalize_positive:
    # Normalize the positive number
    sltu $t1, $zero, $t0   # Set $t1 to 1 if $zero is less than $t0, else set it to 0
    beq $t1, $zero, denormalized   # If $t1 is zero, branch to denormalized
    
    # Normalized case
    jal calculate_exp
    move $t7, $v0   # Move the result of calculate_exp to $t7
    sll $t2, $t0, 9   # Shift left $t0 by 9 bits, result in $t2
    addu $t2, $t2, $t7   # Add $t2 to $t7, result in $t2
    j end
    
normalize_negative:
    # Normalize the negative number
    jal calculate_exp
    move $t7, $v0   # Move the result of calculate_exp to $t7
    sll $t2, $t0, 9   # Shift left $t0 by 9 bits, result in $t2
    addu $t2, $t2, $t7   # Add $t2 to $t7, result in $t2
    j end

denormalized:
    # Denormalized case
    sll $t5, $t0, 1    # Shift left $t0 by 1 bit, result in $t5
    srl $t6, $t5, 24   # Shift right $t5 by 24 bits, result in $t6
    sub $t7, $t6, 126  # Subtract $t6 from 126, result in $t7
    sll $t8, $t7, 23   # Shift left $t7 by 23 bits, result in $t8
    srl $t9, $t5, 2    # Shift right $t5 by 2 bits, result in $t9
    or $t2, $t8, $t9   # Bitwise OR $t8 with $t9, result in $t2
    
end:
    # Print result
    li $v0, 4
    la $a0, result
    syscall
    
    li $v0, 34   # Print floating-point number in hexadecimal format
    mov.s $f12, $f0   # Move the input to $f12
    syscall
    
    # Exit program
    li $v0, 10
    syscall

calculate_exp:
    # Calculate the exponent
    srl $t3, $t0, 23   # Shift right $t0 by 23 bits, result in $t3
    subu $t4, $t3, 127   # Subtract 127 from $t3, result in $t4
    move $v0, $t4   # Move the result to $v0
    jr $ra