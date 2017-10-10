def sem_elemento_k(lista, k):    
    lista.remove(lista[k])
    return lista

from random import randint
def deque_embaralhado(deque):
    lista = [] 
    for i in range(len(deque)):
        k = randint(0,len(deque)-1)        
        lista.append(deque[k])
        sem_elemento_k(deque, k)
    return lista

def lista_mao(lista):
    mao = []
    for i in range(len(lista)):
        mao.append(lista[i][0] + lista[i][1])        
    return mao

def retorna_valor(carta):
    if(carta[0][0]=='A'):
        return 1
    elif (carta[0][0]=='2'):
        return 2
    elif (carta[0][0]=='3'):
        return 3
    elif (carta[0][0]=='4'):
        return 4
    elif (carta[0][0]=='5'):
        return 5
    elif (carta[0][0]=='6'):
        return 6
    elif (carta[0][0]=='7'):
        return 7
    elif (carta[0][0]=='8'):
        return 8
    elif (carta[0][0]=='9'):
        return 9
    else:
        return 0
    
def valor_mao(lista):
    soma = 0
    for i in range(len(lista)):
        soma =  soma + retorna_valor(lista[i][0])
    return soma%10


