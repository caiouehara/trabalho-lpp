;; Trabalho de Lisp para a matéria Linguagens e paradigmas de progamação
;; Caio Uehara Martins - nUSP 13672022

(defun derivada (exp var)
  (cond 
    ;; Regras Base
    ((numberp exp) 0)
    ( ;; Identidade
      (variavel? exp)
      (if (variavel-igual? exp var) 1 0))
      ( ;; Soma
        (soma? exp)
        (soma
          (derivada (sucessor exp) var)
          (derivada (sucessor-sucessor exp) var))
      )

      ( ;; Multiplicação
        (multiplicacao? exp)
        (soma
          (multiplicacao 
            (multplicador exp)
            (derivada (multiplicando exp) var)
          )
          (multiplicacao 
            (derivada (multplicador exp) var)
            (multiplicando exp)
          )
        )
      )

    ;;Funções Trigonométricas
    ;; Função Seno (sin)
    ((eq (car exp) 'sin)
     (multiplicacao
      (derivada (cadr exp) var)
      (cos (cadr exp))))

    ;; Função Cosseno (cos)
    ((eq (car exp) 'cos)
     (multiplicacao
      (derivada (cadr exp) var)
      (multiplicacao -1 (sin (cadr exp)))))

    ;; Função Tangente (tan)
    ((eq (car exp) 'tan)
     (multiplicacao
      (derivada (cadr exp) var)
      (expt (sec (cadr exp)) 2)))

    ;; Função Secante (sec)
    ((eq (car exp) 'sec)
     (multiplicacao
      (derivada (cadr exp) var)
      (multiplicacao (sec (cadr exp)) (tan (cadr exp)))))

    ;; Função Cotangente (cot)
    ((eq (car exp) 'cot)
     (multiplicacao
      (derivada (cadr exp) var)
      (multiplicacao -1 (expt (csc (cadr exp)) 2))))

    ;; Função Cosecante (csc)
    ((eq (car exp) 'csc)
     (multiplicacao
      (derivada (cadr exp) var)
      (multiplicacao -1 (multiplicacao (csc (cadr exp)) (cot (cadr exp))))))

    (t NIL)
    )
)

;; Auxiliares
(defun variavel? (x) (symbolp x))
(defun variavel-igual? (v1 v2)
  (and (variavel? v1) (variavel? v2) (eq v1 v2)))
(defun soma(a1 a2) (list '+ a1 a2))
(defun soma? (x)
  (and (listp x) (eq (car x) '+)))
(defun sucessor (s) (cadr s))
(defun sucessor-sucessor (s) (caddr s))
(defun multiplicacao (m1 m2) (list '* m1 m2))
(defun multiplicacao? (x)
  (and (listp x) (eq (car x) '*)))
(defun multplicador (p) (cadr p))
(defun multiplicando (p) (caddr p))

;; O formato de chamada da chamada de função é (derivada 'expressão 'x)
(print (derivada 'x 'x))