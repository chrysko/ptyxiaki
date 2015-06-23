	.data
number:
	.word 10
	
	.text

	la $t1, number
	addi $t0, $t0, 10
	addi $a1, $a1, 69
	addi $zero, $zero, 0
	lw  $t3, 0($t1)
	beq $t5, $a1, goaway
	beq $t3, $t0, label1
	addi $a0, $zero, 37
	j goaway
label1:
	addi $a0, $zero, 45
goaway:
	li   $v0, 10
        syscall
