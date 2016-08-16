#include <stdio.h>

void printHex(unsigned char *p, int size)
{
    int b;
    for ( b = size - 1; b >= 0; b--){
        printf(" %02x", p[ b ]);
    }
    printf("\n");
}

int main()
{
    int x = 17;
    int y = 0x12345678;
    
    printHex((unsigned char *) &y, sizeof(y));
    return 0;
}