all: saida
	./saida

saida: codigo.cc
	g++ -o saida codigo.cc

codigo.cc: mlc exemplo.ml
	./mlc < exemplo.ml > codigo.cc
	./gabarito < codigo.cc

lex.yy.c: expressoes.lex
	lex expressoes.lex

y.tab.c: expressoes.y
	yacc expressoes.y

mlc: lex.yy.c y.tab.c
	g++ -o mlc y.tab.c -lfl