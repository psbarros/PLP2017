#!/usr/bin/python3
#Questão 9
# Para utilizar este programa, chame-o na linha de comando da seguinte forma:
# 1. sem argumentos, para criar uma partida aleatória entre dois jogadores da máquina;
# 2. com 'questao9.py estatistica n', substituindo 'n' por um número inteiro, para gerar n partidas utilizando
#   a função heurística criada e dizer quantas vezes a função heurística ganhou do jogador aleatório;
# 3. com 'questao9.py interativo' para ter uma partida em que o usuário toma o lugar do jogador 0, contra um
#   jogador aleatório.

# Explanação da função heurística:
#   Para criar um algoritmo ganancioso para jogar esse jogo, precisamos, a cada turno, verificar qual jogada
# traria mais pontos para o jogador, entre todas as possíveis, e, caso não haja nenhuma jogada que traga pontos,
# jogamos aleatoriamente.
#   A implementação consistiu em, primeiramente, para cada jogada possível para o jogador, verificar quantos pontos
# resultariam da jogada hipotética, e, caso a jogada pontue, é incluída numa lista na forma de uma tupla com
# a posição a ser jogada e os pontos resultantes (jogada, pontos).
#   A lista contém todas as jogadas que pontuam, com sua quantidade de pontos resultantes. Se essa lista possui
# um tamanho 0, não há jogadas que pontuem, portanto, podemos jogar aleatoriamente. (Há que se pensar que talvez
# a jogada de índice mais baixo possível talvez fosse mais vantajosa, possivelmente colocando menos feijões em
# buracos do adversário, mas preferi 'isolar' a heurística gananciosa, pra que ela fosse o fator preponderante
# para a estatística de vitórias.)
#   Caso haja jogadas que pontuam, precisamos descobrir qual a que mais pontua, para isso, ordeno a lista de
# tuplas utilizando o segundo elemento de cada tupla (a pontuação resultante da jogada) como critério de
# comparação. Assim, o último elemento da lista será a jogada com o melhor resultado (ou uma das jogadas com
# melhor resultado, o que já é o suficiente).
#   A heurística implementada atingiu uma média entre 70 e 80%, pela minha observação, atingindo picos de 95% e
# vales de 60% em execuções sucessivas de rodadas de 20 partidas, com './questao9.py estatistica 20'. Devido à
# forma de implementação, com recursão em diversas funções, execuções de 100 partidas se mostraram inconstantes,
# frequentemente esbarrando na limitação de linguagem de níveis de recursão, causando erros de execução.

from random import randint
import sys

def playable_pits(pits, p_id):
    return [i for i in range(p_id * 6, (p_id + 1) * 6) if pits[i] > 0]

def input_pit(pits, p_id):
    target = int(input('Diga um numero entre: ' + str(playable_pits(pits, p_id))))
    return target if target in playable_pits(pits, p_id) else input_pit(pits, p_id)

def interactive_pit(pits, p_id):
    return -1 if len(playable_pits(pits,p_id)) == 0 else input_pit(pits, p_id)

def heuristic_pit(pits, p_id):
    prio = sorted([(pos, sow_points(pits, pos)[1]) for pos in playable_pits(pits, p_id) if sow_points(pits, pos)[1] > 0], key = lambda p: p[1])
    return random_pit(pits, p_id) if len(prio) <= 0 else prio[-1][0]

def random_pit(pits, p_id):
    candidatos = playable_pits(pits, p_id)
    return candidatos[randint(0, len(candidatos)-1)] if len(candidatos) > 0 else -1

def circular_rdistance(t, p1, p2):
    return t - p1 + p2 if p1 > p2 else p2 - p1

def sow(pits, target):
    return [(pits[i] + (pits[target] // 11) + (0 if pits[target] % 11 < circular_rdistance(12, target, i) else 1)) if i != target else 0 for i in range(12)]

def cprevious(t, pos):
    return pos - 1 if pos != 0 else t - 1

def last_sown_pit(pits, target):
    return ((target + (pits[target] % 11)) % 11) - (1 if ((target + (pits[target] % 11)) % 11) <= target else 0)

def pits_with_zero_at(pits, target):
    return [pits[i] if target != i else 0 for i in range(0,12)]

def sow_points_recursive(pits, pos, points):
    return (pits, points) if (pits[pos] not in [2, 4, 6]) else (sow_points_recursive(pits_with_zero_at(pits, pos), cprevious(12, pos), pits[pos] + points))

def sow_points(pits, pos):
    return (pits, 0) if (pits[pos] not in [2, 4, 6]) else (sow_points_recursive(pits_with_zero_at(pits, pos), cprevious(12, pos), pits[pos]))

def play(p_id, choose_pit, pits, p0, p1):
    pit = choose_pit(pits, p_id)
    if pit == -1:
        points = sum(pits)
    else:
        pits, points = sow_points(sow(pits, pit), last_sown_pit(pits, pit))
    return (pits, p0 + points, p1) if p_id == 0 else (pits, p0, p1 + points)

def end_game(p0, p1):
    return (p0 > 36 or p1 > 36)

def report_result(p0, p1):
    print(("Jogador 0 venceu" if p0 > 36 else ("Jogador 1 venceu" if p1 > 36 else "Empate")))
    return 1 if p0 > 36 else 0

def match_r(turn, players, pits, p0, p1):
    pits, p0, p1 = play(turn % 2, players[turn % 2], pits, p0, p1)
    print(turn, turn % 2, ':', [p0, p1, pits])
    if end_game(p0, p1):
        return report_result(p0, p1)
    else:
        return match_r(turn + 1, players, pits, p0, p1)

def match(choose_pit0, choose_pit1):
    pits, p0, p1 = [6 for i in range(12)], 0, 0
    print('Inicio: ', [p0, p1, pits])
    return match_r(0, [choose_pit0, choose_pit1], pits, p0, p1)

if len(sys.argv) == 1:
    match(random_pit, random_pit)
elif sys.argv[1] == 'estatistica':
    print('Venceu', (sum([match(heuristic_pit, random_pit) for i in range(int(sys.argv[2]))])), 'partidas.')
elif sys.argv[1] == 'interativo':
    match(interactive_pit, random_pit)
