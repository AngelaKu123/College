// The grammar for Rose language
grammar Rose;

// Parser rules
program: PROCEDURE IS DECLARE variables BEGIN statements END SEMI;
variables: variable variables | ;
variable: ID COLON INT SEMI;

statements: statement statements | ;
statement: assignment_statement
    | if_statement
    | for_statement
    | exit_statement
    | read_statement
    | write_statement;
assignment_statement: ID ASSIGN arith_expression ';';
if_statement: IF bool_expression THEN statements if_tail;
if_tail: ELSE statements END IF SEMI
    | END IF SEMI;
for_statement: FOR ID IN arith_expression TDOT arith_expression LOOP statements END LOOP SEMI;
exit_statement: EXIT SEMI;
read_statement: READ ID SEMI;
write_statement: WRITE arith_expression SEMI;

bool_expression: bool_term bool_expression_rest;
bool_expression_rest: OR bool_term bool_expression_rest | ;
bool_term: bool_factor bool_term_rest;
bool_term_rest: AND bool_factor bool_term_rest | ;
bool_factor: NOT bool_primary
    | bool_primary;
bool_primary: arith_expression relation_op arith_expression;

relation_op: EQ | ABRACKET | GT | GE | LT | LE;

arith_expression: arith_term ((ADD | SUB) arith_term)*;
arith_term: arith_factor ((MUL | DIV | MOD) arith_factor)*;
arith_factor: SUB arith_primary | arith_primary;
arith_primary: CONST | ID | LBRACKET arith_expression RBRACKET;

// lexer rules
BEGIN: 'begin';
END: 'end';
DECLARE: 'declare';
ELSE: 'else';
EXIT: 'exit';
FOR: 'for';
IF: 'if';
INT: 'integer';
IN: 'in';
IS: 'is';
LOOP: 'loop';
PROCEDURE: 'procedure';
READ: 'read';
THEN: 'then';
WRITE: 'write';
ID: [A-Z_][A-Z_0-9]*;
CONST: '0' | [1-9][0-9]*;
ADD: '+';
SUB: '-';
MUL: '*';
DIV: '/';
MOD: '%';
ASSIGN: ':=';
EQ: '=';
ABRACKET: '<>';
GE: '>=';
GT: '>';
LE: '<=';
LT: '<';
AND: '&&';
OR: '||';
NOT: '!';
LBRACKET: '(';
RBRACKET: ')';
COLON: ':';
SEMI: ';';
TDOT: '..';

WHITESPACE: [ \t\r\n]+ -> skip;
COMMENT: '//' ~[\r\n]* -> skip;

