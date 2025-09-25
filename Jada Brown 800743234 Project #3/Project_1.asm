# Jada Brown 800743234 ################################
# Bubble Sort #########################################

.data

myArray: .word 34, 87, 62, 55, 12, 99, 45, 81, 77, 23, 66, 31, 58, 70, 9, 42, 17, 89, 28, 53
array_size: .word 20

NEW_LINE: .asciiz "\n"
COMMA_SPACE: .asciiz ", "

ORIGIN: .asciiz "Original Array: "
ITERATION: .asciiz "Array after iteration: "
SORTED: .asciiz "Sorted Array: "

.text
.globl main

main:
	# Print the original array
	li	$v0, 4                  # syscall for print string
	la	$a0, ORIGIN
	syscall

	la	$a0, myArray		# load address of array
	li	$t0, 20                 # number of elements
	jal	Print_array		# call print array function

    	# Bubble sort algorithm
    	li	$t2, 20  		# set outer loop counter

Outer_loop:
	li	$t3, 0       		# reset inner loop counter
	li	$t4, 0               	# set swapped flag to false
	la	$t1, myArray		# load address of array



Inner_loop:
	lw	$t5, 0($t1)              # load current element
	lw	$t6, 4($t1)              # load next element

	# Compare and swap if necessary
	ble	$t5, $t6, No_swap		# if current <= next, no swap
	sw	$t6, 0($t1)           		# swap elements
	sw	$t5, 4($t1)
	li	$t4, 1                  	# set swapped flag to true


No_swap:
	addi	$t1, $t1, 4            # move to the next pair
	addi	$t3, $t3, 1            # increment inner loop counter
	li	$t0, 19                  # 19 comparisons in the inner loop
	blt	$t3, $t0, Inner_loop    # repeat inner loop


    	# Print the array after each outer iteration
    	li 	$v0, 4                  # syscall for print string
    	la 	$a0, ITERATION
    	syscall

    	la 	$a0, myArray		# load address of array
    	jal 	Print_array             # call print array function

    	# Check if any swaps were made
    	beqz 	$t4, Sorted_done       	# if no swaps, sorting is done

    	addi	$t2, $t2, -1           	# decrement outer loop counter
    	bgtz 	$t2, Outer_loop        	# if more iterations, repeat outer loop


Sorted_done:
	# Print the sorted array
	li	$v0, 4
	la	$a0, SORTED
	syscall

	la	$a0, myArray
	jal	Print_array

	jr	$31			# end program


Print_array:
	li	$t3, 0			# set index to 0
	li	$t5, 20			# total number of elements in the array
	la	$t1, myArray


Print_loop:
	lw	$t4, 0($t1)		# load current element
	li	$v0, 1			# prints integer
	move	$a0, $t4
	syscall

	addi $t3, $t3, 1			# increase index
	li	$t6, 20				# check if it's the last element
	bne	$t3, $t6, Print_comma		# if not the last element, print comma

	j	Print_done			# jump to finish


Print_comma:
	li	$v0, 4
	la	$a0, COMMA_SPACE
	syscall

	addi	$t1, $t1, 4			# move to the next element
	blt	$t3, $t5, Print_loop		# print until all elements are printed


Print_done:
	li	$v0, 4
	la	$a0, NEW_LINE
	syscall

	jr $ra

# END OF LINES ########################################################