% This buffer is for notes you don't want to save.
% If you want to create a file, visit that file with C-x C-f,
% then enter the text in that file's own buffer.

/*
 * -- Controle de fluxo com recursao
 * -- Testes/seleção com regras --> if/else substituido por regras e
 *    ordem de avaliacao
 * -- Cláusulas dinâmicas (dynamic, assert, retract)
 * -- Programação lógica em alta ordem (findall)
 *
 */


/*
 * Operacoes sobre a base de fatos
 * -------------------------------
   NOTEM que eh normal em programacao logica a tentativa de separar os
   aspecos associados com o domínio do problemas dos aspectos de
   implementacao como interface, I/O, etc. Por isso as operacoes sobre a
   base de dados sao separadas das operacoes de interface
*/

:- dynamic(contato/2).

/*
 * mergesort
 */
divide([], [], []).
divide([E], [E], []).
divide([E1, E2|R], [E1|R1], [E2|R2]) :-
    divide(R, R1, R2).

intercala([], [], []).
intercala(L, [], L).
intercala([], L, L).
intercala([P1|R1], [P2|R2], [P1|R3]) :-
    compare(<, P1, P2),
    intercala(R1, [P2|R2], R3).
intercala([P1|R1], [P2|R2], [P2|R3]) :-
    intercala([P1|R1], R2, R3).

mergesort([], []).
mergesort([E], [E]).
mergesort([E1, E2], [E1, E2]) :-
    compare(<, E1, E2).
mergesort([E1, E2], [E2, E1]).
mergesort(L, LO) :-
    divide(L, L1, L2),
    mergesort(L1, L1O),
    mergesort(L2, L2O),
    intercala(L1O, L2O, LO).

/* acesso a base de conhecimento */
incluir(Nome) :-
    contato(Nome, _),
    mostre([Nome, "já incluido."]).
incluir(Nome) :-
    leia('Telefone: ', Telefone),
    assert(contato(Nome, Telefone)),
    mostre([Nome, "incluido."]).

consultar(Nome) :-
    contato(Nome, Telefone),
    mostre(["Telefone:", Telefone]).
consultar(Nome) :-
    mostre([Nome, "nao é um contato."]).

excluir(Nome) :-
    contato(Nome, _),
    retractall(contato(Nome, _)),
    mostre([Nome, "excluido."]).
excluir(Nome) :-
    mostre([Nome, "nao é um contato."]).

/* Exemplo de programacao logica de alta ordem -->
 * findall eh um predicado de alta ordem. Ou seja, eh um predicado
 * que opera em predicados. Neste caso, ele eh usado para recuperar
 * todos os nomes e telefones armazenados como contato/2.
 */
relatorio :-
    findall([Nome, Telefone], contato(Nome, Telefone), Contatos),
    mergesort(Contatos, ContatosO),
    mostre_rel(ContatosO).

/*
 * Operacoes de Interface
 * ----------------------
 */

/*
 Predicados de I/O
*/
mostre([]) :- nl.
mostre([P|R]) :-
    write(P), write(' '),
    mostre(R).
mostre([P|R], Sep) :-
    write(P), write(Sep),
    mostre(R).

leia(Msg, InfoLida) :-
    write(Msg),
    read_string(user_input, "\n", "", _, InfoLida).

mostrar_contatos([]) :- nl.
mostrar_contatos([[Nome, Telefone]|Resto]) :-
    mostre([Nome, Telefone], "\t"),
    mostrar_contatos(Resto).

mostre_rel([]) :- mostre(['Nenhum contato armazenado.']).
mostre_rel(L) :-
    mostre(['NOME', 'TELEFONE'], "\t\t"),
    mostre(['----', '--------'], "\t\t"),
    mostrar_contatos(L).

/*
 * Controle de fluxo via recursao
 */
execute("1") :-
    mostre(['++++++++++++ INCLUSAO ++++++++++++']),
    leia('Nome: ', Nome),
    incluir(Nome),
    menu.

execute("2") :-
    mostre(['++++++++++++ CONSULTA ++++++++++++']),
    leia('Nome: ', Nome),
    consultar(Nome),
    menu.

execute("3") :-
    mostre(['++++++++++++ EXCLUSAO ++++++++++++']),
    leia('Nome: ', Nome),
    excluir(Nome),
    menu.

execute("4") :-
    mostre(['++++++++++++ RELATORIO +++++++++++']),
    relatorio,
    menu.

execute("5") :-
    mostre(['Bye']).

execute(_) :-
    mostre(['Opcao nao reconhecida. Tente de novo.']),
    menu.

menu :-
    mostre(['==================================']),
    mostre(['AGENDA']),
    mostre(['----------------------------------']),
    mostre(['1 - Incluir']),
    mostre(['2 - Consultar']),
    mostre(['3 - Excluir']),
    mostre(['4 - Relatorio']),
    mostre(['5 - Sair']),
    mostre(['----------------------------------']),
    leia('Entre com uma opcao (1 a 5): ', Opcao),
    execute(Opcao).

/*
 *
 *  CRITICAS AO USO DE PROLOG COMO LING EM PARADIGA LOGICO:
 *
 *  1) Controle de fluxo com recursao em Prolog leva a um codigo
 *  spagetti que lembra código procedural com GOTO.
 *  -> Varias linguagens logicas se restrigem a processamento de base de
 *  conhecimento deixando questoes de interface para outras linguagens,
 *  Ex: Datalog
 *
 *  2) Predicados dinamicos (assert e retract) levam a estados dificeis
 *  de observar no código, com resultado similar ao problema de efeito
 *  colateral em código baseado em estados.
 *  -> Eh sugerido que todos os estados sejam mantidos através de
 *  functors e predicados dinamicos se restrinjam unicamente aa criacao
 *  de fatos e regras novas, relacionadas aa base de conhecimento.
 *
 *  3) Prolog não é realmente sobre programação lógica na maior parte do
 *  tempo pq a ORDEM de avaliacao das cláusulas é muito importante,
 *  diferente do que se espera em lógica de primeira ordem
 *  -> Esta eh uma restricao dificil de lidar, uma vez que sistemas de
 *  inferencia sao de fato implementacoes de algorimo de busca em
 *  espaco. Esse problema eh maior ainda quando se permite o uso de
 *  predicados cut e fail, que manipulam diretamente os algoritmos de
 *  busca. Neste curso, em particular, não vimos o uso de cut e fail.
 *
 *  Marco Cristo, 2017
 *
 */



