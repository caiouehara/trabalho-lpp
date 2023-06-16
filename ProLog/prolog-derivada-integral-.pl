/*
Caio Uehara Martins
nUSP: 13672022
BCC, T4
Linguagem e paradigma de progamação

O programa funciona de forma que o comando 
d(Função, Resultado da derivada) retorne: T ou F ou
d(Função, Variável) retorne: Variável = Derivada

*/

%C é um real
%K é um real
%N é um inteiro
%U é uma função com domínio nos reais
%V é uma função com domínio nos reais
%DV é a derivada de V
%DU é a derivada de U

% Regras para cálculo da derivada
    % Regras base
% Aqui, usa-se corte para não haver mais de uma resposta para a variável
d(X, 1) :- var(X), !.
d(C, 0) :- float(C); integer(C), !.

d(C*X, C):- float(C); integer(C) , var(X), !.
%d(X*C, C):- float(C); integer(C) , var(X).

d(X^C, C * (X ^ N1) ) :- atomic(C), N1 is C - 1, !.

    % Regras da exponeciação e logarítimicas
d(exp(V),exp(V)*DV):- d(V,DV).
d(ln(V),DV/V):- d(V,DV).
d(C^U,(C^U)*ln(U)*DU):- integer(A); float(A), d(U,DU). 

    % Regras trigonométricas
d(sin(X), cos(X)).
d(cos(X), -sin(X)).
d(tan(X), 1 / (cos(X) ^ 2)).
d(sec(X), sec(X) * tan(X)).
d(csc(X), -csc(X) * cot(X)).
d(cot(X), -1 / (sin(X) ^ 2)).

    % Regras trigonométricas inversas
d(arcsen(V), (1-V^2)^(-1/2)*DV):- d(V, DV).
d(arccos(V), -(1-V^2)^(-1/2)*DV):- d(V, DV).
d(arctg(V), (1+V^2)^(-1)*DV):- d(V, DV).
d(arccotg(V), -(1+V^2)^(-1)*DV):- d(V, DV).
d(arcsec(V), (V^2-1)^(-1/2)*DV):- d(V, DV).
d(arccsc(V), -(V^2-1)^(-1/2)*DV):- d(V, DV).

    % Regras hiperbólicas
d(senh(K), Z*cosh(K)):- d(K, Z).    
d(cosh(K), -Z*senh(K)):- d(K, Z).
d(tgh(K), Z*sech(K)^2):- d(K, Z).
d(cotgh(K), -Z*csch(K)^2):- d(K, Z).
d(sech(K), Z*sech(K)*tgh(K)):- d(K, Z).
d(csch(K), -Z*csch(K)*cotgh(K)):- d(K, Z).

    % Regras hiperbólicas inversas
d(arcsenh(V), DV/(V^2+1)^(1/2)):- d(V, DV).
d(arccosh(V), DV/(V^2-1)^(1/2)):- d(V, DV).
d(arctgh(V), DV/(1-V^2)):- d(V, DV).
d(arccotgh(V), DV/(1+V^2)):- d(V, DV).
d(arcsech(V), -DV/((DV)*(-V^2+1)^(1/2))):- d(V, DV).
d(arccsch(V), -DV/((DV)*(V^2+1)^(1/2))):- d(V, DV).

% As regras de multiplicação e soma devem vir no final, para que a precedência esteje correta

    % Regras da multiplicação e da divisão
d(U*V, DU*V+U*DV):- d(U, DU), d(V, DV).
d(U/V,(DU*V+U*DV)/V^2):- d(U, DU), d(V, DV).

    % Regras da soma
d(U + V, DU + DV) :- d(U, DU), d(V, DV).
d(U - V, DU - DV) :- d(U, DU), d(V, DV).

% Regra para a regra da cadeia
d(U * V, DU * V + U * DV) :- d(U, DU), d(V, DV).