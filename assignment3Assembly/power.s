	
#---------------------------------------------------------------
# Assignment:           3
# Due Date:             March 11, 2016
# Name:                 Nolan Beck
# Unix ID:              nbeck
# Lecture Section:      B1
# Lab Section:          H04 (Thursday 2:00-4:50)
# Teaching Assistant(s):   Rodolfo Wottrich
#---------------------------------------------------------------

#had inspiration from a video doing a factorial program on youtube
#https://www.youtube.com/watch?v=B6ky4Weahm4

.data
str:    .asciiz " Enter X:"
str1:   .asciiz " Enter N:"
str2:   .asciiz " X to the power of N is : "

X:      .half 3 #store positive x
	.align 2
N:      .half 10  #store positive N
result: .word 0  #stores result
str_addr:   .asciiz "address: "
str_a0:	    .asciiz "| a0 / 0($sp)*n(x)= "
str_a1:     .asciiz "  a1 / 4($sp)(N)= "
str_a2:     .asciiz "  a3 / 8($sp)(res addr) = "
str_ra:	    .asciiz "  a2 / 12($sp)*n = "
frame:  .asciiz  "-----------------------Stack frame----------------------------\n"

#a0 = x
#a1 = n
#a2 = return address
#a3 = result address
.text
	.globl main
	main:
		subu $sp, $sp, 16 # allocate room for a0-a3

		#UNCOMMENT TO ENABLE USER INPUT 
						#prompt for X
		#la $a0,str; li $v0,4; syscall
		#li $v0,5; syscall 		#store X in V0
		
		#move $t0,$v0			# x now in t0
		
						#prompt for N
		#la $a0,str1; li $v0,4; syscall
		#li $v0,5			# n now in v0 
		#syscall
		
		#MODIFY THESE TO CHANGE X AND N RESPECTIVELY
		li  $a0, 3			#$a0 = X
		li  $a1, 4	 		#$a1 = N
		
		#UNCOMMENT TO ENABLE USER INPUT
		#move $a0, $t0   		#$a0=X
		#move $a1, $v0    		#$a1=N
		
		sw $a0, X 			#now "X" has user inputted X
		sw $a1, N			# N has a1's N
		li $a2, 1			#$a2 is set to one for 1*X^N logic for result
		sw $a2, result			#get base value to work off of
		sw $a0, 0($sp)			#store X at 0
		#addi $a1, $a1, 1		#solves case of powXN(0)
		sw $a1, 4($sp)
		sw $a2, 8($sp)
#--------------------------------------------------------------
		#call pow and start recursion

		jal powXN
		
		#display results
		li $v0, 4; la $a0, str2; syscall 	# print X^N is:
		li $v0, 1; lw $a0, result; syscall	# and print number
		
		#exit
		li $v0, 10; syscall

.globl powXN
powXN:

	subu $sp, $sp, 16 	# allocate room for a0-a3
	lw $a0, 16($sp)		#acquire preiously stored values to work from
	lw $a1, 20($sp)		
	lw $a2, 24($sp)		
	
	#this is storing return addres in stack
	sw $ra, 12($sp)		#store return address in 12($sp)
	sw $a0, 0($sp)		#store X at 0
	sw $a1, 4($sp)		#store N at 4
	sw $a2, 8($sp)		#store result address at 8
	
#----------------------------------------------------------
	#base case
	li $v0, 0	  #v0 = 0
	beq, $a1, 0, done #if N(v0) = 0 stop.
#-----------------------------------------------------------
	#find pow(x,n-1)
	sub $a1, $a1, 1		#decrement N (becomes N-1)
	sw $a1, 4($sp)		#store N-1
	jal clear_reg		#CALL CLEAR REGISTERS
	#print_frame
	jal powXN		#recursive call PowXN(X,N-1)
#-----------------------------------------------------------
	#multiply all resulting values
	#by grabbing address of result
	#and multiplying it
	lw $a0, 0($sp)
	la $s0, result				#$s0 becomes the
	lw $a2, ($s0)  				#a2 = contents at location stored in result
	mul $a2, $a2, $a0			# multiply result by x

	sw $a2, result				#store the resutls of our multiplication
#-----------------------------------------------------------
	done:
		jal print_frame
		lw $ra, 12($sp)			#Here grab our values from the stack to begin recursing
		lw $a0, 0($sp)			#a0 equals x
		lw $a1, 4($sp)			#a1 equals n
		addu $sp, $sp, 16 		#dissolve created space
		#jal print_frame		#PRINT THE FRAMES OF THE CALL
		jr $ra

#------------------------------------------------------------
clear_reg:
	li $a0,0		#clear $a0
	li $a1,0		#clear $a1
	li $a2,0		#clear $a2
	li $a3,0		#clear $a3
	jr $ra			#return

#------------------------------------------------------------
print_frame:
	addi	$sp, $sp, -4			 # allocate frame: $ra
	sw	$ra, 0($sp)			 # store $ra
	sw	$a0, 4($sp)			 # store X in 4(sp) so it is not overwritten

	# print the frame that starts at $sp + 4

        la	$a0, frame			 # print a separator line
	li	$v0, 4; syscall

	la	$a0, str_addr			 # print "address"
	li	$v0, 4; syscall
			 

	addi	$a0, $sp, 4			 # $a0 = input $sp		 
	li	$v0, 1; syscall	      	  	 # print $sp

	la	$a0, str_a0;  li $v0,4; syscall  # print $a0 = 
	lw	$a0, 4($sp);  li $v0 1; syscall  # print X

	jal   	print_NL 	

        la	$a0, frame			 # print a separator line
	li	$v0, 4; syscall

	la	$a0, str_addr			 # print "address"
	li	$v0, 4; syscall
	
	addi	$a0, $a0, 4			 # $a0 = input $sp		 
	li	$v0, 1; syscall	      	  	 # print $sp	

	la	$a0, str_a1;  li $v0,4; syscall  # print $a1 = 
	lw	$a0, 8($sp);  li $v0 1; syscall  # print N

	jal   	print_NL 

        la	$a0, frame			 # print a separator line
	li	$v0, 4; syscall

	la	$a0, str_addr			 # print "address"
	li	$v0, 4; syscall

	addi	$a0, $a0, 4			 # $a0 = input $sp		 
	li	$v0, 1; syscall	      	  	 # print $sp	

	la	$a0, str_a2;  li $v0,4; syscall  # print $a2 = 
	lw	$a0, 12($sp);  li $v0 1; syscall  # print N

	jal   	print_NL 

        la	$a0, frame			 # print a separator line
	li	$v0, 4; syscall

	la	$a0, str_addr			 # print "address"
	li	$v0, 4; syscall

	addi	$a0, $a0, 4			 # $a0 = input $sp		 
	li	$v0, 1; syscall	      	  	 # print $sp		

	la	$a0, str_ra;  li $v0,4; syscall  # print $ra = 
	lw	$a0, 16($sp); li $v0,1; syscall  # print return address

	jal   	print_NL      	      	 	 # print NL
	lw	$a0, 4($sp)			 # retrieve X from memory
	lw	$ra, 0($sp)			 # restore $ra
	lw      $a1, 8($sp)
	addi	$sp, $sp, 4			 # release frame

#-----------------------------------------------
	jr	$ra				#return to
	  nop; nop
print_NL:
          li   $a0, 0xA   # newline character
          li   $v0, 11
          syscall
          jr    $ra
