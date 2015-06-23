
	.text
	
	addi $t7, $zero, 5
	addi $t8, $zero, 5
	addi $t9, $zero, 13
	addi $t6, $zero, 34
	beq $t8, $t9, branch
	addi $a0, $a0, 1000
	j end
branch:
	addi $a0, $a0, 3
end:
	li   $v0, 10
        syscall