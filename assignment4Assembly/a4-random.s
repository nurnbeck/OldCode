	
#---------------------------------------------------------------
# Assignment:           4
# Due Date:             April 1, 2016
# Name:                 Nolan Beck
# Unix ID:              nbeck
# Lecture Section:      B1
# Lab Section:          H04 (Thursday 2:00-4:50)
# Teaching Assistant(s):   Rodolfo Wottrich
#---------------------------------------------------------------

#t5 = buff address
#t6/t7 = arithmetic holders
#a3 = 


#
#
# ------------------------------------------------------------
# lab4-test-handler.s
#     - Must Run with Memory-Mapped I/O and the modified Exception response code.
#------------------------------------------------------------

	  .data
s_v0:     .word 0
s_a0:     .word 0
s_t6:     .word 0
s_t7:     .word 0
s_a3:     .word 0
s_t5:     .word 0

length: 	.word	0
buff:		.space	240
str_newline:   .asciiz "\n"
str_inp:       .asciiz "input string= "
str_x:         .asciiz ", x = "

# ------------------------------
	  .text
main:
	 # Enable keyboard interrupts	  
	 li	$a3, 0xffff0000        # base address of I/O
	 li	$s1, 2		       # $s1= 0x 0000 0002
	 sw 	$s1, 0($a3)	       # enable keyboard interrupts
	 la     $t5, buff
	 # Enable global interrupts
	 li	$s1, 0x0000ff01	       # set IE= 1 (enable interrupts) , EXL= 0
	 mtc0	$s1, $12	       # SR (=R12) = enable bits

	 # Start timer
         mtc0  $0, $9                  # COUNT = 0
         addi  $t0, $0, 250             # $t0 = 50 ticks
         mtc0  $t0, $11                # CP0:R11 (Compare Reg.)= $t0

loop:	 beq  $t0,$t0, loop	       # infinite loop

# ------------------------------------------------------------
# lab4_handler - example interrupt handler
#   Entry Conditions:
#       - CPU is still in the Exception Mode (EXL= 1)
#       - EPC has a restart address
# ------------------------------------------------------------	

        .globl  lab4_handler   

lab4_handler:

	# Save $at, $v0, and $a0
	#
	.set noat
	move $k1 $at		# Save $at
	.set at
	sw   $v0  s_v0		# Not re-entrant and we can't trust $sp
	sw   $a0, s_a0		# But we need to use these registers
	sw   $t6, s_t6		# HERE WE SAVE REGISTERS SO THEY ARE NOT DISRUPTED
	sw   $t7, s_t7		
	sw   $a3, s_a3

	# Identify the interrupt source
	#
	mfc0   $k0, $13		# $k0 = Cause Reg (R13)

	srl    $a0, $k0, 11	# isolate IP3 (interrupt bit 1) (for keyboard)
	andi   $a0, 0x1
	bgtz   $a0, do_keyboard

	srl    $a0, $k0, 15	# isolate IP7 (interrupt bit 5) (for timer)
	andi   $a0, 0x1
	bgtz   $a0, do_timer

	b      lab4_handler_ret # ignore other interrupts

do_keyboard:
	#li    $a0, 'A'; li $v0, 11; syscall    # print 'k'
	li     $a3, 0xffff0000			# keyboard input access 
	lw     $v0, 4($a3) 			# Get character form Keyboard
	sw     $v0, 0($t5)			# store v0(our input char) in t5(buff)
	addi   $t5, $t5, 4			# make room for next piece
	b      lab4_handler_ret			# handler call

#set first bit to zero
#in empty buff we load buffs address into t5 and then set the first bit to zero,
#logically resetting buff
empty_buff:
	la $t5, buff
	sw $zero, 0($t5)
	jr $ra

#this will take our array, add all the hex numbers together creating SUM, then proceed to 
# take the ((SUM xor $sp) modulo 100) and output resulting pseudo-random number
#t7 = 13 for mod
#t5 = buff's address
#we store and retrieve the return address in the stack to prevent ra loss
print_buff:
	li   $t7, 0x64     	# load 13 for modulo
	la   $t5, buff		# load buff's address in t5
	subu $sp, $sp, 4	# update stack pointer for mod function and returning
	sw   $ra, ($sp)
	li	$v0, 4		#print input = string
	la	$a0, str_inp
	syscall
	li $a3, 0
	p_loop:
		lw   $a0, 0($t5)
		li   $v0, 11
		syscall
		beq  $a0, $zero, print_ret 
		addi $t5, $t5, 4
		addu $a3, $a3, $a0
		addu $a0, $a0, $a0
		j p_loop
	print_ret:
		#PRINT X = STRING
		li	$v0, 4
		la	$a0, str_x
		syscall
		# create additional randomness through xor with constantly updated value
		xor $a3, $a3, $sp  	# xor our sum with constantly updated stack address
		
		#DO ARITHMETIC TO GENERATE PSEUDO-RANDOMNESS
		move $t6, $a3		#t6 = sum of all chars in buff
		div  $t6, $t7		#t6 divided by 100
		mfhi $a0		#grab remainder, store in a0
		li   $t7, 1		#13 - 6 = 7
		mult $a0, $t7		#t6 * 7 = a0
		mflo $a0
		#PRINT RANDOM NUMBER (a0)
		li   $v0, 1
		syscall
		#PRINT OUR NEW LINE	
		jal print_NL
		#RECOVER RETURN ADDRESS FROM STACK
		lw  $ra, ($sp)
		addu $sp, $sp, 4
		jr  $ra		
do_timer:
	li $v0, 0xA				#STORE $zero to end input string
	sw $zero, 0($t5)
	addi $t5, $t5, 4
	la $t5, buff
	# Restart timer
	jal   print_buff			#output

	jal   empty_buff			#clear buff for next iteration

        mtc0  $0, $9                            # COUNT = 0
        addi  $t0, $0, 250                      # $t0 = X(desired interval) ticks
        mtc0  $t0, $11                          # CP0:R11 (Compare Reg.)= $t0

	b   lab4_handler_ret

lab4_handler_ret:
	lw  $v0  s_v0		# RESTORE ALL REGISTERS USED IN OUR HANDLER
	lw  $a0, s_a0
	lw  $t6, s_t6
	lw  $t7, s_t7
	lw  $a3, s_a3

	.set noat
	move $at $k1		# Restore $at
	.set at

	mtc0 $0 $13		# Clear Cause register

	mfc0  $k0 $12		# Set Status register
	ori   $k0 0x1		# Interrupts enabled
	mtc0  $k0 $12
	
	eret			# exception return
# -----------------------------------------------------------
# procedure ’print_NL’ 'fine'
print_NL:
	li	$a0, 0xA
	li 	$v0, 11
	syscall
	jr	$ra
#--------------------------


