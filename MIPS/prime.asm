.data
str: .asciiz "enter the number"
str1: .asciiz "number is prime"
str2: .asciiz "not prime"

.text
.globl main
main:

li $v0,4
la $a0,str
syscall

li $v0,5
syscall

move $t0,$v0
li $t1,2
move $t3,$t0

div $t3,$t3,$t1
mflo $t3                   #t3 is quotient


loop:

div $t4,$t0,$t1
mfhi $t2                   #t2 is remainder
beq $t2,$zero,print1
add $t1,1
bne $t3,$t1,loop

li $v0,4
la $a0,str1
syscall

li $v0,10
syscall


print1:
li $v0,4
la $a0,str2
syscall

li $v0,10
syscall
