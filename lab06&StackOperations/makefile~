TARGET= stack
MODULES= StackMain.o SList.o Stack.o
#uncomment for UNIX code.
CCOPTS := -Wall -Wextra -Wconversion -O
CC := g++ -DUNIX

# uncomment for windows code.
#CCOPTS := -Wall -Wextra -Wconversion -O
#CC := g++ -DWINDOWS

$(TARGET):$(MODULES)
	$(CC) $(CCOPTS) -o $(TARGET) $(MODULES)

StackMain.o : StackMain.c Stack.c SList.c
	$(CC) $(CCOPTS) -c StackMain.c

Stack.o : Stack.c SList.c
	$(CC) $(CCOPTS) -c Stack.c

Slist.o : SList.c
	$(CC) $(CCOPTS) -c SList.c

clean:
	/bin/rm -f *-o* -$(TARGET)
