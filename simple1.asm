	.data
number:
	.text

	addi $t4, $zero, 2
	addi $t4, $t4, 20
	addi $t5, $t4, 10
	
	addi $zero, $zero, 5
	addi $t6, $zero, 12
	
	sw   $t5, 0($t6)
