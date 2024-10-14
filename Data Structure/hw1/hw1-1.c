#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void caesar_func(char* text, int shift) {
    for (int j = 0; j < strlen(text); j++) {
        if (text[j] >= 'A' && text[j] <= 'Z')
            text[j] = (text[j] - 'A' - shift + 26) % 26 + 'A';
        else if (text[j] >= 'a' && text[j] <= 'z')
            text[j] = (text[j] - 'a' - shift + 26) % 26 + 'a';
    }
}

void zigzag_func(char* text, int row, int letters_num, char** answer) {
    if (row == 1) { // special case
        strcpy(*answer, text);
        return;
    }

    // compute letters and unit, which is a small matrix row*row but not including element (0, row)
    // a unit contains 2*(row-1) letters, e.g. row = 3, a unit contains 4 letters
    // use unit to compute amounts of columns
    int unit = 2 * (row - 1);
    int unit_numbers = letters_num / unit;
    int unit_remainder = letters_num % unit;
    int column = unit_numbers * (row - 1); 
    if (unit_remainder) {
        if (unit_remainder <= row)
            column++;
        else
            column += unit_remainder - row + 1;
    }

    char** matrix = (char**)malloc(row * sizeof(char*)); // 2D-array
    for (int i = 0; i < row; i++)
        matrix[i] = (char*)calloc(column, sizeof(char));
    
    int row_elements[row]; // count the numbers of element in one row
    memset(row_elements, 0, sizeof(int) * row);
    for (int r = 0; r < row; r++) {
        if (r == 0 || r == unit / 2) {
            row_elements[r] = unit_numbers;
            // if there's unit_remainder in the row, row_element++
            row_elements[r] += (unit_remainder > r ? 1 : 0); 
        } else {
            row_elements[r] = unit_numbers * 2;
            if (unit_remainder > 2 * row - 2 - r)
                row_elements[r] += 2;
            else if (unit_remainder > r)
                row_elements[r]++;
        }
    }
    
    int index = 0;
    for (int r = 0; r < row; r++) { // row-by-row processing
        int col_count = 0;
        int element_count = 0; // count the numbers of elements in one row to avoid element place error
        while (col_count < column && index < letters_num) {
            if ((r == 0 || r == unit / 2) && element_count < row_elements[r]) { // one element a row
                matrix[r][col_count] = text[index];
                index++;
                element_count++;
            } else if (element_count < row_elements[r]) { // two elements a row
                matrix[r][col_count] = text[index];
                index++;
                element_count++;
                if (element_count >= row_elements[r])
                    break;
                matrix[r][col_count + (row - 1 - r)] = text[index];
                index++;
                element_count++;
            }
            col_count += (row - 1);
        }
    }

    index = 0;
    for (int c = 0; c < column; c++) { // column-by-column printing
        for (int r = 0; r < row; r++) {
            if (matrix[r][c] != '\0') {
                (*answer)[index] = matrix[r][c];
                index++;
            }
        }
    }
    (*answer)[index] = '\0';

    for (int i = 0; i < row; i++)
        free(matrix[i]);
    free(matrix);
}

int main() {
    int n;
    scanf("%d", &n);

    char** answer = (char**)malloc(n * sizeof(char*));
    for (int i = 0; i < n; i++) {
        answer[i] = (char*)calloc(501, sizeof(char));
    }

    for (int i = 0; i < n; i++) {
        char cipher[501];
        for (int j = 0; j < 501; j++) {
            cipher[j] = '\0';
        }
        getchar();
        scanf("%s", cipher);
        cipher[strcspn(cipher, "\n")] = '\0';
        cipher[strcspn(cipher, "\r")] = '\0';
        int caesar, row;
        scanf("%d", &caesar);
        scanf("%d", &row);
        
        caesar_func(cipher, caesar);
        
        zigzag_func(cipher, row, strlen(cipher), &answer[i]);
    }

    for (int i = 0; i < n; i++)
        printf("%s\n", answer[i]);

    for (int i = 0; i < n; i++) {
        free(answer[i]);
    }
    free(answer);
    return 0;
}
