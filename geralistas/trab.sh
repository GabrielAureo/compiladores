lex gera_listas.lex;
yacc gera_listas.y -t -v;
g++ -std=c++17 -Wall main.cc -lfl -o compilador;
./compilador < entrada.txt > codigo.cc;
g++ -std=c++17 main_programa_gerado.cc codigo.cc -o programa_gerado; 
./programa_gerado