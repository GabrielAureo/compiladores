all: gabarito entrada.cc
	./gabarito < entrada.cc

lex.yy.c: gabarito.l
	lex gabarito.l

y.tab.c: gabarito.y
	yacc gabarito.y

gabarito: lex.yy.c y.tab.c
	g++ -o gabarito y.tab.c -lfl
