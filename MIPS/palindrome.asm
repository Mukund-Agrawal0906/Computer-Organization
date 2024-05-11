.data
msg1: .asciiz "Enter The Number: "
msg2: .asciiz "String is Palindrome "
msg3: .asciiz "String is not Palindrome "

.text
.globl main

main:

li $v0,4
la $a0,msg1
syscall

li $v0,5
syscall

move $t0,$v0

li $t1,0
move $t2,$t0

jal Palindrome

li $v0,4
la $a0,msg2
syscall

j exit

Palindrome:

loop:

mul $t1,$t1,10
rem $t3,$t0,10
div $t0,$t0,10
add $t1,$t1,$t3
bne $t0,$zero,loop
bne $t2,$t1,np
jr $ra

np:

li $v0,4
la $a0,msg3
syscall

exit:

li $v0,10
syscall