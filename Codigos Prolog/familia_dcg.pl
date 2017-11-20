
/* Lista de diferencas */
/*
frase(LPalavras, LSobra) :-
    sujeito(LPalavras, LS1),
    verbo(LS1, LS2),
    predicato(LS2, LSobra).

sujeito([P|R], R) :- ehsujeito(P).
verbo([P|R], R) :- ehverbo(P).
predicato([P|R], R) :- ehpredicato(P).

ehsujeito(joao).
ehsujeito(maria).
ehverbo(corre).
ehpredicato(rapido).
ehpredicato(devagar).
*/

/* Definite Clause Grammar */
/*
frase --> sujeito, verbo, predicato.

sujeito --> [joao].
sujeito --> [maria].

verbo --> [corre].

predicato --> [rapido].
predicato --> [devagar].
*/


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

/* ponte entre interface e BC */

relacao_existe(pai). 
relacao_existe(mae). 
relacao_existe(filho). 
relacao_existe(filha). 
relacao_existe(irmao). 
relacao_existe(irma). 
relacao_existe(descendente). 
relacao_existe(ancestral). 
relacao_existe(pais). 
relacao_existe(maes). 
relacao_existe(filhos). 
relacao_existe(filhas).
relacao_existe(irmaos). 
relacao_existe(irmas). 
relacao_existe(descendentes). 
relacao_existe(ancestrais). 

sujeito_existe(S) :- homem(S).
sujeito_existe(S) :- mulher(S).

/* DCG */

sair --> [sair].
sair --> [tchau].
sair --> [bye].

perg_quem(R, S) --> qual, verbo_sing, art_sing, relacao_sing(R), prep, sujeito(S).
perg_quem(R, S) --> quais, verbo_plu, art_plu, relacao_plu(R), prep, sujeito(S).
perg_quantos(R, S) --> quantos, verbo_plu, art_plu, relacao_plu(R), prep, sujeito(S).
perg_quantos(R, S) --> quantos, relacao_plu(R), verbo_ter, art_sing, sujeito(S).
perg_quantos(R, S) --> quantos, relacao_plu(R), art_sing, sujeito(S), verbo_ter.
perg_quantos(R, S) --> art_sing, sujeito(S), verbo_ter, quantos, relacao_plu(R).
perg_oque(S1, S2) --> oque, sujeito(S1), verbo_sing, prep_para, sujeito(S2).
perg_oque(S1, S2) --> oque, sujeito(S1), verbo_sing, prep, sujeito(S2).
perg_oque(S1, S2) --> sujeito(S1), verbo_sing, oque, prep_para, sujeito(S2).
perg_oque(S1, S2) --> sujeito(S1), verbo_sing, oque, prep, sujeito(S2).

qual --> [qual].
qual --> [quem].
quais --> [quais].
quais --> [quem].
quantos --> [quantos].
oque --> [o, que].

verbo_sing --> [eh].

verbo_plu --> [sao].

verbo_ter --> [tem].

art_sing --> [a].
art_sing --> [o].

art_plu --> [as].
art_plu --> [os].

relacao_sing(R) --> [R].
relacao_plu(R) --> [R].

prep --> [do].
prep --> [de].

prep_para --> [para].
prep_para --> [pra].
prep_para --> [pro].
prep_para --> [para, a].
prep_para --> [para, o].

sujeito(S) --> [S].

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

interpretar(E, [sair]) :-
	sair(E, []).
interpretar(E, pergunta(tipo_quem, R, S)) :-
	perg_quem(R, S, E, []).
interpretar(E, pergunta(tipo_quantos, R, S)) :-
	perg_quantos(R, S, E, []).
interpretar(E, pergunta(tipo_oque, S1, S2)) :-
	perg_oque(S1, S2, E, []).
interpretar(_, []).

responder([sair]) :-
	mensagem('Bye').

responder(pergunta(tipo_oque, S1, S2)) :-
	sujeito_existe(S1),
	sujeito_existe(S2),
	relacao_existe(Rel),
	call(Rel, S1, S2),
	mensagem([S1, 'eh', Rel, 'de', S2]),
	interagir.
responder(pergunta(tipo_oque, S1, S2)) :-
	sujeito_existe(S1),
	sujeito_existe(S2),
	mensagem([S1, 'nao parece ter relacao com', S2]),
	interagir.
responder(pergunta(tipo_oque, S1, S2)) :-
	sujeito_existe(S1),
	mensagem(['Nao conheco', S2]),
	interagir.
responder(pergunta(tipo_oque, S1, S2)) :-
	sujeito_existe(S2),
	mensagem(['Nao conheco', S1]),
	interagir.
	
responder(pergunta(tipo_quem, R, S)) :-
	relacao_existe(R),
	sujeito_existe(S),
	call(R, Sujs, S),
	enumere(Sujs),
	interagir.
responder(pergunta(tipo_quantos, R, S)) :-
	relacao_existe(R),
	sujeito_existe(S),
	call(R, Sujs, S),
	conte(Sujs),
	interagir.
responder(pergunta(_, R, S)) :-
	sujeito_existe(S),
	mensagem(['Nao sei o que eh', R]),
	interagir.
responder(pergunta(_, _, S)) :-
	mensagem(['Nao conheco', S]),
	interagir.

responder(_) :-
	mensagem('Nao entendi. Pode repetir?'),
	interagir.

interagir :-
	prompt(E),
	interpretar(E, Perg),
	responder(Perg).
