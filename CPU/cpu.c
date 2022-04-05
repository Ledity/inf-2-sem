#include <stdio.h>
#include <stdlib.h>
/* #include "cpu.h" */

/*------------------------------------*/

int do_inst (char * task);
void mov (int * arg1, int * arg2);
void add (int * arg1, int * arg2);
void sub (int * arg1, int * arg2);
int str2dec (char * op2);

/*------------------------------------*/

int reg[4];
int arg;

/*------------------------------------*/

int main () {
    printf ("Registers: x, y, z, t.\n"
            "Commands: m, a, s, r.\n"
            "Syntax:\n: c <op1> <op2>\n"
            "where c is command, op1 is operand 1 (register only), op2 is operand 2 (register or number).\n: ");

    while (1) {
        char * task = (char *) malloc (20 * sizeof (char));
        scanf ("%s %s %s", task, &task[2], &task[4]);

        int task_code = do_inst (task);
        switch (task_code) {
            case 0:
                for (int i = 0; i < 4; i++) {
                    printf ("%d ", reg[i]);
                }

                printf ("\n: ");
                break;

            case 1:
                printf ("Exiting...\n");
                return 0;
                break;

            case 2:
                printf (" # ERROR: Unknown command.\n: ");
                break;

            case 3:
                printf (" # ERROR: operand 1 is not a register.\n: ");
                break;

            default:
                for (int i = 0; i < 4; i++) {
                    printf ("%d ", reg[i]);
                }

                printf ("\n: ");
                break;
        }
    }

    return 0;
}

/*------------------------------------*/

int str2dec (char * op2) {
    int ans = 0;

    for (int i = 0; op2[i] != '\0'; i++) {
        ans = ans * 10;
        ans += op2[i] - '0';
    }

    return ans;
}

/*------------------------------------*/

int do_inst (char * task) {
    void (* inst) (int * a1, int * a2);
    int * arg1, * arg2;

    switch (task[0]) {
        case 'm':
            inst = mov;
            break;

        case 'a':
            inst = add;
            break;

        case 's':
            inst = sub;
            break;

        case 'r':
            return 1;
            break;

        default:
            return 2;
            break;
    }

    switch (task[2]) {
        case 'x':
            arg1 = &reg[0];
            break;

        case 'y':
            arg1 = &reg[1];
            break;

        case 'z':
            arg1 = &reg[2];
            break;

        case 't':
            arg1 = &reg[3];
            break;

        default:
            return 3;
            break;
    }

    switch (task[4]) {
        case 'x':
            arg2 = &reg[0];
            break;

        case 'y':
            arg2 = &reg[1];
            break;

        case 'z':
            arg2 = &reg[2];
            break;

        case 't':
            arg2 = &reg[3];
            break;

        default:
            if (task[4] >= '0' && task[4] <= '9') {
                arg = str2dec (&task[4]);
                arg2 = &arg;
            } else {
                return 3;
            }
            break;
    }

    inst (arg1, arg2);

    return 0;
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
