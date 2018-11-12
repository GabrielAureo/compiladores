DELIM   [\t ]
LINHA   [\n]
NUMERO  [0-9]
LETRA   [A-Za-z_]
INT     {NUMERO}+
DOUBLE  {NUMERO}+("."{NUMERO}+)?
CHAR    ['][^\n'][']
ID      {LETRA}({LETRA}|{NUMERO})*
ID_INC  (("<")({LETRA})*(".h")?(">")|(\")({LETRA})*(".h")?(\"))
INCLUDE ("#include")
STR     (\"([^"]|\\\")*\")

%%

{LINHA}    { nlinha++; }
{DELIM}    {}
{INCLUDE}  { return TK_INCLUDE; }
{STR}	   { return TK_STR; }	
"main"     { return TK_MAIN; }
"if"	   { return TK_IF; }
"goto"     { return TK_GOTO; }
"return"   { return TK_RETURN; }
"int"      { return TK_INT; }
"char"     { return TK_CHAR; }
"float"    { return TK_FLOAT; }
"double"   { return TK_DOUBLE; }
"long"     { return TK_LONG; }
"void"     { return TK_VOID; }
"&&"       { return TK_AND; }
"||"       { return TK_OR; }
"=="       { return TK_IGUAL; }
"!="       { return TK_DIF; }
">="       { return TK_MAIGUAL; }
"<="       { return TK_MEIGUAL; }
"printf"   { return TK_PRINTF; }
"scanf"    { return TK_SCANF; }
"cin"      { return TK_CIN; }
"cout"     { return TK_COUT; }
"endl"     { return TK_ENDL; }
"<<"       { return TK_SHFL; }
">>"       { return TK_SHFR; }      

"using namespace std;" { return TK_STD; }

{ID}       { return TK_ID; }
{ID_INC}   { return TK_ID_INC; }
{INT}      { return TK_CINT; }
{DOUBLE}   { return TK_CDOUBLE; }
{CHAR}     { return TK_CCHAR; }
.          { return *yytext; }

%%

 


