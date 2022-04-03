#include <stdio.h>
#include <stdlib.h>
/* #include "cpu.h" */

/*------------------------------------*/

void mov (int * arg1, int * arg2);
void add (int * arg1, int * arg2);
void sub (int * arg1, int * arg2);
int str2dec (char * op2);

/*------------------------------------*/

int main () {
    int reg[4];
    int arg;

    printf ("Registers: a, b, c, d.\n"
            "Commands: m, a, s, r.\n"
            "Syntax:\n: c <op1> <op2>\n"
            "where c is command, op1 is operand 1 (register only), op2 is operand 2 (register or number)\n: ");

    while (1) {
        char inst, op1, space, op2[10];
        scanf("%c%c%c%c%s", &inst, &space, &op1, &space, &op2);

        int * oper1, * oper2;

        switch (op1) {
            case 'a':
                oper1 = &reg[0];
                break;

            case 'b':
                oper1 = &reg[0];
                break;

            case 'c':
                oper1 = &reg[0];
                break;

            case 'd':
                oper1 = &reg[0];
                break;

            default:
                printf (" # ERROR: operator 1 is not a register.\n: ");
                continue;
                break;
        }

        switch ((char) *op2) {
            case 'a':
                oper2 = &reg[0];
                break;

            case 'b':
                oper2 = &reg[1];
                break;

            case 'c':
                oper2 = &reg[2];
                break;

            case 'd':
                oper2 = &reg[3];
                break;

            default:
                if (op2[0] >= '0' && op2[0] <= '9') {
                    arg = str2dec (op2);

                    oper2 = &arg;
                } else {
                    printf (" # ERROR: operator 2 is neither a register nor a number.\n: ");

                    continue;
                }
                break;
        }

        switch (inst) {
            case 'm':
                mov (oper1, oper2);
                break;

            case 'a':
                add (oper1, oper2);
                break;

            case 's':
                sub (oper1, oper2);
                break;
        }

        for (int i; i < 4; i++)
            printf("%d ", reg[i]);

        printf ("\n: ");

        char a = '0';
        while (a != EOF)
            a = getchar ();
    }

    return 0;
}

/*------------------------------------*/

int str2dec (char * op2) {
    int ans = 0;

    for (int i = 0; op2[i] != '\0'; i++)
        ans += op2[i] - '0';

    return ans;
}

/*------------------------------------*/

void mov (int * arg1, int * arg2) {
    *arg1 = *arg2;
}
void add (int * arg1, int * arg2) {
    *arg1 += *arg2;
}
void sub (int * arg1, int * arg2) {
    *arg1 -= *arg2;
}
