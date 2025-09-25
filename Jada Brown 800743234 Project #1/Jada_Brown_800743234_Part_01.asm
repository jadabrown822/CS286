# part 1 if-then structure ##############################################

.data

CUR_DRIVE_MESSAGE: .asciiz "Enter your current speed in MPH (1 to 200): "
INVAL_CUR_DRIVE_MESSAGE: .asciiz "You made an invalid input for your current driving speed. Enter a valid input for your current driving speed."

ABS_ROAD_SPEED_LIM: .asciiz "Enter the absolute speed limit specified for the road you are currently running on (15 - 70): "
INVAL_ABS_SPEED: .asciiz "You made an invalid input for the absolute speed limit. Enter a valid input for the speed limit."

GOOD_BOY: .asciiz "You are a safe driver!"
AVG_DRIVING: .asciiz "You may receive a $120 fine."
KACHOW: .asciiz "You may receive a $140 fine."
IM_IN_DANGER: .asciiz "Class B misdemeanor and carries up to six months in jail and a maximum $1,500 in fines."
GOTTA_GO_FAST: .asciiz "Class A misdemeanor and carries up to one year in jail and a maximum $2,500 in fines."

NEW_LINE: .asciiz "\n"

.text
.globl main

main:
	# setting parameters ############################################

	li	$t0, 1		# min of valid current speed
	li	$t1, 200	# max of valid current speed
	li	$t2, 15		# min of speed limit
	li	$t3, 70		# max of speed limit
	li	$t4, 20		# max speed of avg_driving
	li	$t5, 25		# max speed of kachow
	li	$t6, 34		# max speed of im_in_danger

Question_01:

	# printing first question #######################################
	li	$v0, 4
	la	$a0, CUR_DRIVE_MESSAGE
	syscall

	# user input, and moving ########################################
	li	$v0, 5
	syscall

	move	$s0, $v0

	# valid checking ################################################
	blt	$s0, $t0, Error_01
	bgt	$s0, $t1, Error_01

	# going to second question ######################################
	j Question_02


Error_01:
	
	# printing first error ##########################################
	li	$v0, 4
	la	$a0, INVAL_CUR_DRIVE_MESSAGE
	syscall

	li	$v0, 4
	la	$a0, NEW_LINE
	syscall

	# loop back to first question ###################################
	j Question_01
	

Question_02:
	
	# printing second question ######################################
	li	$v0, 4
	la	$a0, ABS_ROAD_SPEED_LIM
	syscall

	# user input and move ###########################################
	li	$v0, 5
	syscall

	move	$s1, $v0

	# check if valid ################################################
	blt	$s1, $t2, Error_02
	bgt	$s1, $t3, Error_02

	# send to output ################################################
	j Driving_skill

Error_02:

	# printing second error ##########################################
	li	$v0, 4
	la	$a0, INVAL_ABS_SPEED
	syscall

	li	$v0, 4
	la	$a0, NEW_LINE
	syscall

	# loop back to second question ###################################
	j Question_02

Driving_skill:

	# new-line ######################################################
	li	$v0, 4
	la	$a0, NEW_LINE
	syscall

	# subtract limit from speed ######################################
	sub $s2, $s0, $s1	# $s2 = $s0 - $s1
	
	# 35MPH or greater ###############################################
	bgt $s2, $t6, Sonic_line
	
	# under ##########################################################
	blt $s2, $t0, Turtle

	# checking first range ###########################################
	bgt $s2, $t0, First_check
	beq $s2, $t0, First_check

	j Finished


First_check:
	
	blt $s2, $t4, Avg_driver
	beq $s2, $t4, Avg_driver
	j Second_check


Second_check:
	
	blt $s2, $t5, Mc_Queen
	beq $s2, $t5, Mc_Queen
	j Simpsons_line

Sonic_line:

	li $v0, 4
	la $a0, GOTTA_GO_FAST
	syscall

	li	$v0, 4
	la	$a0, NEW_LINE
	syscall

	j Finished


Simpsons_line:
	
	li $v0, 4
	la $a0, IM_IN_DANGER
	syscall

	li	$v0, 4
	la	$a0, NEW_LINE
	syscall

	j Finished


Mc_Queen:

	li $v0, 4
	la $a0, KACHOW
	syscall

	li	$v0, 4
	la	$a0, NEW_LINE
	syscall

	j Finished


Avg_driver:

	li $v0, 4
	la $a0, AVG_DRIVING
	syscall

	li	$v0, 4
	la	$a0, NEW_LINE
	syscall

	j Finished


Turtle:

	li $v0, 4
	la $a0, GOOD_BOY
	syscall

	li	$v0, 4
	la	$a0, NEW_LINE
	syscall

	j Finished


Finished:
	# ending program	#############################################
	jr 	$31

# END OF LINES ##########################################################