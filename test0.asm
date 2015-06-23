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
	addi $a0, $a0, 4
	addi $t1, $t1, 1
	j check1
end:
	
	li   $v0, 10
        syscall
