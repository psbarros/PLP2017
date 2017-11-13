%Lista de Suspeitos
suspeito(lucas).
suspeito(paulo).
suspeito(alex).
suspeito(bernardo).
suspeito(luiz).
%Alibe é aceito se veio de alguém confiável 
confiavel(bernardo).
confiavel(lucas).
%Quem possui armas
arma(lucas).
arma(alex).
arma(bernardo).
arma(luiz).
%Quem possui alibe
alibe(lucas,bernardo).
alibe(paulo,bernardo).
alibe(alex,lucas).
alibe(luis,lucas).
%Motivos 
motivo(vinganca,lucas).
motivo(vinganca,paulo).
motivo(herdeiro,bernardo).
motivo(devendo,lucas).
motivo(devendo,luiz).
motivo(flagra,alex).

%Consulta 
%motivo(Z,X),arma(X),\+alibe(X,Y)
