#include <stdio.h>
#include <cstring>

using namespace std;

extern "C" int yylex();  
extern "C" int yyparse();  
extern "C" FILE *yyin;

void yyerror(const char* s);  

#include "y.tab.c"

auto p = &yyunput;

int main( int argc, char* argv[] ) {
  yyparse();
}