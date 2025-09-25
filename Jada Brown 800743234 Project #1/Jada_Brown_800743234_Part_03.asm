# part 3 floating-point fraction numbers #####################################

.data

MIN_PRIN_AMOUNT: .float 100.00
MAX_PRIN_AMOUNT: .float 1000000.00
MIN_INT_RATE: .float 0.005
MAX_INT_RATE: .float 0.339
MIN_MON_PAY: .float 1.00
MAX_MON_PAY: .float 2000000.00

TIME_PAY: .float 0.08219


PRIN_AMOUNT: .asciiz "Ener the principal in $ (100.00 - 1,000,000.00): "
ANN_INT_RATE: .asciiz "Enter the annual interest rate (0.005 - 0.339): "
MONTHLY_PAY: .asciiz "Enter the monthly paymen amount in $ (1.00 - 2,000,000.00): "

INVALID_INPUT: .asciiz "Invalid number. Try again."

MONTH_NUMBER: .asciiz "month "
CUR_PRIN: .asciiz ": current principal = "

NEW_LINE: .asciiz "\n"

FINISHED_01: .asciiz "It will take "
FINISHED_02: .asciiz " months to complete the loan."


.text
.globl main

main:

	# setting parameters #################################################

	li	$t0, 1			# first month no payment

	# load fraction numbers ##############################################
	la	$a0, MIN_PRIN_AMOUNT	# minimum principal amount
	lwc1	$f1, ($a0)		

	la	$a0, MAX_PRIN_AMOUNT	# maximum principal amount
	lwc1	$f2, ($a0)		

	la	$a0, MIN_INT_RATE	# minimum intrest rate
	lwc1	$f3, ($a0)		

	la	$a0, MAX_INT_RATE	# maximum intrest rate
	lwc1	$f4, ($a0)		

	la	$a0, MIN_MON_PAY	# minimum monthly payment
	lwc1	$f5, ($a0)		

	la	$a0, MAX_MON_PAY	# maximum monthly payment
	lwc1	$f6, ($a0)		

	la	$a0, TIME_PAY		# (30 days)/(356 days)
	lwc1	$f7, ($a0)

	j Loop_01


Loop_01:

	# question 1 ##################################################
	li	$v0, 4
	la	$a0, PRIN_AMOUNT
	syscall

	li	$v0, 6
	syscall

	mov.s	$f8, $f0

	# valid checking #####################################################
	c.lt.s	$f8, $f1
	bc1t	Error_01

	c.lt.s	$f2, $f8
	bc1t	Error_01

	li	$v0, 4
	la	$a0, NEW_LINE
	syscall

	j Loop_02


Error_01:

	li	$v0, 4
	la	$a0, INVALID_INPUT
	syscall

	li	$v0, 4
	la	$a0, NEW_LINE
	syscall

	j Loop_01


Loop_02:

	# question 2 #########################################################
	li	$v0, 4
	la	$a0, ANN_INT_RATE
	syscall

	li	$v0, 6
	syscall

	mov.s	$f9, $f0

	# valid checking #####################################################
	c.lt.s	$f9, $f3
	bc1t	Error_02

	c.lt.s	$f4, $f9
	bc1t	Error_02

	li	$v0, 4
	la	$a0, NEW_LINE
	syscall

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

	# question 3 #########################################################
	li	$v0, 4
	la	$a0, MONTHLY_PAY
	syscall

	li	$v0, 6
	syscall

	mov.s	$f10, $f0

	# valid checking #####################################################
	c.lt.s	$f10, $f5
	bc1t	Error_03

	c.lt.s	$f6, $f10
	bc1t	Error_03

	li	$v0, 4
	la	$a0, NEW_LINE
	syscall
	
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

	# message ouput ######################################################
	li	$v0, 4
	la	$a0, MONTH_NUMBER
	syscall

	li	$v0, 1
	move	$a0, $t0
	syscall

	li	$v0, 4
	la	$a0, CUR_PRIN
	syscall

	li	$v0, 2
	mov.s	$f12, $f8
	syscall

	li	$v0, 4
	la 	$a0, NEW_LINE
	syscall

	# math parts #########################################################
	add	$t0, $t0, 1		# add one month

	mul.s	$f11, $f8, $f9		# principal x interest
	mul.s	$f13, $f11, $f7		# $f11 x days

	sub.s	$f14, $f10, $f13	# payment to the prinicpal
	
	sub.s	$f8, $f8, $f14		# remaining principal


	# when principal is less than payment ################################

	c.lt.s	$f8, $f10
	bc1f	Math_loop

	li	$v0, 4
	la	$a0, MONTH_NUMBER
	syscall

	li	$v0, 1
	move	$a0, $t0
	syscall

	li	$v0, 4
	la	$a0, CUR_PRIN
	syscall

	li	$v0, 2
	mov.s	$f12, $f8
	syscall

	li	$v0, 4
	la 	$a0, NEW_LINE
	syscall

	j Finished


Finished:

	# minus a day ########################################################

	li	$v0, 4
	la	$a0, NEW_LINE
	syscall

	li	$v0, 4
	la	$a0, NEW_LINE
	syscall

	li	$v0, 4
	la	$a0, FINISHED_01
	syscall

	li	$v0, 1
	move	$a0, $t0
	syscall

	li	$v0, 4
	la	$a0, FINISHED_02
	syscall

	jr $31

# END OF LINES ###############################################################