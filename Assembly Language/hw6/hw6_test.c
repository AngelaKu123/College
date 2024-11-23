#include <stdio.h>
#include <stdlib.h>

extern void maxPool(int*, int, int, int*);

int main() {
    int n = 5;
    int m = 5;
    int input_matrix[5][5] = {
        1, 2, 3, 4, 5,
        6, 7, 8, 9, 0,
        3, 2, 1, 4, 2,
        1, 2, 0, 4, 5,
        9, 2, 8, 4, 1
    };
    int *output_matrix = (int*)malloc(sizeof(int) * 9);

    maxPool((int*)input_matrix, n, m, (int*)output_matrix);

    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
            printf("%d ", output_matrix[i * 3 + j]);
        }
        printf("\n");
    }
    free(output_matrix);

    return 0;
}