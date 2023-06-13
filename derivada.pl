/* FUNÇÕES PARA DERIVADA */

/* regras básicas */
deriva(U+V,X,DU+DV):- 
    deriva(U,X,DU), 
    deriva(V,X,DV).

deriva(U-V,X,DU-DV):- 
    deriva(U,X,DU), 
    deriva(V,X,DV).

deriva(U*V,X,DU*V+U*DV):- 
    deriva(U,X,DU), 
    deriva(V,X,DV).

deriva(U/V,X,(DU*V+U*DV)/V^2):- 
    deriva(U,X,DU), 
    deriva(V,X,DV).

/* regra do polinômio */
deriva(U^N,X,N*U^(N-1)*DU):-
	integer(N), atomic(N), N\==X,
	deriva(U,X,DU).

deriva(-V,X,-DV):- deriva(V,X,DV).

/* regras da exponencial e logarítmica */
deriva(exp(V),X,exp(V)*DV):- deriva(V,X,DV).
deriva(ln(V),X,DV/V):- deriva(V,X,DV).
deriva(A^V,X,(A^V)*ln(A)*DV):-
	integer(A), atomic(A), A\==X,
	deriva(V,X,DV).

/* regras das trigonométricas */
deriva(sen(W),X,Z*cos(W)):- deriva(W,X,Z).
deriva(cos(W),X,-Z*sen(W)):- deriva(W,X,Z).
deriva(tg(W),X,Z*sec(W)^2):- deriva(W,X,Z).
deriva(cotg(W),X,-Z*csc(W)^2):- deriva(W,X,Z).
deriva(sec(W),X,Z*sec(W)*tg(W)):- deriva(W,X,Z).
deriva(csc(W),X,-Z*csc(W)*cotg(W)):- deriva(W,X,Z).

deriva(arcsen(V),X,(1-V^2)^(-1/2)*DV):- deriva(V,X,DV).
deriva(arccos(V),X,-(1-V^2)^(-1/2)*DV):- deriva(V,X,DV).
deriva(arctg(V),X,(1+V^2)^(-1)*DV):- deriva(V,X,DV).
deriva(arccotg(V),X,-(1+V^2)^(-1)*DV):- deriva(V,X,DV).
deriva(arcsec(V),X,(V^2-1)^(-1/2)*DV):- deriva(V,X,DV).
deriva(arccsc(V),X,-(V^2-1)^(-1/2)*DV):- deriva(V,X,DV).

/* regras das hiperbólicas */
deriva(senh(W),X,Z*cosh(W)):- deriva(W,X,Z).
deriva(cosh(W),X,-Z*senh(W)):- deriva(W,X,Z).
deriva(tgh(W),X,Z*sech(W)^2):- deriva(W,X,Z).
deriva(cotgh(W),X,-Z*csch(W)^2):- deriva(W,X,Z).
deriva(sech(W),X,Z*sech(W)*tgh(W)):- deriva(W,X,Z).
deriva(csch(W),X,-Z*csch(W)*cotgh(W)):- deriva(W,X,Z).

deriva(arcsenh(V),X,DV/(V^2+1)^(1/2)):- deriva(V,X,DV).
deriva(arccosh(V),X,DV/(V^2-1)^(1/2)):- deriva(V,X,DV).
deriva(arctgh(V),X,DV/(1-V^2)):- deriva(V,X,DV).
deriva(arccotgh(V),X,DV/(1+V^2)):- deriva(V,X,DV).
deriva(arcsech(V),X,-DV/((DV)*(-V^2+1)^(1/2))):- deriva(V,X,DV).
deriva(arccsch(V),X,-DV/((DV)*(V^2+1)^(1/2))):- deriva(V,X,DV).

/* regras simples */
deriva(X,X,1).
deriva(C,X,0):- atomic(C), C\==X.

/* FUNÇÕES PARA SIMPLIFICAÇÃO */

simplifica(X+0,X).
simplifica(1*X,X).
simplifica(X^1,X).
simplifica(X^0,X/X).
simplifica(X^A*X^B,X^C):- C is A+B.
simplifica(X^A/X^B,X^C):- C is A-B.
simplifica(X*(A+B),X*C):- C is A+B.
simplifica(X*(A-B),X*C):- C is A-B.