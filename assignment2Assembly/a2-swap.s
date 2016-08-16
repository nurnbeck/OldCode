
# The following format is required for all submissions in CMPUT 229
	
#---------------------------------------------------------------
# Assignment:           1
# Due Date:             January 29, 2016
# Name:                 Nolan Beck
# Unix ID:              nbeck
# Lecture Section:      B1
# Lab Section:          H04 (Thursday 2:00-4:50)
# Teaching Assistant(s):   Rodolfo Wottrich
#---------------------------------------------------------------

# --------------- Data Segment -----------
		.data
msg_prompt:	.asciiz "supply a string\n? "
msg_length:	.asciiz "length= "
msg:	.asciiz "end of program"
length: 	.word	0
buff:		.space	81

# --------------- Text Segment -----------
	.text
main:	jal  getstr		#get input string

	jal  getlen 		# get string length
	sw   $v0, length 	#store length

	la   $a0, msg_length 	#print length
	li   $v0, 4
	syscall

	lw   $a0, length	#print our variable
	li   $v0, 1
	syscall

	jal  print_NL		#print newline

	lw   $t1, length	#t1 = length
	la $t2, buff		# load address starting from first char
	la $t3, buff		#load address of buff into t3
	addi $t3, $t3, 1	#increment t3 by one
	


#fixed
loop:	addi $t1, -1           	# $t1= $t1 - 1 
	bltz $t1, next	      	# if (t1 < 0 ) goto next

	lb $a0, ($t3)		#load first byte of t3 into a0
	li $v0, 11		#new line system command
	addi $t4, $t3, 0	#add immeadiate zero and store result into t4 
	syscall			#operating system call
	
	lb $a0, ($t2)		#load byte from t2 into a0
	li $v0, 11		#add a newline character
	addi $t4, $t2, 0	#store rest of t2 into t4
	syscall
	
	addi $t2, $t2, 2	# go to next char
	addi $t3, $t3, 2	# add 2 at the end	

	b loop


next:
#            ... more user code ...

	la $a0, msg		# prints terminating message
	li $v0, 4		# system command
	syscall

	jal print_NL		#print a New line for attractive output
	lw $a3, ($t4)		#load address of t4
	li $v0, 1		#load instruction print int
	syscall

	li $v0, 10		#exit
	syscall

#----------------
# procedure ’getstr’ 'works'
getstr:
prompt:	la $a0, msg_prompt 	#display prompt
	li $v0, 4
	syscall

	la $a0, buff		#read string
	li $a1, 80
	li $v0, 8
	syscall

	jr $ra 			#return from procedure
#----------------
# procedure ’getlen’ 'works' 
getlen:
	li $v0, 8
	li $t0, 0		#initialize a counter
loop2:
	lbu $t1, 0($a0)		#set pointer to address $a0 (start of buff)
	beqz $t1, done 		#Branches to "done" at the null character.
	addi $a0, $a0, 1 	#increment character
	addi $t0, $t0, 1 	#increment counter
	j loop2

done:
	move $v0, $t0		#store our counter to be printed
	#addi $t0, $t0, -1	# -1 to stored value at $t0
	addi $v0, $v0, -1 	#remove excess from loop2
	jr $ra

# ---------------
# procedure ’print_NL’ 'fine'
print_NL:
	li	$a0, 0xA
	li 	$v0, 11
	syscall
	jr	$ra
#--------------------------


