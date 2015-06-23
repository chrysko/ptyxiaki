	.data
number:
	.word	10
	.word	6
	.word	2
	.word	30
	.word 	15
	.word 	1
	.word	1
	.word	2
	.word	3
	.word 	13
	.word 	1
	
	.text
	
	la $a0, number
	
	lw $t0, 0($a0)		#to plithos stoixeiwn
	
	addi $a0, $a0, 4	#deixnei sth mnhmh (i )
	add $t1, $zero, $zero

check1:	
	slt $t9, $t1, $t0
	addi $t8, $zero, 1
	beq $t9,$t8, loop1
	j end
loop1:
	lw $s0, 0($a0)		#to trexon stoixeio
	addi $a1, $a0, 4	#to epomeno stoixeio
	addi $t2, $t1, 1	#counter gia to epomeno
	add $t4, $a0, $zero
check2: 			#elegxos deuterou for
	slt $t9, $t2, $t0
	addi $t8, $zero,1
	beq $t9, $t8, loop2
	j end2
loop2:
	lw $s1, 0($a1)
	slt $t9, $s1, $s0
	addi $t8, $zero,1
	beq $t9, $t8, swap
	j notswap
swap:
	add $s2, $s1, $zero
	add $s1, $s0, $zero
	add $s0, $s2, $zero
	add $t4, $a1, $zero
notswap:
	addi $a1, $a1, 4
	addi $t2, $t2, 1
	j check2
end2:
	lw $s5, 0($a0)
	sw $s0, 0($a0)
	sw $s5, 0($t4)
	addi $a0, $a0, 4
	addi $t1, $t1, 1
	j check1
end:
	
	li   $v0, 10
        syscall
