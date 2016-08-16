
# The following format is required for all submissions in CMPUT 229
	
#---------------------------------------------------------------
# Assignment:           2
# Due Date:             January 29, 2016
# Name:                 Nolan Beck
# Unix ID:              nbeck
# Lecture Section:      B1
# Lab Section:          H04 (Thursday 2:00-4:50)
# Teaching Assistant(s):   Rodolfo Wottrich
#---------------------------------------------------------------
#---------------DATA----------
	.data
prompt_main:	.asciiz "main string: "
prompt_old:	.asciiz "old string: "
prompt_new:	.asciiz "new string: "
msg_length:	.asciiz "length = "
msg_terminate:	.asciiz "end of program\n"
	
main_length:	.word  0
old_length:	.word  0
new_length:	.word  0
strMain:	.space 81
strOld:		.space 81
strNew:		.space 81
output:		.space 81
test:		.space 81

	.text
main:
	jal getMain           	# get main string
	jal getOld		# get old string to replace
	jal getNew		# get new string to replace with
	
	la $a0, strMain		#load main
	jal getlen           	# get string length
	sw $v0, main_length     # store length

	la $a0, strOld		#load old
	jal getlen		#get length of old
	sw $v0, old_length

	la $a0, strNew		#load new
	jal getlen		#get length of old
	sw $v0, new_length
	
	
	
	jal print_NL         	# print newline
#         .... more user code ......

	lw $t1, main_length     # $t1= main_length
	lw $t6, old_length
	la $t2, strMain		# load address starting from first char
	la $t0, output
	la $t3, strOld
	la $t7, strNew		#load address of New
	move $t8, $zero		# counter to count for position (to reset position of oldstr and new)


#----------primary loop to move through Main
	#store letters of main into a buffer 
	#at first part of list and iterate through
	#stop iterating once buffer is as long as StrOld
	#compare(maybe replace) them then move one 
	#letter forward and repeat until we encounter the endline
	#lbu   $t5, 0($a3)	#initialize pointer to traverse main

	#for each char in main compare chars to first char of old
traverse:	
	lw $t6, old_length
	lw $t9, new_length
	#la $t7, strNew		#load address of New
	addi $t1, -1           	# $t1= $t1 - 1 
	bltz $t1, next	      	# if (t1 < 0 ) goto next
	lb $t4, 0($t2)		# load x-char of strMain
	lb $t5, 0($t3)		# load x-char of strOld
	beq $t4, $t5, compare	# check if char in str and old are equal
				# go to equal if equal
	sb $t4, 0($t0)		# store if not equal
	
	addi  $t2, 1 		# increment strMain position by 1
	addi  $t0, 1 		# increment output position by 1
	b traverse

	#len of buff is equal to len of strOld
	#compare buffer with strOld
	#if two are equal call replace
	#then move index forward one and reset buffer counter
	#and buffer and prepare to repeat traverse loop until we have
	#a string the correct length to compare to strOld
#-----------function to compare buffer to strOld----------------
compare:addi $t6, -2		# decrement by 2 because of the loop
	bltz $t6, replace	#if we load an endline we stop
	addi $t1, -1 		# decrements the main_length
	addi $t2, 1 		# increment strMain position
	addi $t3, 1 		# increment oldStr position
	addi $t8, 1 		# add 1 to counter
	lb $t4, 0($t2)		# load byte of main to be compared
	lb $t5, 0($t2)		# load byte of old to be compared
	beq $t4, $t5, compare	# if x char of main = old compare
	j next
	

	#if the two are equal we replace
	#load bytes to replace strOld with strNew
	#so we need to load a letter of strNew into a register
	#then we store that letter of new into strMain
	#at proper location of memory
	#and move pointer forward length of buffer
	#and clear buffer and buffer length
#----------loop to replace and traverse through the buffer
	
replace:
	#li   $s0, 0		#initiate index to keep track of how far into
				#strNew we are
	#sub  $a3, $a3, $v0	#set main pointer to point to start of
				#portion to be replaced
	#lb   $t6, 0($a2)	#grab proper byte from strNew
	#sb   $t6, 0($t0)	#store byte in location in strMain
	#addi $a3, $a3, 1	#increment the index(pointer) to next letter
	#addi $v0, $v0, -1	#decrement buffer counter for letters replaced
	#beqz $v0, traverse	#if buffer counter is equal to zero, return
	#j traverse
	
	addi $t9, -1		#new length -1
	bltz $t9, reset	#if we hit null return to traverse
	lb $t4, 0($t7)		#store old into main
	sb $t4, 0($t0)		#store old into main
	addi $t7, 1		#increment
	addi $t0, 1		#increment
	la $t3, strOld		#load our old string address in
	lw $t6, old_length	#load old length into t6 for future reference
	b replace		#loop again

reset:
	addi $t2, 1		#
	b traverse

next:
#            ... more user code ...
	la $a0, output
	li $v0, 4
	syscall
	
	jal print_NL
	
	la $a0, msg_terminate	# prints terminating message
	li $v0, 4
	syscall
	
	li $v0, 10           	# exit
	syscall

#-------------

#exit:
#	li $v0, 10		#exit
#	syscall

#-----------------------------------------------------------------
#-----------------------------------------------------------------
#--------------------
# procedure 'getlen'
getlen:
	move $t0, $zero
strloop:
	lb   $t1, 0($a0)
	beqz $t1, exit		# checks if current char is a NULL
	beq  $t1, 0xA, exit	# checks if current char is  
	addi $a0, $a0, 1 	# +1 to where the characer is
	addi $t0, $t0, 1 	# +1 to count
	j strloop
exit:
	move $v0, $t0		# $v0 = $t0
	jr $ra
#-------------
# procedure 'getMain'
getMain:
	la $a0, prompt_main      # display prompt
	li $v0, 4
	syscall

	la $a0, strMain         # read string 
	li $a1, 81
	li $v0, 8
	syscall

	jr $ra               	# return from procedure
	
#-------------
# procedure 'getOld'
getOld:
	la $a0, prompt_old      # display prompt
	li $v0, 4
	syscall

	la $a0, strOld         	# read string 
	li $a1, 81
	li $v0, 8
	syscall

	jr $ra               	# return from procedure
	
#-------------	
# procedure 'getNew'
getNew:
	la $a0, prompt_new      # display prompt
	li $v0, 4
	syscall

	la $a0, strNew         	# read string 
	li $a1, 81
	li $v0, 8
	syscall

	jr $ra               	# return from procedure 
#---------------------
# procedure 'print_NL'
print_NL:
	li $a0, 0xA          	# newline character
	li $v0, 11
	syscall
	jr $ra
#--------------------------#
