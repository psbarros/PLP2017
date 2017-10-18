#questao2
Divisor_Proprio = lambda n: [i for i in range(1,n) if n%i==0]
print(Divisor_Proprio(10)) 

#questao3
amigos = lambda n1,n2: True if sum([i for i in range(1,n1) if n1%i==0]) == n2 or sum([i for i  in range(1,n2) if n2%i==0])==n1 else False
#print(amigos(10,11)) 

#questao4
duas_vezes = lambda f,n: f(f(n))
#print(duas_vezes(lambda n: n/2, 4)) 


#questao5
composicao = lambda fl,n: sum ([fl[i+1](fl[i](n)) for i in range(len(fl)-1)])
#print(composicao([lambda n:n+2, lambda n:n*n], 3))


#questao6
soma_coluna = lambda m: [reduce(lambda x, y: x + y, [i[j] for i in m]) for j in range(len(m[0]))]
m = [[1,2,3],[3,4,5],[5,6,7]]
#print (soma_coluna(m)) 

#questao7
conte_filtro = lambda lf, la :[[sum([lf[j](la[i]) for j in range(len(lf))]) for i in range(len(la))]]
#print (conte_filtro([lambda n:n%2==0,lambda n:n%3==0],range(10))) 


#quest8
def map_elementos(f,lst):
    for i in range (len(lst)):
        if type (lst[i])==list:
            map_elementos(f,lst[i])
        else:
            lst[i]= f(lst[i])
    return (lst)
f= lambda n: 2*n
lst= [1, [7, 3, [4, 5], 8],7]
#print (map_elementos(f,lst))






