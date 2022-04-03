#include <stdio.h>
#include <stdlib.h>
/* #include "1a.h" */

/*------------------------------------*/

#define max_N_elem 100 // for print_tree_bfs()

/*------------------------------------*/

struct elem {
    int val;
    struct elem * left;
    struct elem * right;
};

/*------------------------------------*/

void add_elem (int x);
struct elem * find_elem (int x);
struct elem * find_prev (int x);
int del_elem (int x);

void print_tree_bfs (struct elem * p);
void add_to_queue (struct elem * p); // for print_tree_bfs()
struct elem * take_from_queue(); // for print_tree_bfs()
int queue_not_empty (); // for print_tree_bfs()

/*------------------------------------*/

struct elem * root;

struct elem * queue[max_N_elem]; // for print_tree_bfs()
int i_beg = 0, i_end = 0, i_layer = 0; // for print_tree_bfs()

/*------------------------------------*/

int main () {
    root = NULL;

    add_elem (8);
    add_elem (3);
    add_elem (10);
    add_elem (2);
    add_elem (6);
    add_elem (9);
    add_elem (14);
    add_elem (1);
    add_elem (4);
    add_elem (7);
    add_elem (13);
    add_elem (15);

    print_tree_bfs(root); putchar ('\n');

    int x;
    scanf("%d", &x);
    if (del_elem (x) == 1)
        printf("There is no such element.\n");

    print_tree_bfs(root); putchar('\n');

    return 0;
}

/*------------------------------------*/

void add_elem (int x) {
    if (find_elem (x) != NULL)
        return;

    struct elem * p = (struct elem *) malloc (sizeof (struct elem));
    p -> val = x;
    p -> left = NULL;
    p -> right = NULL;

    if (root == NULL) {
        root = p;
        return;
    }

    struct elem * q = root;
    while (1) {
        if (x < q -> val) {
            if (q -> left != NULL) {
                q = q -> left;
            } else {
                q -> left = p;
                break;
            }
        } else {
            if (q -> right != NULL) {
                q = q -> right;
            } else {
                q -> right = p;
                break;
            }
        }
    }

    return;
}

/*------------------------------------*/

struct elem * find_elem (int x) {
    if (root == NULL)
        return NULL;

    for (struct elem * i = root; i != NULL; i = (i -> val > x) ? i -> left : i -> right)
        if (i -> val == x)
            return i;

    return NULL;
};

/*------------------------------------*/

struct elem * find_prev (int x) {
    for (struct elem * i = root; i != NULL; i = (i -> val > x) ? i -> left : i -> right)
        if ((i -> left -> val == x) || i -> right -> val == x)
            return i;

    return NULL;
};

/*------------------------------------*/

int del_elem (int x) {
    struct elem * element = find_elem (x);
    struct elem cur;
    cur.left = element -> left;
    cur.right = element -> right;

    if (element == NULL)
        return 1;

    struct elem * repl; //replacement
    if (cur.right == NULL)
        repl = cur.left;
    else {
        repl = cur.right;

        struct elem * i;
        for (i = cur.right; i -> left != NULL; i = i -> left);

        i -> left = cur.left;
    }


    struct elem * prev = find_prev (x);
    if (prev == NULL) // the deleted element was root
        root = repl;
    else {
        if (prev -> val > x) // the deleted element was left descendant
            prev -> left = repl;
        else // the deleted element was right descendant
            prev -> right = repl;
    }

    free(element);

    return 0;
}

/*------------------------------------*/

void print_tree_bfs (struct elem * p) {
    struct elem * q;

    add_to_queue(p);

    while (queue_not_empty ()) {
        q = take_from_queue ();

        printf ("%d ", q -> val);

        add_to_queue (q -> left);
        add_to_queue (q -> right);
    }

    return;
}

void add_to_queue (struct elem * p) {
    if (p == NULL)
        return;

    queue[i_end] = p;
    i_end++;

    return;
}

struct elem * take_from_queue () {
    if (i_beg == i_layer) {
        printf ("\n");

        i_layer = i_end;
    }

    struct elem * q = queue[i_beg];
    i_beg++;

    return q;
}

int queue_not_empty () {
    if (i_beg != i_end)
        return 1;
    return 0;
}
