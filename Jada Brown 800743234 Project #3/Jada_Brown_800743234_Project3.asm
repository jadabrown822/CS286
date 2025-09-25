# IP address finder #####################################################

.data

IP_ROUTING_TABLE_SIZE:
		.word	10

IP_ROUTING_TABLE:
		# line #, x.x.x.x -------------------------------------
		.byte	0, 146,  92, 255, 255	# 146.92.255.255
		.byte	1, 147, 163, 255, 255	# 147.163.255.255
		.byte	2, 201,  88,  88,  90	# 201.88.88.90
		.byte	3, 182, 151,  44,  56	# 182.151.44.56
		.byte	4,  24, 125, 100, 100	# 24.125.100.100
		.byte	5, 146, 163, 170,  80	# 146.163.170.80
		.byte	6, 146, 163, 147,  80	# 146.163.147.80
		.byte  10, 201,  88, 102,  80	# 201.88.102.1
		.byte  11, 146, 163, 170,  80	# 146.163.170.80
		.byte  12, 193,  77,  77,  10	# 193.77.77.10

# DON'T CHANGE ANYTHING BELOW ######################################### 

NUM_COLS: .word 5

START_TEXT: .asciiz "Enter the IP address"
FIRST: .asciiz "First: "
SECOND: .asciiz "Second: "
THIRD: .asciiz "Third: "
FOURTH: .asciiz "Fourth: "

TOO_BIG: .asciiz "The entered number is larger than 255."
TOO_SMALL: .asciiz "The entered number is smaller than 0."

VALID_IP: .asciiz "The IP address you entered: "

CLASS_A: .asciiz "\nClass A address\n"
CLASS_B: .asciiz "\nClass B address\n"
CLASS_C: .asciiz "\nClass C address\n"
CLASS_D: .asciiz "\nClass D address\n"
CLASS_E: .asciiz "\nClass E address\n"

IP_PRINT_01: .asciiz "IP: "
IP_PRINT_02: .asciiz "."

MATCH: .asciiz "Matching domain found at: "
NOT_MATCH: .asciiz "No matching domain was found."

NEW_LINE: .asciiz "\n"


.text
.globl main

main:
	# setting parameters ##########################################

	la	$t0, IP_ROUTING_TABLE		# Base addres for table
	lw	$t1, IP_ROUTING_TABLE_SIZE	# Number of rows
	lw	$t2, NUM_COLS			# Number of columns

	li	$t3, 0		# Initial row counter
	li	$t4, 0		# Initial column counter
	li	$t5, 0		# Min IP address
	li	$t6, 255	# Mac IP address

	li	$t7, -1		# index finder, will change at index found
	li	$s4, 127	# Class A max
	li	$s5, 191	# Class B max
	li	$s6, 223	# Class C max
	li	$s7, 239	# Class D max


Start_program:

	li	$v0, 4
	la	$a0, START_TEXT		# "Enter the IP address
	syscall

	li	$v0, 4
	la	$a0, NEW_LINE
	syscall

	j Question_01


Question_01:

	li	$v0, 4
	la	$a0, FIRST	# "First: "
	syscall

	li	$v0, 5
	syscall

	move	$s0, $v0

	blt	$s0, $t5, TOO_SMALL_01
	bgt	$s0, $t6, TOO_BIG_01

	j Question_02


TOO_SMALL_01:

	li	$v0, 4
	la	$a0, TOO_SMALL		# "The entered number is smaller than 0."
	syscall

	li	$v0, 4
	la	$a0, NEW_LINE
	syscall

	j Question_01


TOO_BIG_01:

	li	$v0, 4
	la	$a0, TOO_BIG		# "The entered number is bigger than 255."
	syscall

	li	$v0, 4
	la	$a0, NEW_LINE
	syscall

	j Question_01


Question_02:

	li	$v0, 4
	la	$a0, SECOND	# "Second: "
	syscall

	li	$v0, 5
	syscall

	move	$s1, $v0

	blt	$s1, $t5, TOO_SMALL_02
	bgt	$s1, $t6, TOO_BIG_02

	j Question_03


TOO_SMALL_02:

	li	$v0, 4
	la	$a0, TOO_SMALL		# "The entered number is smaller than 0."
	syscall

	li	$v0, 4
	la	$a0, NEW_LINE
	syscall

	j Question_02


TOO_BIG_02:

	li	$v0, 4
	la	$a0, TOO_BIG		# "The entered number is bigger than 255."
	syscall

	li	$v0, 4
	la	$a0, NEW_LINE
	syscall

	j Question_02


Question_03:

	li	$v0, 4
	la	$a0, THIRD	# "Third: "
	syscall

	li	$v0, 5
	syscall

	move	$s2, $v0

	blt	$s2, $t5, TOO_SMALL_03
	bgt	$s2, $t6, TOO_BIG_03

	j Question_04


TOO_SMALL_03:

	li	$v0, 4
	la	$a0, TOO_SMALL		# "The entered number is smaller than 0."
	syscall

	li	$v0, 4
	la	$a0, NEW_LINE
	syscall

	j Question_03


TOO_BIG_03:

	li	$v0, 4
	la	$a0, TOO_BIG		# "The entered number is bigger than 255."
	syscall

	li	$v0, 4
	la	$a0, NEW_LINE
	syscall

	j Question_03


Question_04:

	li	$v0, 4
	la	$a0, FOURTH	# "Fourth: "
	syscall

	li	$v0, 5
	syscall

	move	$s3, $v0

	blt	$s3, $t5, TOO_SMALL_04
	bgt	$s3, $t6, TOO_BIG_04

	li	$v0, 4
	la	$a0, NEW_LINE
	syscall

	j Class_Check


TOO_SMALL_04:

	li	$v0, 4
	la	$a0, TOO_SMALL		# "The entered number is smaller than 0."
	syscall

	li	$v0, 4
	la	$a0, NEW_LINE
	syscall

	j Question_04


TOO_BIG_04:

	li	$v0, 4
	la	$a0, TOO_BIG		# "The entered number is bigger than 255."
	syscall

	li	$v0, 4
	la	$a0, NEW_LINE
	syscall

	j Question_04


Class_Check:

	li	$v0, 4
	la	$a0, VALID_IP		# "The IP address you entered: "
	syscall

	move	$a0, $s0		# $s0 -> $a0
	li	$v0, 1
	syscall

	li	$v0, 4
	la	$a0, IP_PRINT_02	# "."
	syscall

	move	$a0, $s1		# $s1 -> $a0
	li	$v0, 1
	syscall

	li	$v0, 4
	la	$a0, IP_PRINT_02	# "."
	syscall

	move	$a0, $s2		# $s2 -> $a0
	li	$v0, 1
	syscall

	li	$v0, 4
	la	$a0, IP_PRINT_02	# "."
	syscall

	move	$a0, $s3		# $s3 -> $a0
	li	$v0, 1
	syscall

	ble	$s0, $s4, Class_A	# $s0 <= 127
	ble	$s0, $s5, Class_B	# $s0 <= 191
	ble	$s0, $s6, Class_C	# $s0 <= 233
	ble	$s0, $s7, Class_D	# $s0 <= 239

	j Class_E			# $s0 > 239


Class_A:

	li	$v0, 4
	la	$a0, CLASS_A
	syscall

	j Row_Loop


Class_B:

	li	$v0, 4
	la	$a0, CLASS_B
	syscall

	j Row_Loop


Class_C:

	li	$v0, 4
	la	$a0, CLASS_C
	syscall

	j Row_Loop


Class_D:

	li	$v0, 4
	la	$a0, CLASS_D
	syscall

	j Row_Loop


Class_E:

	li	$v0, 4
	la	$a0, CLASS_E
	syscall

	j Row_Loop


Row_Loop:

	bge	$t3, $t1, End_Table
	
	mul	$t8, $t3, $t2		# Row index * number of columns
	add	$t8, $t8, $t4		# Add the column index
	add	$t8, $t0, $t8		# Add to the base address

	lbu	$s8, ($t8)

	move	$t9, $s8		# moves index into $t9

	addi	$t4, $t4, 1

	j Column_Loop


Column_Loop:

	bge	$t4, $t2, Next_Row

	mul	$t8, $t3, $t2		# Row index * number of columns
	add	$t8, $t8, $t4		# Add the column index
	add	$t8, $t0, $t8		# Add to the base address

	lbu	$s8, ($t8)

	beq	$s8, $s0, First_Check

	move	$a0, $s8
	li	$v0, 1
	syscall

	li	$v0, 4
	la	$a0, IP_PRINT_02
	syscall

	addi	$t4, $t4, 1	# move to the next column

	j Column_Loop


Next_Row:

	addi	$t3, $t3, 1	# move to the next row

	li	$v0, 4
	la	$a0, NEW_LINE
	syscall
	
	li	$t4, 0		# reset column count
	j Row_Loop


First_Check:

	move	$a0, $s8
	li	$v0, 1
	syscall

	li	$v0, 4
	la	$a0, IP_PRINT_02
	syscall

	addi	$t4, $t4, 1	# move to the next column
	bge	$t4, $t2, Next_Row

	mul	$t8, $t3, $t2
	add	$t8, $t8, $t4
	add	$t8, $t0, $t8

	lbu	$s8, ($t8)
	beq	$s8, $s1, Second_Check

	j Column_Loop


Second_Check:

	move	$a0, $s8
	li	$v0, 1
	syscall

	li	$v0, 4
	la	$a0, IP_PRINT_02
	syscall

	addi	$t4, $t4, 1	# move to the next column
	bge	$t4, $t2, Next_Row

	mul	$t8, $t3, $t2
	add	$t8, $t8, $t4
	add	$t8, $t0, $t8

	lbu	$s8, ($t8)
	beq	$s8, $s2, Third_Check

	j Column_Loop


Third_Check:

	move	$a0, $s8
	li	$v0, 1
	syscall

	li	$v0, 4
	la	$a0, IP_PRINT_02
	syscall

	addi	$t4, $t4, 1	# move to the next column
	bge	$t4, $t2, Next_Row

	mul	$t8, $t3, $t2
	add	$t8, $t8, $t4
	add	$t8, $t0, $t8

	lbu	$s8, ($t8)
	beq	$s8, $s2, Fourth_Check

	j Column_Loop


Fourth_Check:

	move	$a0, $s8
	li	$v0, 1
	syscall
 
	li	$v0, 4
	la	$a0, IP_PRINT_02
	syscall

	move	$t7, $t9	# moves	$t9 into index location

	j Next_Row


End_Table:

	li	$t3, 0		# reset row counter
	li	$t4, 0		# reset column counter

	bltz	$t7, No_Match
	bge	$t7, $zero, Found_Match


No_Match:

	li	$v0, 4
	la	$a0, NOT_MATCH		# "No matching domain was found."
	syscall

	j Done


Found_Match:

	li	$v0, 4
	la	$a0, MATCH	# "Matching domain found at: "
	syscall

	move	$a0, $t7
	li	$v0, 1
	syscall

	j Done


Done:
	jr 	$31

# END OF LINES ########################################################