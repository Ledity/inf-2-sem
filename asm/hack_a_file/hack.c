#include <stdio.h>
#include <stdlib.h>
#include <string.h>
/* #include "hack.h" */

/*------------------------------------*/

char find_str (char * string, FILE * file, fpos_t * answer);

/*------------------------------------*/

int main (int argc, char* argv[]) {

    FILE *file = fopen(argv[1], "r+");

    if (file == NULL) {
        fprintf (stderr, "# Couldn't read the file\n");

        return 2;
    }

    char *hello = "Hello, world!", *goodbye = "Kill 'em all!";
    fpos_t pos_H;
    char success = find_str (hello, file, &pos_H);

    if (!success)
        return 1;

    fsetpos (file, &pos_H);
    for (int i = 0; i < strlen(hello); i++) {
        getc (file);
    }

    fsetpos (file, &pos_H);
    for (int i = 0; i < strlen(goodbye); i++) {
        putc (goodbye[i], file);
    }

    fclose(file);
    return 0;
}

/*------------------------------------*/

char find_str (char * string, FILE * file, fpos_t *answer) {
    int iter = 0;
    int byte;
    int str_len = strlen (string);

    do {
        fpos_t temp;
        fgetpos (file, &temp);
        byte = fgetc(file);

        if (byte == 'H')
            *answer = temp;

        if (byte == string[iter])
            iter++;

        if (iter >= str_len)
            return 1;
    } while (byte != EOF);

    return 0;
}
