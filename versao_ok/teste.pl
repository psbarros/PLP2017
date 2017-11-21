/* interpretador */
:- use_module(library(streampool)).

/* comandos interpretados */
criar(Forma, Cor, X, Y, Str) :-
	atomic_list_concat([+, Forma, Cor, X, Y], ' ', Atom), 
	atom_string(Atom, Str).

/* NLP */

comando_criar(Forma, Cor, X, Y) -->
	verbo_criar, forma(Forma), cor(Cor), prep, num(X), num(Y).

verbo_criar --> [criar].

forma(c) --> [circulo].


forma(s) --> [quadrado].

cor(red) --> [vermelho].
cor(blue) --> [azul].

prep --> [em].

num(1) --> ['1'].
num(2) --> ['2'].
num(3) --> ['3'].
num(4) --> ['4'].
num(5) --> ['5'].
num(6) --> ['6'].
num(7) --> ['7'].
num(8) --> ['8'].
num(9) --> ['9'].
num(0) --> ['0'].

interprete(L, Str, continuar) :-
	comando_criar(Forma, Cor, X, Y, L, []),
	criar(Forma, Cor, X, Y, Str).
interprete([bye], '', parar).
interprete(_, 'Nao entendi o que vc disse. Pode repetir?', incompreensivel).

/* interface via teclado */
prompt(L) :-
	write('>> '),
	read_line_to_codes(user_input, Cs),
	atom_codes(A, Cs),
	atomic_list_concat(L, ' ', A).

interaja(parar) :-
	write('Tchau!'), nl.
interaja(_) :-
	prompt(L),
	interprete(L, Str, ProxCmd),
	write(Str), nl,
	interaja(ProxCmd).

go :-
	interaja(continuar).

/* interface via socket */
create_client(Host, Port) :-
        setup_call_catcher_cleanup(tcp_socket(Socket),
                                   tcp_connect(Socket, Host:Port),
                                   exception(_),
                                   tcp_close_socket(Socket)),
        setup_call_cleanup(tcp_open_socket(Socket, In, Out),
                           chat_to_server(In, Out),
                           close_connection(In, Out)).

chat_to_server(In, Out) :-
	prompt(L),
	interprete(L, Str, ProxCmd),
   (   ProxCmd == parar
   ->  interaja(parar)
    	;   (	ProxCmd == incompreensivel
			->	write('   '), write(Str), nl, nl,
				chat_to_server(In, Out)
			;	write('   Enviado: '), write(Str), nl,
			format(Out, '~s', Str),
        		flush_output(Out),
			read_string(In, '\n', '\r', _, Reply),
        		write('   Respost: '), write(Reply), nl, nl,
			chat_to_server(In, Out)
		)
   ).

close_connection(In, Out) :-
        close(In, [force(true)]),
        close(Out, [force(true)]).

go_socket :- create_client('localhost', 7777).
