/*
S -> L . R { S.val := L.int + R.int / 2 ^ R.len }
L -> B Ls { L.len := Ls.len + 1 ; L.int := B.bit * 2 ^ Ls.len + Ls.int }
Ls -> B Ls₁ { Ls.len := Ls₁.len + 1 ; Ls.int := B.bit * 2 ^ Ls₁.len + Ls₁.int }
Ls -> ε { Ls.len := 0 ; Ls.int := 0 }
R -> B Rs { R.len := Rs.len + 1 ; R.int := B.bit * 2 ^ Rs.len + Rs.int }
Rs -> B Rs₁ { Rs.len := Rs₁.len + 1 ; Rs.int := B.bit * 2 ^ Rs₁.len + Rs₁.int }
Rs -> ε { Rs.len := 0 ; Rs.int := 0 }
B -> 0 { B.bit := 0 }
B -> 1 { B.bit := 1 }
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

const char *src;
size_t pos = 0;  

char peek(void) {
    return src[pos] ? src[pos] : '\0';
}

char next_char(void) {
    return src[pos++] ? src[pos - 1] : '\0';
}

void match(char expect) {
    if (peek() == expect) next_char();
    else {
        printf("error: %c, needed: %c", peek(), expect);
        exit(EXIT_FAILURE);
    }
}

typedef struct {          
    unsigned int len;       
    unsigned long long intv;
} LenInt;

double parse_S(void);
LenInt parse_L(void);
LenInt parse_Ls(void);
LenInt parse_R(void);
LenInt parse_Rs(void);
int parse_B(void);

// S -> L . R { S.val = L.int + R.int / 2^R.len }
double parse_S(void) {
    LenInt L = parse_L();
    match('.');
    LenInt R = parse_R();
    double result = (double)L.intv + (double)R.intv / pow(2.0, R.len);
    return result;
}

// L -> B Ls { L.len = Ls.len + 1 ; L.int = B.bit * 2^Ls.len + Ls.int }
LenInt parse_L(void) {
    int bit = parse_B();
    LenInt Ls = parse_Ls();
    LenInt L;
    L.len  = Ls.len + 1;
    L.intv = ((unsigned long long)bit << Ls.len) + Ls.intv;
    return L;
}

// Ls -> B Ls1 { Ls.len := Ls₁.len + 1 ; Ls.int := B.bit * 2 ^ Ls₁.len + Ls₁.int }
// Ls -> ε { Ls.len := 0 ; Ls.int := 0 }
 LenInt parse_Ls(void) {
    if (peek() == '0' || peek() == '1') {  // Ls1
        int bit = parse_B();
        LenInt Ls1 = parse_Ls();
        LenInt Ls;
        Ls.len  = Ls1.len + 1;
        Ls.intv = ((unsigned long long)bit << Ls1.len) + Ls1.intv;
        return Ls;
    } else {  // ε
        LenInt Ls = {0, 0};
        return Ls;
    }
}

// R -> B Rs { R.len := Rs.len + 1 ; R.int := B.bit * 2 ^ Rs.len + Rs.int }
LenInt parse_R(void) {
    int bit = parse_B();
    LenInt Rs = parse_Rs();
    LenInt R;
    R.len  = Rs.len + 1;
    R.intv = ((unsigned long long)bit << Rs.len) + Rs.intv;
    return R;
}

// Rs -> B Rs1 { Rs.len := Rs1.len + 1 ; Rs.int := B.bit * 2 ^ Rs1.len + Rs1.int }
// Rs -> ε { Rs.len := 0 ; Rs.int := 0 }
LenInt parse_Rs(void) {
    if (peek() == '0' || peek() == '1') {
        int bit = parse_B();
        LenInt Rs1 = parse_Rs();
        LenInt Rs;
        Rs.len  = Rs1.len + 1;
        Rs.intv = ((unsigned long long)bit << Rs1.len) + Rs1.intv;
        return Rs;
    } else {
        LenInt Rs = {0, 0};
        return Rs;
    }
}

// B -> 0 | 1 { B.bit := 0/1 }
int parse_B(void) {
    char ch = peek();
    if (ch == '0' || ch == '1') {
        next_char();
        return ch - '0';     /* '0'→0, '1'→1 */
    }
    printf("error: not '0' or '1'\n");
    exit(EXIT_FAILURE);
}

int main(int argc, char *argv[]) {
    src = argv[1];
    pos = 0;

    double value = parse_S();

    printf("%s (base-2) = %.15g (decimal)\n", argv[1], value);
    return EXIT_SUCCESS;
}