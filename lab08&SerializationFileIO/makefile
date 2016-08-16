CC := g++
WARN := -Wall -Wextra -Wconversion

# -DNDEBUG disables assert
#CCOPTS := $(WARN) -O -DNDEBUG

# assert is enabled
CCOPTS := $(WARN) -O

compile: copy serialize

copy: copy.c
	$(CC) $(CCOPTS) copy.c -o copy

serialize: serialize.c
	$(CC) $(CCOPTS) serialize.c -o serialize

clean:
	rm -rf copy serialize

