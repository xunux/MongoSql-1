grammar GenericSql_where;

@parser::header {
   package org.at.mongosql.grammar;
   import org.at.mongosql.facade.SelectInterpreter;
}

@lexer::header {
   package org.at.mongosql.grammar;
}

program
    :   stat+
    ;

stat
    :   select_query
    ;



select_query
    	:   SELECT columnList FROM tbl=ID
        (   WHERE conditionList  
        |   
        )
    	;

columnList
	: columns+='*'
	| columns+=ID (',' columns+=ID)*
	;

nestedCondition
	: LPAREN conditionList RPAREN
	;

conditionList
    	: sc=condition  ((OR|AND) sc2=condition )*	
    	;	

 
condition
	: comparison {SelectInterpreter.comparison();}
	| nestedCondition {SelectInterpreter.nestedCondition();}
	;	 
    
comparison 
	: ID OPERATOR expr  
	;


// START: expr
// Match a simple value or do a query
expr returns [Object value] // access as $expr.value in other rules
    :   INT     {$value = $INT.int;}
    |   STRING  {$value = $STRING.text;}
    ;
// END: expr

OPERATOR : '='|'<>'|'>'|'<'|'>='|'<=';


SELECT    : S E L E C T ;	
OR        : O R ;
AND	  : A N D ;
WHERE	  : W H E R E ;
FROM 	  : F R O M ;	


ID  :   ('a'..'z'|'A'..'Z'|'_') ('a'..'z'|'A'..'Z'|'0'..'9'|'_')* ;

INT :   '0'..'9'+ ;

STRING
    :   '\'' ~'\''* '\''
        {setText(getText().substring(1, getText().length()-1));}
    ;
  
  
			

fragment A:('a'|'A');
fragment B:('b'|'B');
fragment C:('c'|'C');
fragment D:('d'|'D');
fragment E:('e'|'E');
fragment F:('f'|'F');
fragment G:('g'|'G');
fragment H:('h'|'H');
fragment I:('i'|'I');
fragment J:('j'|'J');
fragment K:('k'|'K');
fragment L:('l'|'L');
fragment M:('m'|'M');
fragment N:('n'|'N');
fragment O:('o'|'O');
fragment P:('p'|'P');
fragment Q:('q'|'Q');
fragment R:('r'|'R');
fragment S:('s'|'S');
fragment T:('t'|'T');
fragment U:('u'|'U');
fragment V:('v'|'V');
fragment W:('w'|'W');
fragment X:('x'|'X');
fragment Y:('y'|'Y');
fragment Z:('z'|'Z');



LPAREN   : '('  ;
RPAREN   : ')'  ;

COMMENT
    :   '//' ~('\n'|'\r')* '\r'? '\n' {$channel=HIDDEN;}
    ;

WS  :   ( ' '
        | '\t'
        | '\r'
        | '\n'
        ) {$channel=HIDDEN;}
    ;
