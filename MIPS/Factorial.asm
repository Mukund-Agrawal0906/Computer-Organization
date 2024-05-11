.data
str: .asciiz "The Factorial of the number "
str1: .asciiz " is "
.text
.globl main

main:

li $v0,4
la $a0, str
syscall

li $v0,5
syscall

move $t0,$v0

li $v0,4
la $a0, str1
syscall

li $t1,1
move $t2,$t0

loop:

mul $t0,$t1,$t0
addi $t1,$t1,1
bne $t1,$t2,loop

li $v0,1
move $a0,$t0
syscall

li $v0,10
syscall