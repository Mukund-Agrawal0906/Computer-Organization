.data

ieee:.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
temp: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
msg1: .asciiz "Enter Number: "
zeroval: .float 0.0

.text
.globl main

main:

la $a0,msg1
li $v0,4
syscall

li $v0,6
syscall

la $t1,zeroval
mov.s $f2,$f0
l.s $f4, ($t1)
c.lt.s $f2,$f4   #0.0 < input
bc1f next

la $t0,ieee
li $t2,1
sw $t2, 0($t0)

next:

cvt.w.s $f5, $f1
mfc1 $t5, $f5
cvt.s.w $f6,$f5
sub.s $f7, $f2, $f6




#exit

li $v0,10
syscall