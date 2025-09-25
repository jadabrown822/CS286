# part 2 while structure #####################################################

.data

ORGN_INPUT: .asciiz "Enter the origin of your number sequence (1 - 5): "
MULT_FACTOR: .asciiz "Enter your multiple factor (2 - 7): "
REP_NUM: .asciiz "Enter the total number of the numbers (3 - 30): "

INVALID_INPUT: .asciiz "Invalid number. Try again."

LIST_SEG_01: .asciiz ", "

CHECK_SUM: .asciiz "Check-sum: "
NEW_LINE: .asciiz "\n"


.text
.globl main

main:
	# setting parameters #################################################

	li $t0, 0	# start of list output
	li $t1, 1	# min orgn in
	li $t2, 5	# max orgn in
	li $t3, 7	# max mult factor
	li $t4, 3	# min rep num
	li $t5, 30	# max rep num
	li $t6, 0	# start of sum
	li $t7, 0	# loop to


Loop_01:

	# question 1 print ##################################################
	li	$v0, 4
	la	$a0, ORGN_INPUT
	syscall

	li	$v0, 5
	syscall

	move	$s0, $v0

	# check if valid ###################################################
	blt	$s0, $t1, Error_01
	bgt	$s0, $t2, Error_01

	j Loop_02


Error_01:
	li	$v0, 4
	la	$a0, INVALID_INPUT
	syscall

	li	$v0, 4
	la	$a0, NEW_LINE
	syscall

	li	$v0, 4
	la	$a0, NEW_LINE
	syscall


	j Loop_01


Loop_02:

	li	$v0, 4
	la	$a0, NEW_LINE
	syscall

	# question 2 print #################################################
	li	$v0, 4
	la	$a0, MULT_FACTOR
	syscall

	li	$v0, 5
	syscall

	move	$s1, $v0

	# check if valid ###################################################
	ble	$s1, $t1, Error_02
	bgt	$s1, $t3, Error_02

	j Loop_03


Error_02:
	li	$v0, 4
	la	$a0, INVALID_INPUT
	syscall
	
	li	$v0, 4
	la	$a0, NEW_LINE
	syscall

	j Loop_02


Loop_03:

	li	$v0, 4
	la	$a0, NEW_LINE
	syscall

	# question 3 print #################################################
	li	$v0, 4
	la	$a0, REP_NUM
	syscall

	li	$v0, 5
	syscall

	move	$s2, $v0

	li	$v0, 4
	la	$a0, NEW_LINE
	syscall

	# check if valid ###################################################
	blt	$s2, $t4, Error_03
	bgt	$s2, $t5, Error_03

	add	$t0, $t0, $s0
	
	j Math_loop


Error_03:
	li	$v0, 4
	la	$a0, INVALID_INPUT
	syscall

	li	$v0, 4
	la	$a0, NEW_LINE
	syscall

	j Loop_03


Math_loop:
	
	# output section ###################################################
	move	$a0, $t0	# load integer to be printed
	li	$v0, 1
	syscall

	li	$v0, 4
	la	$a0, LIST_SEG_01	# loads comma and space
	syscall

	# looping for the math #############################################
	add 	$t6, $t6, $t0

	add	$t0, $t0, $s1

	sub	$s2, $s2, $t1

	bne	$s2, $t1, Math_loop

	# last interation ##################################################

	add 	$t6, $t6, $t0

	sub	$s2, $s2, $t1
		

	move	$a0, $t0	# load integer to be printed
	li	$v0, 1
	syscall	
		
	# new line ########################################################
	li	$v0, 4
	la	$a0, NEW_LINE
	syscall

	j Sum_print


Sum_print:
	
	# new line ########################################################
	li	$v0, 4
	la	$a0, NEW_LINE
	syscall

	li	$v0, 4
	la	$a0, CHECK_SUM
	syscall

	move	$a0, $t6	# load integer to be printed
	li	$v0, 1
	syscall

	li	$v0, 4
	la	$a0, NEW_LINE
	syscall

	# end of program ###################################################
	jr	$31

# END OF LINES #############################################################