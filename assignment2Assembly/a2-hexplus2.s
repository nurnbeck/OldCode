
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

		.data
msg_prompt:	.asciiz "supply a string\n? "
msg_length:	.asciiz "length= "
msg_terminate:	.asciiz "end of program"
length: 	.word	0
buff:		.space	81


.text

main:	jal  getstr		#get input string

	jal  getlen 		# get string length
	sw   $v0, length 	#store length

	la   $a0, msg_length 	#print length
	li   $v0, 4		#print length= message command
	syscall

	lw   $a0, length	#length is stored in a0
	li   $v0, 1		#system command to print
	syscall

	jal  print_NL		#print newline
	lw   $t1, length	#t1 = length
	lw   $t0, buff		#load the word into buffer
	addiu $t0, $t0, 2       #ADD TWO TO HEX
	jal 	hexToConsole	#jump to printing portion



	li $v0, 10		#exit
	syscall

#----------------
# procedure ’getstr’ 'works'
getstr:
prompt:	la $a0, msg_prompt 	#display prompt
	li $v0, 4		#print system command
	syscall

	la $a0, buff		#read string
	li $a1, 80		#define buff size in memory
	li $v0, 8		#sytem command to read string
	syscall

	jr $ra 			#return from procedure
#----------------
# procedure ’getlen’ 'works' 
getlen:
	li $v0, 8		#default length set		
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
	jr $ra			#jump to return address

# ---------------
# procedure ’print_NL’ 'fine'
print_NL:
	li	$a0, 0xA	#load a new line into a0
	li 	$v0, 11		#new line command
	syscall			#operating system call
	jr	$ra		#jump to return
#--------------------------



hexToConsole:

	li      $t1,58          
	la      $t2,0xf0000000
  


maskAndShift:
	beq     $t0,$zero,exit    #if we hit zero jump to exit
	and     $t3,$t2,$t0       #mask bytes of t0 with t2 our mask and store in t3
	sll     $t0,$t0,4         #shift left 4     
	srl     $t3,$t3,28        #shift right 28
	addi    $t3,$t3,48        #add 48 to prepare for printing
	blt     $t3,$t1,print     #if t3 less than t1 print
	addi    $t3,$t3,39        #increment t3 by 39 to shift into ASCII
	b       print		  #branch to print

print:
	move    $a0,$t3           #move t3 into buff to be printed
	li      $v0,11      
	syscall
	b       maskAndShift

exit:
	j       $ra
