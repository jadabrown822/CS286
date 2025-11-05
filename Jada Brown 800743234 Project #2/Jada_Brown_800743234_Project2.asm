# Jada Brown 800743234 Project 2 Recursion ####################################

.data
PROMPT:     .asciiz     "Enetr the number of disks: "
MOVING:     .asciiz     "\nMoving "
DISKS:      .asciiz     " disks ...\n"
MOVE_MSG:   .asciiz     "Move a disk: peg "
TO_MSG:     .asciiz     " -> peg "
NEW_LINE:   .asciiz     "\n"
END_MSG:    .asciiz     "\nThe end of the process ...\n"

PEG1_CHAR:  .asciiz     "1"
PEG2_CHAR:  .asciiz     "2"
PEG3_CHAR:  .asciiz     "3"
PEG_CHARS:  .word       PEG1_CHAR, PEG2_CHAR, PEG3_CHAR


.text
.globl main


main:
    # Read num disks #################
    li  $v0, 4
    la  $a0, PROMPT
    syscall

    li  $v0, 5
    syscall
    move    $s0, $v0       # $v0 -> $s0

    li      $v0, 4
    la      $a0, MOVING
    syscall

    li      $v0, 1
    move    $a0, $s0
    syscall

    li      $v0, 4
    la      $a0, DISKS
    syscall

    move    $a0, $s0        # $a0 = n
    li      $a1, 1          # Source Peg
    li      $a2, 3          # Target Peg
    li      $a3, 2          # Temp Peg

    # Recursion structure ################
    subu    $sp, $sp, 4

    sw      $ra, 0($sp)

    jal     Hanoi

    lw      $ra, 0($sp)

    subu    $sp, $sp, -4

    # Print Summary Section ################
    li      $v0, 4
    la      $a0, END_MSG
    syscall

    # ending program	####################
	jr 	$31


Hanoi:
    subu    $sp, $sp, 20
    sw      $ra, 16($sp)

    sw      $a0, 12($sp)        # diskNum (n)
    sw      $a1, 8($sp)         # Source
    sw      $a2, 4($sp)         # Target
    sw      $a3, 0($sp)         # Temp

    beq     $a0, $zero, Hanoi_Return        # if (n == 0)

    li      $t0, 1
    bne     $a0, $t0, Go_Loop       # if (n != 1) start moving disks

    move    $t0, $a1        # base case $a1 -> $t0
    move    $t1, $a2
    li      $t2, 1
    jal     Print

    j   Hanoi_Return


Go_Loop:
    addi    $a0, $a0, -1
    move    $t0, $a2
    move    $a2, $a3
    move    $a3, $t0        # a2 and a3 swapped roles

    jal Hanoi

    # Restore params
    lw      $a3, 0($sp)
    lw      $a2, 4($sp)
    lw      $a1, 8($sp)
    lw      $a0, 12($sp)

    # Move disk n (Source to Target)
    move    $t0, $a1
    move    $t1, $a2
    move    $t2, $a0
    jal Print

    # Temp to Target
    addi    $a0, $a0, -1
    move    $t0, $a1
    move    $a1, $a3
    move    $a3, $t0        # a1 and a3 swapped roles

    jal Hanoi


Hanoi_Return:
    lw      $ra, 16($sp)
    subu    $sp, $sp, -20

    jr  $ra


Print:
    subu    $sp, $sp, 4
    sw      $ra, 0($sp)

    # $a0 = Source, $a1 = Target
    move    $a0, $t0
    move    $a1, $t1

    jal Move_Print

    lw      $ra, 0($sp)
    subu    $sp, $sp, -4
    jr      $ra


Move_Print:
    li      $v0, 4
    la      $a2, MOVE_MSG
    move    $a0, $a2
    syscall

    sub     $t1, $a0, 1
    sll     $t1, $t1, 2
    la      $t2, PEG_CHARS
    add     $t2, $t2, $t1
    lw      $a0, 0($t2)
    li      $v0, 4;
    syscall

    li      $v0, 4
    la      $a2, TO_MSG
    move    $a0, $a2
    syscall

    sub     $t1, $a1, 1
    sll     $t1, $t1, 2
    la      $t2, PEG_CHARS
    add     $t2, $t2, $t1
    lw      $a0, 0($t2)
    li      $v0, 4;
    syscall

    li      $v0, 4
    la      $a0, NEW_LINE
    syscall

    jr $ra


# END OF LINES #######################################################