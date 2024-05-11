.data
str: .asciiz "enter the number"
str1: .asciiz "number is armstrong"
str2: .asciiz "number is not armstrong"
.text
.globl main
main:

li $v0,4
la $a0,str
syscall

li $v0,5
syscall

move $t0,$v0
li $t1,10
move $t5,$t0


li $t4,0
 
loop:
rem $t2,$t0,$t1

div $t0,$t0,$t1
mul $t3,$t2,$t2
mul $t3,$t3,$t2
add $t4,$t4,$t3
bne $t0,$zero,loop

beq $t5,$t4,print1

li $v0,4
la $a0,str2
syscall
li $v0,10
syscall

print1:
li $v0,4
la $a0,str1
syscall

li $v0,10
syscall


