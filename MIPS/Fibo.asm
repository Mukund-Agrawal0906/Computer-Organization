.data
str1: .asciiz "The Fibonacci Series of "
str2: .asciiz " elements is "
str3: .asciiz " , "
.text
.globl main

main:

li $t0,0
li $t1,1

li $v0,4
la $a0,str1
syscall

li $v0,5
syscall

move $t2,$v0

li $v0,4
la $a0,str2
syscall

li $v0,1
move $a0,$t0
syscall

li $v0,4
la $a0,str3
syscall

li $v0,1
move $a0,$t1
syscall

sub $t2,$t2,2

jal Fibo

li $v0,10
syscall

Fibo:

li $t3,0

loop:

li $v0,4
la $a0,str3
syscall

add $t4,$t0,$t1

li $v0,1
move $a0,$t4
syscall

move $t0,$t1
move $t1,$t4
addi $t3,$t3,1
bne $t3,$t2,loop
jr $ra