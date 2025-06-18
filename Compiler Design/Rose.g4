// The grammar for Rose language
grammar Rose;

@members {
    int lbl = 0;
    int reg = 0;  
    String newL() { return "L" + (++lbl); }
    String newReg() { return "$" + "t" + (reg++); }   // allocate
    void freeReg() { if (reg > 0) reg--; }       // free one
    }

// Parser rules
program: 
    PROCEDURE IS {
        System.out.println("# variables");
        System.out.println("\t" + ".data");
    } 
    DECLARE variables {
        System.out.println("# begin function");
        System.out.println("\t.text");
        System.out.println("main:");
    } 
    BEGIN statements 
    END SEMI {
        System.out.println("# end function");
    };

variables: variable variables | ;
variable: ID COLON INT SEMI { 
        System.out.println($ID.text + ": .word 0");
    };

statements: (statement)*;
statement: assignment_statement
    | if_statement
    | for_statement
    | exit_statement
    | read_statement
    | write_statement;
    

assignment_statement
    : lhs=ID ASSIGN e=arith_expression SEMI
      {
          /* e.place = register holding expression value */
          String addr = newReg();                   // allocate a fresh temp
          System.out.println("\tla " + addr + ", " + $lhs.text);
          System.out.println("\tsw " + $e.place + ", 0(" + addr + ")");
          freeReg();           // free addr
          freeReg();           // free e.place
      }
    ;


arith_expression returns [String place]
    : e1=arith_term           { $place = $e1.place; }
      ( ADD e2=arith_term
        {
            /* 直接把結果寫回左邊暫存器 */
            System.out.println("\tadd " + $place + ", " + $place + ", " + $e2.place);
            freeReg();                // 釋放右側暫存器
        }
      | SUB e2=arith_term
        {
            System.out.println("\tsub " + $place + ", " + $place + ", " + $e2.place);
            freeReg();
        }
      )*
    ;

arith_term returns [String place]
    : f1=arith_factor          { $place = $f1.place; }
      ( MUL f2=arith_factor
        {
            System.out.println("\tmul " + $place + ", " + $place + ", " + $f2.place);
            freeReg();
        }
      | DIV f2=arith_factor
        {
            System.out.println("\tdiv " + $place + ", " + $place + ", " + $f2.place);
            freeReg();
        }
      | MOD f2=arith_factor
        {
            System.out.println("\trem " + $place + ", " + $place + ", " + $f2.place);
            freeReg();
        }
      )*
    ;

arith_factor returns [String place]
    : SUB a=arith_factor
      {
          $place = $a.place;
          System.out.println("\tneg " + $place + ", " + $place);
      }
    | p=arith_primary {$place = $p.place;}
    ;

arith_primary returns [String place]
    : id=ID
      {
          String r = newReg();
          System.out.println("\tla " + r + ", " + $id.text);
          System.out.println("\tlw " + r + ", 0(" + r + ")");
          $place = r;
      }
    | c=CONST
      {
          String r = newReg();
          System.out.println("\tli " + r + ", " + $c.text);
          $place = r;
      }
    | LBRACKET e=arith_expression RBRACKET
      { $place = $e.place; }
    ;


if_statement: 
    IF var=ID LT cst=CONST THEN {
        // generate three labels: then, else, end-if
        String L_then = newL();  // L1
        String L_else = newL();  // L2
        String L_end  = newL();  // L3

        System.out.println("# if");
        System.out.println("\tla $"+"t0, "+$var.text);
        System.out.println("\tlw $"+"t0, 0($"+"t0)");
        System.out.println("\tli $"+"t1, "+$cst.text);
        System.out.println("\tblt $"+"t0, $"+"t1, "+L_then);
        System.out.println("\tb "+L_else);
        System.out.println(L_then+": # then");
    }
    statements {        // then block
        System.out.println("\tb "+L_end);       // jump to end-if
    }
    else_part[L_else] {       // optional else-block
        System.out.println(L_end+": # end if");
    }
    END IF SEMI
    ;

else_part[String L_else]:
    ELSE {
        System.out.println(L_else+": # else");
    }
    statements      // else block
    |       // no else 
    ;

for_statement: 
    FOR idx=ID IN low=CONST DOTDOT hi=ID LOOP {
        // initialize index = low
        System.out.println("\tli $"+"t0, "+$low.text);
        System.out.println("\tla $"+"t1, "+$idx.text);
        System.out.println("\tsw $"+"t0, 0($"+"t1)");

        // generate labels
        String L_for    = newL();
        String L_body   = newL();
        String L_endFor = newL();

        System.out.println(L_for+": # for");
        // test I <= hi ?
        System.out.println("\tla $"+"t0, "+$idx.text);
        System.out.println("\tlw $"+"t0, 0($"+"t0)");
        System.out.println("\tla $"+"t1, "+$hi.text);
        System.out.println("\tlw $"+"t1, 0($"+"t1)");
        System.out.println("\tble $"+"t0, $"+"t1, "+L_body);
        System.out.println("\tb "+L_endFor);
        System.out.println(L_body+": # for body");
    }
    statements
    END FOR SEMI {
        // I := I + 1
        System.out.println("\tla $"+"t0, "+$idx.text);
        System.out.println("\tlw $"+"t0, 0($"+"t0)");
        System.out.println("\tli $"+"t1, 1");
        System.out.println("\tadd $"+"t0, $"+"t0, $"+"t1");
        System.out.println("\tla $"+"t1, "+$idx.text);
        System.out.println("\tsw $"+"t0, 0($"+"t1)");
        System.out.println("\tb "+L_for);
        System.out.println(L_endFor+": # end for");
    }
    ;


exit_statement: EXIT SEMI {
    System.out.println("\tli $" + "v0, 10   # exit;");
    System.out.println("\tsyscall");
};

read_statement: READ id=ID SEMI {
    System.out.println("\tli $" + "v0, 5   # read " + $id.text + ";");
    System.out.println("\tsyscall");
    System.out.println("\tla $" + "t0, " + $id.text);
    System.out.println("\tsw $" + "v0, 0($" + "t0)");
};

write_statement:
    WRITE id=ID SEMI {
        System.out.println("\tla $" + "t0, " + $id.text + "   # write " + $id.text + ";");
        System.out.println("\tlw $" + "t0, 0($" + "t0)");
        System.out.println("\tmove $" + "a0, $" + "t0");
        System.out.println("\tli $" + "v0, 1");
        System.out.println("\tsyscall");
    }
    | WRITE SUB val=CONST SEMI {               // write -<const>
        System.out.println("\tli $" + "t0, " + $val.text);
        System.out.println("\tneg $" + "t0, $" + "t0");
        System.out.println("\tmove $" + "a0, $" + "t0");
        System.out.println("\tli $" + "v0, 1");
        System.out.println("\tsyscall");
    };

bool_expression: bool_term bool_expression_rest;
bool_expression_rest: OR bool_term bool_expression_rest | ;
bool_term: bool_factor bool_term_rest;
bool_term_rest: AND bool_factor bool_term_rest | ;
bool_factor: NOT bool_primary
    | bool_primary;
bool_primary: arith_expression relation_op arith_expression;

relation_op: EQ | ABRACKET | GT | GE | LT | LE;

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
DOTDOT: '..';
PROCEDURE: 'procedure';
READ: 'read';
THEN: 'then';
WRITE: 'write';
CONST: '0' | [1-9][0-9]*;
ID: [A-Z_][A-Z_0-9]*;
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

WHITESPACE: [ \t\r\n]+ -> skip;
COMMENT: '//' ~[\r\n]* -> skip;

