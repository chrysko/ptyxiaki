	.data
number:
	.word	4
	.word 	1
	.word	2
	.word	4
	.word 	6
number2:
	.word	5
	.word	1
	.word	1
	.word	2
	.word	10
	.word	14
	
	.text
	
	la $a0, number	#first array
	la $a1, number2	#seconf array
	
	
	lw $s0, 0($a0)	#s0 first array size
	lw $s1, 0($a1)	#second array size
	#vazw ston a2 thn dieuthinsi tou deuteroun pinaka kai phgainw na ton ferw na deixnei sto telos
	#ekei tha valw tis sygxwneumenes times
	addi $a2, $zero, 4
initloop:
	beq $s1, $zero, initend
	addi $a2, $a2, 4
	subi $s1, $s1, 1
	j initloop
initend:
	add $a2, $a2, $a1
	lw $s1, 0($a1)

	#ta t0, t1, t2 exoun tous counters
	add $t0, $t0, $zero
	add $t1, $t1, $zero
	add $t2, $t2, $zero
	
	#prwxwraw mia thesi mprosta
	addi $a0, $a0, 4
	addi $a1, $a1, 4
loop:	
	beq $t0, $s0, end
	beq $t1, $s1, end
	lw $t8, 0($a0)
	addi $t6, $zero,1
	lw $t9, 0($a1)
	
	slt $t7, $t8, $t9
	beq $t7, $t6, case1
	j case2
case1:	
	sw $t8, 0($a2)
	addi $a0, $a0,4
	addi $t0, $t0, 1
	j step
case2:
	sw $t9, 0($a2)
	addi $a1, $a1,4
	addi $t1, $t1, 1
step:
	# o t2 auxanei kathe fora
	addi $t2, $t2,1
	addi $a2, $a2,4
	j loop
	
end:


loopfirst:
	beq $t0, $s0, endfirst
	lw $t8, 0($a0)
	sw $t8, 0($a2)
	addi $a2,$a2,4
	addi $a0, $a0, 4
	addi $t0, $t0, 1
	j loopfirst
endfirst:


loopsecond:
	beq $t1, $s1, endsecond
	lw $t9, 0($a1)
	sw $t9, 0($a2)
	addi $a2,$a2,4
	addi $a1, $a1, 4
	addi $t1, $t1, 1
	j loopsecond
endsecond:

	li   $v0, 10
        syscall
	
