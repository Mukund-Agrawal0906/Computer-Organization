.data
msg1: .asciiz "Enter The String "
msg2: .asciiz "The String entered is : "
buf1: .space 32

.text
.globl main

main:

li $v0,4
la $a0,msg1
syscall

li $v0,8
la $a0,buf1
li $a1,64
syscall

li $v0,4
la $a0,msg2
syscall

li $v0,4
la $a0,buf1
syscall

la $t0,buf1
li $t1,0
move $t2, $t0

loop:

addi $t1,$t1,1
addi $t2,$t2,1
addi $t0,$t0,1
bne $t1,31,loop

loop1:

li $v0,11
move $a0,$t2
syscall

addi $t2,$t2,-1
addi $t1,$t1,-1
bne $t1,-1,loop1

li $v0,10
syscall
