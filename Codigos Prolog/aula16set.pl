/*
 * Listas e Recursão em Prolog
 * /

/* Exercicios -- Escreva os seguintes predicados usando recursao */

/* tam(L, T) = V se T eh o tamanho de L. Ex: tam([2,3,4], 3) = V */
tam([], 0).
tam([_|R], T) :- 
    tam(R, TR),
    T is 1 + TR.

/* soma(L, S) = V se S eh a soma dos valores de L. 
                Ex: soma([1, 2, 3], 6) = V */
/*
soma([], 0).
soma([P|R], S) :-
    soma(R, SRL), % SRL eh a soma do resto da lista
    S is P + SRL. % S = P + soma do resto da lista
*/

/* prod(L, P) = V se P eh a produto dos valores de L.
 *              Ex: prod([2, 3, 4], 24) = V */
prod([], 1).
prod([P|R], Prod) :-
    prod(R, ProdR),
    Prod is P * ProdR.

/* pertence(E, L) = V se E pertence a L. 
                    Ex: pertence(1, [1]) = V, pertence(1, [2, 3]) = F */
/* divide(L, L1, L2) = V se os elementos de L ocorrem intercalados 
                       em L1 e L2. Ex: divide([1, 2, 3, 4], [1, 3], [2, 4]) = V */
/* concatena(L1, L2, L) = L eh a concatenacao de L1 e L2.
 *                        Ex: concatena([1,2], [3,4], X) = V se X = [1,2,3,4] */
/* intercala(L1, L2, L) = L eh a combinacão ordenada de L1 e L2, 
 *                        onde L1 e L2 sao dadas ordenadas.
 *                        Ex: intercala([1,3,4], [2,5], [1,2,3,4,5]) */
/* ordena(L, LO) = V se LO eh a lista L, ordenada.
 *                 Ex: ordena([3,1,4,2], X) = V se X = [1,2,3,4] */



