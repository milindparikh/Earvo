
lexer grammar EarvoLexer;

DF_STAR
	: '*'
	;

JAVADOC_START
	: '/**' DF_STAR*   -> mode(JAVADOC)
	;


BRACE_OPEN
	: '{'		
	;

 


EA_SPACE
	: (' '|'\t'|'\n'|'\r')+ -> skip
	;


BRACE_CLOSE
	: '}'		
	;

SQUARE_OPEN
	: '['
	;

SQUARE_CLOSE
	: ']'
	;

COMMA
	: ','
	;
COLON
	: ':'
	;


STRING : '"' CHAR_NO_NL* '"' ;

fragment CHAR_NO_NL : 'a'..'z'|'A'..'Z'|'\t'|'\\'|EOF;


fragment HEX
	 : [0-9a-fA-F]
	 ;





mode JAVADOC;


NEWLINE
	: '\n' (JD_SPACE? (STAR {_input.LA(1) != '/'}?)+)?
	| '\r\n' (JD_SPACE? (STAR {_input.LA(1) != '/'}?)+)?
	| '\r' (JD_SPACE? (STAR {_input.LA(1) != '/'}?)+)?
	;

JD_SPACE
	: (' '|'\t')+
	;


NAME
	: [a-zA-Z]+
	;


TEXT_CONTENT
	: ~[\n\r\t @*{}/a-zA-Z]+
	;

AT
	: '@'
	;

STAR
	: '*'
	;

SLASH
	: '/'
	;




JAVADOC_END
	: JD_SPACE? STAR* '*/'   -> mode(DEFAULT_MODE)
	;


INLINE_TAG_START
	: '{@'
	;

JD_BRACE_OPEN
	: '{'
	;

JD_BRACE_CLOSE
	: '}'
	;




