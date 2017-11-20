/* alguns fatos */
gosta(perla, joao).
gosta(perla, pedro).

gosta(pedro, perla).
gosta(joao, marisa).

/* regra */
/*
forall X exists Y such 
	gosta(X,Y) and gosta(Y, X) -> feliz(X)
    
    ; = ou
    , = e
    :- = ->
    /+ = negacao
*/
feliz(X) :- gosta(X, Y),
    gosta(Y, X).

/* Definir uma arvore genealogica */
/* A familia Simpson */

/*
 * - variaveis iniciam com maiuscula; 
 *   objetos c minuscula;
 * - toda a sentenca termina em ponto;
 */

homem(abraham).
homem(herb).
homem(homer).
homem(clancy).
homem(bart).
homem(yang).

mulher(mona).
mulher(marge).
mulher(jack).
mulher(patty).
mulher(selma).
mulher(lisa).
mulher(maggie).
mulher(ling).

progenitor(abraham, herb).
progenitor(abraham, homer).
progenitor(clancy, marge).
progenitor(mona, herb).
progenitor(mona, homer).

progenitor(clancy, patty).
progenitor(clancy, selma).
progenitor(jack, marge).
progenitor(jack, patty).
progenitor(jack, selma).

progenitor(homer, bart).
progenitor(homer, maggie).
progenitor(homer, lisa).
progenitor(marge, bart).
progenitor(marge, maggie).
progenitor(marge, lisa).

progenitor(selma, ling).
progenitor(yang, ling).

pai(X, Y) :- 
    homem(X), 
    progenitor(X, Y).

mae(X, Y) :- 
    mulher(X), 
    progenitor(X, Y).

irmao(X, Y) :-
    homem(X),
    pai(Pai, X), pai(Pai, Y),
    mae(Mae, X), mae(Mae, Y),
    X \= Y.

irma(X, Y) :-
    mulher(X),
    pai(Pai, X), pai(Pai, Y),
    mae(Mae, X), mae(Mae, Y),
    X \= Y.

/* note o uso de regras alternativas 
 * para indicar OU */
avop(X, Y) :- 
    pai(X, P), pai(P, Y).
avop(X, Y) :- 
    pai(X, M), mae(M, Y).
    
avoh(X, Y) :- 
    mae(X, P), pai(P, Y).
avoh(X, Y) :- 
    mae(X, M), mae(M, Y).

tio(X, Y) :- 
    pai(P, Y),
	irmao(X, P).
tio(X, Y) :- 
    mae(M, Y),
	irmao(X, M).

tia(X, Y) :- 
    pai(P, Y),
	irma(X, P).
tia(X, Y) :- 
    mae(M, Y),
	irma(X, M).

/* corrigir em casa!!! */
primo_qq(X, Y) :-
	pai(Tio, X), 
    tio(Tio, Y).
primo_qq(X, Y) :-
	mae(Tia, X), 
    tia(Tia, Y).
primo(X, Y) :-
    homem(X), 
    primo_qq(X, Y).
prima(X, Y) :-
    mulher(X), 
    primo_qq(X, Y).

/* predicados recursivos!!! */
descendente(X, Y) :- 
    progenitor(Y, X).
descendente(X, Y) :- 
    progenitor(P, X),
    descendente(P, Y).











