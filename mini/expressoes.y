%{
#include <string>
#include <stdio.h>
#include <stdlib.h>
#include <iostream>

using namespace std;

#define YYSTYPE Atributos

int linha = 1;
int coluna = 1;
int nLabel = 0;

struct Atributos {
  string v;
  string c;
  int linha;
};

extern "C" int yylex();
int yyparse();
void yyerror(const char *);

string geraNomeVar();
string geraNomeLabel();

int nVar = 0;

%}

%start S
%token CINT CDOUBLE CSTRING TK_ID TK_VAR TK_CONSOLE TK_SHIFTR TK_SHIFTL
%token TK_FOR TK_IN TK_2PT TK_IF TK_THEN TK_ELSE TK_BEGIN TK_END
%token TK_OR TK_AND TK_EQ TK_DIF TK_HIEQ TK_LSSEQ 

%left TK_OR TK_AND
%left TK_EQ TK_DIF
%left '<' '>' TK_HIEQ TK_LSSEQ
%left '+' '-'
%left '*' '/' '%'
%right '!'

%nonassoc IFX
%nonassoc TK_ELSE



%%

S : CMDS
    { cout << "#include <string>\n"
    << "#include <iostream>\n\n"
    << "using namespace std;\n\n"
    << "int ";
    for (int i = 0; i < nVar - 1; i++){
      cout << "t" << i << ",";
    }
    cout << "t" << nVar - 1 << ";\n\n"
    <<"int main(){\n"
    << $1.c
    << "return 0; \n\n}"
    << endl; }
  ;  

CMDS : CMDS CMD ';' { $$.c = $1.c + $2.c; }
     | CMD ';' 
     ;
  
CMD : DECLVAR 
    | ENTRADA
    | SAIDA 
    | ATR
    | FOR
    | IF
    | BEGIN 
    ;
    
DECLVAR : TK_VAR VARS 
        { $$.c = "int " + $2.c + ";\n"; }
        ;
    
VARS : VARS ',' VAR  { $$.c = $1.c + ", " + $3.c; }
     | VAR
     ;
     
VAR : TK_ID '[' CINT ']'  
      { $$.c = $1.v + "[" + $3.v + "]"; }
    | TK_ID                
      { $$.c = $1.v; }
    ;
    
ENTRADA : TK_CONSOLE TK_SHIFTR SHIFTR { $$.c = $3.c; } 
        ;

SHIFTR  :   TK_ID TK_SHIFTR SHIFTR
            { $$.c =  "cin >> " + $$.v + ";\n" + $3.c; }
        |   TK_ID '[' E ']' TK_SHIFTR SHIFTR
            { $$.v = geraNomeVar();
              $$.c = $3.c 
                 + "cin >> " + $$.v + ";\n"
                 + $1.v + "[" + $3.v + "] = " + $$.v + ";\n" + $3.c; }
        |   TK_ID
            { $$.c =  "cin >> " + $$.v + ";\n"; }
        |   TK_ID '[' E ']'
            { $$.v = geraNomeVar();
              $$.c = $3.c 
                 + "cin >> " + $$.v + ";\n"
                 + $1.v + "[" + $3.v + "] = " + $$.v + ";\n"; }
        ;

SAIDA : TK_CONSOLE TK_SHIFTL SHIFTL {$$.c = $3.c;}
      ;      

SHIFTL  : E TK_SHIFTL SHIFTL
          { $$.c = $$.c + "cout << " + $$.v + ";\n" + $3.c; }
        | CSTRING TK_SHIFTL SHIFTL
          { $$.c = "cout << " + $$.v + ";\n" + $3.c; }
        | E
          { $$.c = $1.c + "cout << " + $1.v + ";\n"; }
        | CSTRING
          { $$.c = "cout << " + $1.v + ";\n"; }

FOR : TK_FOR TK_ID TK_IN '[' E TK_2PT E ']' CMD  
    {  string cond = geraNomeVar();
       string meio = geraNomeLabel();
       string fim = geraNomeLabel();
       
       $$.c = $5.c + $7.c 
            + $2.v + " = " + $5.v + ";\n"
            + meio + ":\n" + cond + " = " + $2.v + " > " + $7.v + ";\n"
            + "if( " + cond + ") goto " + fim + ";\n"
            + $9.c
            + $2.v + " = " + $2.v + " + 1;\n"
            + "goto " + meio + ";\n"
            + fim + ":\n";
    }        
    ;

BEGIN : TK_BEGIN CMDS TK_END { $$.c = $2.c; };
    
IF  : TK_IF E TK_THEN CMD %prec IFX
      {
        string cond = geraNomeVar();
        string elseLabel = geraNomeLabel();
        $$.c = $2.c + cond + " = !"  + $2.v + ";\n"
                + "if ( " + cond + ") goto " +  elseLabel + ";\n"
                + $4.c + "\n" + elseLabel + ":\n";
      }
    | TK_IF E TK_THEN CMD TK_ELSE CMD
    {
        string cond = geraNomeVar();
        string elseLabel = geraNomeLabel();
        $$.c = $2.c + cond + " = !"  + $2.v + ";\n"
                + "if ( " + cond + ") goto " +  elseLabel + ";\n"
                + $4.c + "\n" + elseLabel + ":\n"
                + $6.c + "\n";
    }
    
   ;
  
ATR : TK_ID '=' E ';'
      { $$.v = $3.v;
        $$.c = $3.c + $1.v + " = " + $3.v + ";\n";
      }
    | TK_ID '[' E ']' '=' E ';'
      { $$.c = $3.c + $6.c 
             + $1.v + "[" + $3.v + "] = " + $6.v + ";\n";
        $$.v = $6.v;
      }
    ;

E : E '+' E
    { $$.v = geraNomeVar();
      $$.c = $1.c + $3.c + $$.v + " = " + $1.v + "+" + $3.v + ";\n";
    }
 | E '-' E
    { $$.v = geraNomeVar();
      $$.c = $1.c + $3.c + $$.v + " = " + $1.v + "-" + $3.v + ";\n";
    }
  | E '*' E
    { $$.v = geraNomeVar();
      $$.c = $1.c + $3.c + $$.v + " = " + $1.v + "*" + $3.v + ";\n";
    }
  | E '/' E
    { $$.v = geraNomeVar();
      $$.c = $1.c + $3.c + $$.v + " = " + $1.v + "/" + $3.v + ";\n";
    }
  | E '%' E 
    { $$.v = geraNomeVar();
      $$.c = $1.c + $3.c + $$.v + " = " + $1.v + "%" + $3.v + ";\n";
    }
  | E '<' E
    { $$.v = geraNomeVar();
      $$.c = $1.c + $3.c + $$.v + " = " + $1.v + "<" + $3.v + ";\n";
    }
  | E '>' E
    { $$.v = geraNomeVar();
      $$.c = $1.c + $3.c + $$.v + " = " + $1.v + ">" + $3.v + ";\n";
    }
  | E TK_LSSEQ E
    { $$.v = geraNomeVar();
      $$.c = $1.c + $3.c + $$.v + " = " + $1.v + "<=" + $3.v + ";\n";
    }
  | E TK_HIEQ E
    { $$.v = geraNomeVar();
      $$.c = $1.c + $3.c + $$.v + " = " + $1.v + ">=" + $3.v + ";\n";
    }
  | E TK_AND E
    { $$.v = geraNomeVar();
      $$.c = $1.c + $3.c + $$.v + " = " + $1.v + "&&" + $3.v + ";\n";
    }
  | E TK_OR E
    { $$.v = geraNomeVar();
      $$.c = $1.c + $3.c + $$.v + " = " + $1.v + "||" + $3.v + ";\n";
    }
  | E TK_EQ E
    { $$.v = geraNomeVar();
      $$.c = $1.c + $3.c + $$.v + " = " + $1.v + "==" + $3.v + ";\n";
    }
  | E TK_DIF E
    { $$.v = geraNomeVar();
      $$.c = $1.c + $3.c + $$.v + " = " + $1.v + "!=" + $3.v + ";\n";
    }
  | '!' E
    { $$.v = geraNomeVar();
      $$.c = $2.c + $$.v + " = " + "!" + $2.v + ";\n";
    }
  | V
  ;

  
V : TK_ID '[' E ']' 
    { $$.v = geraNomeVar();
      $$.c = $3.c + $$.v + " = " + $1.v + "[" + $3.v + "];\n";                    
    }
  | TK_ID     { $$.c = ""; $$.v = $1.v; }
  | CINT      { $$.c = ""; $$.v = $1.v; } 
  | '(' E ')' { $$ = $2; }
  ;

%%

#include "lex.yy.c"

void yyerror( const char* st ) {
   puts( st ); 
   printf( "Linha %d, coluna %d, proximo a: %s\n", linha, coluna, yytext );
   exit( 0 );
}

string geraNomeVar() {
  char buf[20] = "";
  
  sprintf( buf, "t%d", nVar++ );
  
  return buf;
}

string geraNomeLabel(){
  char buf[20] = "";
  sprintf( buf, "i%d", nLabel++ );
  return buf;
}

int main( int argc, char* st[]) {
  yyparse();
  
  return 0;
}