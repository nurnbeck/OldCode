	
#---------------------------------------------------------------
# Assignment:           4
# Due Date:             April 1, 2016
# Name:                 Nolan Beck
# Unix ID:              nbeck
# Lecture Section:      B1
# Lab Section:          H04 (Thursday 2:00-4:50)
# Teaching Assistant(s):   Rodolfo Wottrich
#------------------------------ DATA SEGMENT ------------------------------------

	.globl pyramid
	.globl write_frame

	.data
N:	.word  15	# width of the pyramid
K:	.word  5	# left margin of the pyramid's base
s_v0:   .word 0
s_a0:   .word 0
s_a1:   .word 0
s_t2:   .word 0
s_t3:   .word 0

char_fill:  .byte  '*'
char_space: .byte  ' '

str_dash:   .asciiz "________________________\n"

str_0:	    .asciiz " quitting interactive pyramid "
str_1:      .asciiz " "
str_2:	    .asciiz " "
str_a0:	    .asciiz "pyramid:  N = "
str_a1:     .asciiz " K = "
str_ra:	    .asciiz " ra = "
# ------------------------------ TEXT SEGMENT ----------------------------------
.text

	.globl main
main:
	#default X and N
	li $a0, 1
	li $a1, 0
	li $t1, 1
	li $t2, 0
	
	# Enable keyboard interrupts	  
	li	$a3, 0xffff0000        # base address of I/O
	li	$s1, 2		       # $s1= 0x 0000 0002
	sw 	$s1, 0($a3)	       # enable keyboard interrupts

	# Enable global interrupts
	li	$s1, 0x0000ff01	       # set IE= 1 (enable interrupts) , EXL= 0
	mtc0	$s1, $12	       # SR (=R12) = enable bits

	# Start timer
        mtc0  $0, $9			# COUNT = 0
        addi  $t0, $0, 40             	# $t0 = 50 ticks
        mtc0  $t0, $11                	# CP0:R11 (Compare Reg.)= $t0
	li    $t5, 1000000		#set delay
	

loop:	#jal pyramid
	#need to set delay, AND create condition so
	addi $t5, $t5, -1		#NEW
	beq $t5, $zero, do_timer	#ROUGH DRAFT
	beq  $t0,$t0, loop	       # infinite loop

	.globl lab4_handler

lab4_handler:

	# Save $at, $v0, and $a0
	#
	.set noat
	move $k1 $at		# Save $at
	.set at
	sw 	$v0 s_v0		# Not re-entrant and we can't trust $sp
	sw 	$a0, s_a0		# But we need to use these registers
	sw 	$a1, s_a1
	# Identify the interrupt source
	#
	mfc0   $k0, $13		# $k0 = Cause Reg (R13)

	srl    $a0, $k0, 11	# isolate IP3 (interrupt bit 1) (for keyboard)
	andi   $a0, 0x1
	bgtz   $a0, do_keyboard

	#srl    $a0, $k0, 15	# isolate IP7 (interrupt bit 5) (for timer)
	#andi   $a0, 0x1
	#bgtz   $a0, do_timer

	b      lab4_handler_ret # ignore other interrupts

do_keyboard:
	li $a3, 0xffff0000
	lw $v0, 4($a3) 			# Get character form Keyboard
	#sw $v0, 12($a3)
	beq $v0, 0x71, q_app
	beq $v0, 0x69, N_inc
	beq $v0, 0x64, N_dec
	beq $v0, 0x72, K_inc
	beq $v0, 0x6C, K_dec
	
	#li $a0, 'A'; li $v0, 11; syscall      # print 'k'
	b      lab4_handler_ret
q_app:
	#exit
	li $v0, 4; la $a0, str_0; syscall 	# print quit statement is:
	addi $sp, $sp, 12
	li $v0, 10; syscall
N_inc:
	move  $a0, $t1
	li    $t3, 0x14 				# if N=20 exit
	beq   $a0, $t3, lab4_handler_ret
	addi  $t1, $t1, 1
	b     lab4_handler_ret
N_dec:
	move  $a0, $t1
	li    $t3, 0x1				#if N=1 exit 
	beq   $a0, $t3, lab4_handler_ret
	addi  $t1, $t1, -1
	b      lab4_handler_ret
K_inc:
	move  $a1, $t2
	li    $t3, 0x28 				#if K = 40
	beq   $a1, $t3, lab4_handler_ret
	#addi  $a1, $a1, 1
	addi  $t2, $t2, 1
	#sw    $a1, 16($sp)
	b      lab4_handler_ret
K_dec:
	move  $a1, $t2
	li    $t3, 0 				#if K = 0
	beq   $a1, $t3, lab4_handler_ret
	#addi  $a1, $a1, -1
	addi  $t2, $t2, -1
	#sw    $a1, 16($sp)
	b      lab4_handler_ret
do_timer:
	move $a0, $t1
	move $a1, $t2
	jal write_frame
	jal pyramid
	# Restart timer
	#
	li $t5, 1000000
        #mtc0  $0, $9                          # COUNT = 0
        #addi  $t0, $0, 150                     # $t0 = 50 ticks
        #mtc0  $t0, $11                        # CP0:R11 (Compare Reg.)= $t0
	b   lab4_handler_ret

lab4_handler_ret:
	lw  $v0  s_v0		# restore $v0, $a0, and $at
	lw  $a0, s_a0
	lw  $a1, s_a1
	.set noat
	move $at $k1		# Restore $at
	.set at

	mtc0 $0 $13		# Clear Cause register

	mfc0  $k0 $12		# Set Status register
	ori   $k0 0x1		# Interrupts enabled
	mtc0  $k0 $12
	
	eret			# exception return
# -----------------------------------------------------------


 nop; nop
pyramid:
	  #li $v0, 1; addi $a0, $a0, 0; syscall
	  #li $v0, 1; addi $a1, $a0, 0; syscall  
	  addi $sp, $sp, -12		# allocate frame: $a0, $a1, $ra
	  sw   $a0, 12($sp)		# store $a0= N in caller's frame
	  sw   $a1, 16($sp)		# store $a1= K in caller's frame
	  sw   $ra,  8($sp)		# store $ra in pyramid's frame	

	  li   $t0, 2			# $t0= 2
	  ble  $a0, $t0, pyramid_line	# n <= 2: goto write line
	  addi $a0, $a0, -2		# n= n-2
	  addi $a1, $a1, 1              # k= k+1
	  jal  pyramid

pyramid_line:
	  lb   $a0, char_space		# $a0 = ' '
	  lw   $a1, 16($sp)		# $a1= K
	  jal  write_char

	  lb   $a0, char_fill		# $a0 = '*'
	  lw   $a1, 12($sp)		# $a1= N
	  jal  write_char

	  jal  print_NL			# print NL

	  #jal  write_frame

pyramid_end:
	  lw   $ra, 8($sp)		# restore $ra
	  addi $sp, $sp, 12		# release stack frame
	  jr   $ra  			# return

# ------------------------------
# function write_char ($a0= char, $a1= count)
#
          nop; nop
write_char:
	  beqz  $a1, write_char_end	# $a1 == 0: return
	  li    $v0, 11			# print character
	  syscall
	  addi  $a1, $a1, -1		# $a1 = $a1 -1
	  b     write_char

write_char_end:
	  jr    $ra		        # return
# ------------------------------
# function write_frame ($sp) 
#
	   nop; nop
write_frame:
	   addi  $sp, $sp, -12			  # allocate frame: $ra
	   sw    $ra, 0($sp)			  # store $ra
	   sw    $a0, 4($sp)
	   sw    $a1, 8($sp)
	   # print the frame that starts at $sp + 4

           #la    $a0, str_dash			  # print a separator line
	   #li    $v0, 4; syscall			 

	   #addi  $a0, $sp, 4			  # $a0 = input $sp		 
	   #li    $v0, 1; syscall	      	  # print $sp

	   la	 $a0, str_a0;  li $v0,4; syscall  # print N = 
	   lw	 $a0, 4($sp);  li $v0 1; syscall  # print value
	   #addi    $a0, $a0, 0;  li $v0 1; syscall  # print value

	   la	 $a0, str_a1;  li $v0,4; syscall  # print K = 
	   lw	 $a0, 8($sp);  li $v0 1; syscall  # print value
	   #addi    $a1, $a1, 0;  li $v0 1; syscall  # print value

	   #la	 $a0, str_ra;  li $v0,4; syscall  # print $ra = 
	   #lw	 $a0, 12($sp); li $v0,1; syscall  # print value

	   jal   print_NL      	      	 	  # print NL
	   
	   lw    $a0, 4($sp)
	   lw    $a1, 8($sp)
	   lw    $ra, 0($sp)			  # restore $ra
	   addi  $sp, $sp, 12			  # release frame
	   jr	 $ra

# ------------------------------
# function print_NL()
#
	  nop; nop
print_NL:
          li   $a0, 0xA   # newline character
          li   $v0, 11
          syscall
          jr    $ra
# --------------------------------------------------


