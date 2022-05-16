#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <unistd.h>
/* #include "hack_a_func.h" */

/*------------------------------------*/

void honestfunc1();
void honestfunc2();
void hackerfunc();
int change_page_permissions_of_address(void *addr);

/*------------------------------------*/

int main() {
    hackerfunc();
    printf ("Купил мужик шляпу...\n");
    honestfunc1();

    return 0;
}

void honestfunc1() {
    printf ("\t...а она ему как раз!\n");

    return;
}

void honestfunc2() {
    printf ("\t...сел в нее и попылыл (этим мужиком был мальчик с пальчик)!\n");

    return;
}

void hackerfunc() {
    int res = change_page_permissions_of_address ((void*)honestfunc1);

    unsigned char * honf1 = (unsigned char*)honestfunc1;
    *honf1 = 0xeb;
    *(honf1 + 1) = honestfunc2 - honestfunc1 - 2;

    return;
}

int change_page_permissions_of_address(void *addr) {
    size_t page_size = sysconf(_SC_PAGE_SIZE);
    addr -= (unsigned long)addr % page_size;

    if(mprotect(addr, page_size, PROT_READ | PROT_WRITE | PROT_EXEC) == -1) {
        return -1;
    }

    return 0;
}
