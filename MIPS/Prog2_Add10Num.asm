.data
num:.word 1, 23, 5, 53, 2, 4, 5, 2, 5, 6, 0

.text
.globl main

main:

la $t0,num
li $t1,0

loop:
lw $t2,0($t0)
lw $t3,4($t0)

add $t3,$t3,$t2
sw $t3,4($t0)

addi $t0,$t0,4
addi $t1,$t1,1

bne $t1,10,loop

sw $t0,4($t0)

li $v0,1
move $a0, $t3
syscall

li $v0,10
syscall


