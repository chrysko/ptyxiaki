	.data
number:
	.word	1
	.word	10
	.word	1
	.word	2
	.word	3
	.word 	1
	.word 	1
	.word	1
	.word	2
	.word	3
	.word 	1
	.word 	1
	
	.text
	
	la $a0, number
	
	lw $t0, 0($a0)		#auto pou psaxnw
	lw $t1, 4($a0)		#to plithos twn stoixewn
	
	addi $a0, $a0, 4	#deixnei sth mnhmh
	add $a1, $zero, $zero #counter gia to plithos twn stoixeiwn
	add $s1, $zero, $zero #poses fores tha vrei ton arithmo
	and $t9, $zero, $zero
	
loop:	addi $a0, $a0, 4	#epomeni thesi
	beq $t1, $a1, end
	addi $a1, $a1, 1	#auxanei counter
	or $t9, $t9, $a1
	lw $t2, 0($a0)
	beq $t0, $t2, incr
	j loop
incr:	addi $s1, $s1, 1
	j loop
end:		
	sw $s1, 0($a0)
	li   $v0, 10
        syscall
