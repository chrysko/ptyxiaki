	.data
number:
	.word	70
	.word	3
	
	.text
	
	la $a0, number
	lw $s0, 0($a0)	# o arithmos
	lw $s1, 4($a0)	# o diaireths
	
	addi $t0, $zero, 0 # o metritis
	
loop:
	slt $t2, $s1, $s0
	beq $t2, $zero, end
	sub $s0, $s0, $s1
	addi $t0, $t0, 1
	j loop
end:
	beq $s1, $s0, incr
	j save
incr:	
	addi $t0, $t0,1
	sub $s0, $s0, $s1
save:	
	sw $s0, 12($a0)
	sw $t0, 8($a0)
	
	li   $v0, 10
        syscall
