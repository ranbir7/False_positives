
#include <stdio.h>
extern int my_asm();

int main(int argc, char** argv) {

    int result = my_asm();
    printf("The result of the assembly function is: %i\n", result);
    return 0;
}