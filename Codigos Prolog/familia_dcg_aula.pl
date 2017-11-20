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

filho(X, Y) :- progenitor(Y, X), homem(X).
filha(X, Y) :- progenitor(Y, X), mulher(X).

irmao_geral(X, Y) :-
    pai(Pai, X), pai(Pai, Y),
    mae(Mae, X), mae(Mae, Y),
    X \= Y.

irmao(X, Y) :-
    homem(X), irmao_geral(X, Y).

irma(X, Y) :-
    mulher(X), irmao_geral(X, Y).

/* predicados recursivos */
descendente(X, Y) :- 
    progenitor(Y, X).
descendente(X, Y) :- 
    progenitor(P, X),
    descendente(P, Y).
    
ancestral(X, Y) :- descendente(Y, X).

/* relacoes plurais */

pais([P, M], X) :- pai(P, X), mae(M, X).
maes([M], X) :- mae(M, X).
filhos(Fs, X) :- findall(F, progenitor(X, F), Fs).
filhas(Fs, X) :- findall(F, filha(F, X), Fs).
irmaos(Is, X) :- findall(I, irmao_geral(I, X), Is).
irmas(Is, X) :- findall(I, irma(I, X), Is).
descendentes(Ds, X) :- findall(D, descendente(D, X), Ds).
ancestrais(As, X) :- findall(A, ancestral(A, X), As).

/* I-O */

msg_r([]).
msg_r([P|R]) :- 
	write(P), write(' '), msg_r(R).
msg_r(M) :-
	write(M). 
mensagem(M) :-
	write('  '), msg_r(M), nl, nl. 

enum_r([]) :- write('Nunca me disseram').
enum_r([E1]) :- 
	write(E1).
enum_r([E1, E2]) :- 
	write(E1), write(' e '), write(E2).
enum_r([E|R]) :- 
	write(E), write(', '), enum_r(R).
enum_r(E) :- 
	write(E).
enumere(M) :-
	write('  '), enum_r(M), nl, nl. 

tam([], 0).
tam([_|R], T) :- 
	tam(R, TR),
	T is 1 + TR.
tam(_, 1). % if not list, assumes that has 1 element

conte(L) :-
	tam(L, Valor),
	mensagem(Valor). 

remove_question_mark([], []).
remove_question_mark([63|R], R).
remove_question_mark([H|R], [H|NR]) :-
	remove_question_mark(R, NR).

prompt(L) :-
	write('> '),
	read_line_to_codes(user_input, Cs),
	remove_question_mark(Cs, CsNQM),
	atom_codes(A, CsNQM),
	atomic_list_concat(L, ' ', A).
