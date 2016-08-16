	
#---------------------------------------------------------------
# Assignment:           4
# Due Date:             April 1, 2016
# Name:                 Nolan Beck
# Unix ID:              nbeck
# Lecture Section:      B1
# Lab Section:          H04 (Thursday 2:00-4:50)
# Teaching Assistant(s):   Rodolfo Wottric
#---------------------------------------------------------------

PART 1:
Works with default handler file (lab4-exception.s). All files necessary are included

xspim -mapped_io -exception_file lab4-exception.s -file a4-pyramid.s


use keys : i d r l q

as to specifications: 
i will increase
d will decrease
l will move pyramid left
r will move pyramid right
q will quit


PART 2:
Works with default handler file (lab4-exception.s) All files necessary are included

xspim -mapped_io -exception_file  lab4-exception.s -file a4-random.s

input any keystrokes, they will be saved and used to create a pseudo-random number.

pseudo random number takes sum of all characters in the buffer, then xor this value
with stack pointer and takes this resulting value mod 100. 

This process repeats after a set time interval.
