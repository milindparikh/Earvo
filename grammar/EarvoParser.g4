
parser grammar EarvoParser;

options { tokenVocab=EarvoLexer; }

earvoSchema
	: headerJavaDoc
	;
	
headerJavaDoc
	:  javadoc avroSchema?
	;

jstring
	: STRING
	;

jobject
	: BRACE_OPEN pair (COMMA pair)* BRACE_CLOSE
	| BRACE_OPEN BRACE_CLOSE 
	;


jarray
	: SQUARE_OPEN avroSchema (COMMA avroSchema)* SQUARE_CLOSE
	| SQUARE_OPEN SQUARE_CLOSE 
	;

pair
	: STRING COLON avroSchema
	;

avroSchema
	: jstring
	| jobject
	| jarray
	;



javadoc
	: JAVADOC_START whitespace* javadocContent JAVADOC_END
	;

javadocContent
	: javadodcDescription whitespace*
	| whitespace* tagSection
	| javadocDescription NEWLINE+ whitespace* tagSection
	;

whitespace
	: JD_SPACE
	| NEWLINE
	;



javadocDescription
	: descriptionLine (descriptionNewline+ descriptionLine)*
	;

descriptionLine
	: descriptionLineStart descriptionLineElement*
	| inlineTag descriptionLineElement*
	;

descriptionLineStart
	: JD_SPACE? descriptionLineNoSpaceNoAt+ (descriptionLineNoSpaceNoAt | JD_SPACE | AT)*
	;

descriptionLineNoSpaceNoAt
	: TEXT_CONTENT
	| NAME
	| STAR
	| SLASH
	| JD_BRACE_OPEN
	| JD_BRACE_CLOSE
	;

descriptionLineElement
	: inlineTag
	| descriptionLineText
	;

descriptionLineText
	: (descriptionLineNoSpaceNoAt | JD_SPACE | AT)+
	;

descriptionNewline
	: NEWLINE
	;


tagSection
	: blockTag+
	;

blockTag
	: JD_SPACE? AT blockTagName JD_SPACE? blockTagContent*
	;

blockTagName
	: NAME
	;

blockTagContent
	: blockTagText
	| inlineTag
	| NEWLINE
	;

blockTagText
	: blockTagTextElement+
	;

blockTagTextElement
	: TEXT_CONTENT
	| NAME
	| JD_SPACE
	| STAR
	| SLASH
	| JD_BRACE_OPEN
	| JD_BRACE_CLOSE
	;


inlineTag
	: INLINE_TAG_START inlineTagName SPACE* inlineTagContent? BRACE_CLOSE
	;

inlineTagName
	: NAME
	;

inlineTagContent
	: braceContent+
	;

braceExpression
	: JD_BRACE_OPEN braceContent* JD_BRACE_CLOSE
	;

braceContent
	: braceExpression
	| braceText (NEWLINE* braceText)*
	;

braceText
	: TEXT_CONTENT
	| NAME
	| SPACE
	| STAR
	| SLASH
	| NEWLINE
	;
