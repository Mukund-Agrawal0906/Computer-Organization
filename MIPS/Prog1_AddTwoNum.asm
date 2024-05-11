.data
num1:.word 14
num2:.word 15
sum:.word 0

.text
.globl main
main:

lw $t0,num1
lw $t1,num2

add $t2,$t1,$t0

sw $t2,sum

li $v0,1
move $a0,$t2
syscall

li $v0,10
syscall
