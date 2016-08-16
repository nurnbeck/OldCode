CC := g++
MODULES := byteMain.o byteArray.o
WARN := -Wall -Wextra -Wconversion

# -DNDEBUG disables assert
#CCOPTS := $(WARN) -O -DNDEBUG

# assert is enabled
CCOPTS := $(WARN) -O


byteArray: byteArray.o byteMain.o
	$(CC) $(CCOPTS) -o byteArray $(MODULES)

byteArray.o: byteArray.c byteArray.h
	$(CC) $(CCOPTS) -c byteArray.c

byteMain.o: byteMain.c byteArray.h
	$(CC) $(CCOPTS) -c byteMain.c

clean:
	rm -rf *.o byteArray

