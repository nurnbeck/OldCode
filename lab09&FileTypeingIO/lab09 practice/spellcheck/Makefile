CC = g++
CFLAGS = -Wall -Wextra -Wconversion -std=c++0x

all: spellcheck

clean:
	rm -f spellcheck *.o *~

spellcheck: spellcheck.o util.o
	$(CC) -o spellcheck spellcheck.o util.o

spellcheck.o: spellcheck.cpp util.hpp
	$(CC) $(CFLAGS) -o spellcheck.o -c spellcheck.cpp

util.o: util.cpp util.hpp
	$(CC) $(CFLAGS) -o util.o -c util.cpp
