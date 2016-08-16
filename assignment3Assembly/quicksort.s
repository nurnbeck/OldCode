	
#---------------------------------------------------------------
# Assignment:           3
# Due Date:             March 11, 2016
# Name:                 Nolan Beck
# Unix ID:              nbeck
# Lecture Section:      B1
# Lab Section:          H04 (Thursday 2:00-4:50)
# Teaching Assistant(s):   Rodolfo Wottrich
#---------------------------------------------------------------

#had inspration from from youtuber 
#Quasar Distant's how to videos

.data
	L: .word 2, 1, 9, 14, 22, 42, 50, 5, 22, 22, 0

.text
	main:
		# s0 is the index of pivot
		# s1 is the value of pivot
		# s2 is the index of border
		# s3 is the index of last
		# s4 is the counter for sorting
		# s5 is the pivot + 1s
	  	li $s0, 0 #0x10
		jal getlen		#we acquire length of L and store in $t0
		li $s7, 4		#store 4 in s7 for adjustment to bytes with $t0
		mult $t0, $s7		#mulitply length of array L by 4 to find number of bytes
		mflo $t0		#move resulting byte numer from low register into t0
		move $s3, $t0		#the total number of bytes in L = index of last element

	
		la $t8, 0($sp)		#t8 is loaded with base address of stack
		sw $s0, 0($sp)		#store index of pivot at base address of stack
		addi $sp, $sp, -4	#allocate room for a word in the stack
		sw $s3, 0($sp)		#store the index of last at new stack location
		addi $sp, $sp, -4	#allocate room for another word on stack
		la $t9, 0($sp)		#store address of the base address of stack
		
		#if our t8(beggining of sub array) = t9(end of array)
		#then we have completely sorting our array
		# otherwise we have to load the index of pivot and index of last and continue
		outer_loop:
			beq $t8, $t9, done	
			addi $sp, $sp, 4
			lw $s3, 0($sp)
			addi $sp, $sp, 4
			lw $s0, 0($sp)
			la $t9, 0($sp) 
			# ---------------------------------------------		

			inner_loop:
				beq $s0, $s3, outer_loop
				
				addi $s2, $s0, 4		#update index of border
				addi $s5, $s0, 4		#update pivot
				addi $s4, $s0, 4		#update counter
	
				lw $s1, L($s0)
				sort_loop:
						beq $s3, $s4, next	#proceed through array if index equals counter
						lw $s6, L($s5)	
						blt $s6, $s1, assign	# number to let is less than wat it is compared to,swap
						continue:
						addi $s4, $s4, 4	 # increment counter
						addi $s5, $s5, 4	 # increment pivot
						b sort_loop
					
					#perform swaps across
					#s2->s7 s2->26 and then s5->s7
					assign:
						lw $s7, L($s2)		
						sw $s6, L($s2)		
						sw $s7, L($s5)
						addi $s2, $s2, 4	# increment index of 										# border		
						b continue
					next :
						sw $s2, 0($sp)		# store splitpoint+1 into $a1
						addi $sp, $sp, -4	#allocate stack room
						sw $s3, 0($sp)		#store last's index
						addi $sp, $sp, -4	#allocate stack room
						la $t9, 0($sp)		#end of stacks address
						addi $s2, $s2, -4	#index of border
						lw $s7, L($s2)		#perfom our swap
						sw $s1, L($s2)
						sw $s7, L($s0)
						move $s3, $s2
						b inner_loop
						

			done:
				j print		#finised! print results
				#li $v0, 10
				#syscall
getlen:
	li   $a0, 0x28   # print a "("
        li   $v0, 11
        syscall
	la $a0, L		# push address of L into $a0
	move $t0, $zero		# initiate a counter to find strlen
strloop:
	lw   $t1, 0($a0)	# load first number of our array to count into $t1
	beqz $t1, exit		# checks if current char is a 0, if 0 we have count
	#beq  $t1, 0xA, exit	# checks if current char is  
	addi $a0, $a0, 4	# +1 to where the characer is
	addi $t0, $t0, 1 	# +1 to count
	j strloop
exit:
	move $s8, $t0		# $v0 = $t0
	jr $ra

print:
	la $a1, L		#push adress of sorted array into $a1
loop:
	lw  $a0, 0($a1)		#load a portion of a1 in a0, from first - last element
	beqz $a0, printdone 	#finish printing if we come across trailing zero of array
	li $v0, 1	
	syscall

	jal print_c	#print a comma in between numbers for tidy output

	#UPDATE ADDRESS
	addiu $a1, $a1, 4

	j loop		#loop 

printdone:
	li   $a0, 0x29   # print a ")"
        li   $v0, 11
        syscall
	li $v0, 10 #printing complete and end quicksort
	syscall

	  nop; nop

print_c:
          li   $a0, 0x2c   # print a ","
          li   $v0, 11
          syscall
          jr    $ra

print_NL:
          li   $a0, 0xA   # newline character
          li   $v0, 11
          syscall
          jr    $ra
