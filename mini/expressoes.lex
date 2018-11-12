%{
#include <string.h>
int token( int );
%}
DIGITO  [0-9]
LETRA   [A-Za-z_]
INT     {DIGITO}+
DOUBLE  {DIGITO}+("."{DIGITO}+)?
ID      {LETRA}({LETRA}|{DIGITO})*
STRING  \"([^\\\"]|\\.)*\"


%%

"\t"       { coluna += 4; }
" "        { coluna++; }
"\n"	   { linha++; coluna = 1; }

{INT} 	   { return token( CINT ); }
{DOUBLE}   { return token( CDOUBLE ); }
{STRING}   { return token ( CSTRING ); }

"var"	   { return token( TK_VAR ); }
"console"  { return token( TK_CONSOLE ); }
">>"       { return token( TK_SHIFTR ); }
"<<"       { return token( TK_SHIFTL ); }
"for"      { return token( TK_FOR ); }
"in"       { return token( TK_IN ); }
".."       { return token( TK_2PT ); }
"if"       { return token( TK_IF ); }
"then"     { return token( TK_THEN ); }
"else"     { return token( TK_ELSE ); }   
"begin"    { return token( TK_BEGIN ); }
"end"      { return token( TK_END ); }
"||"      { return token( TK_OR ); }
"&&"      { return token( TK_AND ); }
"=="      { return token( TK_EQ ); }
"!="      { return token( TK_DIF ); }
"<="      { return token( TK_LSSEQ ); }
">="      { return token( TK_HIEQ ); }

{ID}       { return token( TK_ID ); }
.          { return token( *yytext ); }

%%

int token( int tk ) {
 yylval.v = yytext; 
 coluna += strlen(yytext); 
 return tk;

}