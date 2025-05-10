// The grammar for Rose language
grammar Rose;

// Parser rules
token:(BEGIN|DECLARE|ELSE|END|EXIT|FOR|IF|IN|INTEGER|IS|LOOP|PROCEDURE|READ|THEN|WRITE|ID|CONST|COLON|RANGE|SEMICOLON|ADD|SUB|MUL|DIV|MOD|EQ|NE|GT|GTE|LT|LTE|AND|OR|NOT|ASSIGN|LPA|RPA|WHITESPACE|COMMENT)*;

// Lexer rules
BEGIN: 'begin';
DECLARE: 'declare';
ELSE: 'else';
END: 'end';
EXIT: 'exit';
FOR: 'for';
IF: 'if';
IN: 'in';
INTEGER: 'integer';
IS: 'is';
LOOP: 'loop';
PROCEDURE: 'procedure';
READ: 'read';
THEN: 'then';
WRITE: 'write';

// Identifiers & Constants
ID: [A-Z_0-9][_A-Z0-9]*;
CONST: '0' | [1-9][0-9]*;

// Operators
COLON: ':';
RANGE: '..';
SEMICOLON: ';';
ADD: '+';
SUB: '-';
MUL: '*';
DIV: '/';
MOD: '%';
EQ: '=';
NE: '<>';
GT: '>';
GTE: '>=';
LT: '<';
LTE: '<=';
AND: '&&';
OR: '||';
NOT: '!';
ASSIGN: ':=';
LPA: '(';
RPA: ')';

// White spaces & Comments
WHITESPACE: [ \t\r\n]+ -> skip;
COMMENT: '//' ~[\r\n]* -> skip;