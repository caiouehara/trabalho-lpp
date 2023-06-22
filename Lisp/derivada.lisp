(defvar entrada x)



;; Regras de derivação em ordem
(defun variavel?(x) (symbolp x))
(defun igual? (v1 v2) (and (variavel v1) (variavel v2) (eq v1 v2)))
(defun soma (a1 a2) (list '+ a1 a2))
(defun soma? (x) (and (listp x) (eq (car x) '+)))
(defun playing/addend (s) (cadr s))
(defun playing/augend (s) (caddr s))
(defun produto (m1 m2) (list '* m1 m2))
(defun produto? (x)
  (and (listp x) (eq (car x) '*)))
(defun playing/multiplier (p) (cadr p))
(defun playing/multiplicand (p) (caddr p))

(defun derivada (exp var)
  (cond ((numberp exp) 0)
        ((variable? exp)
         (if (igual? exp var) 1 0))
        ((soma? exp)
         (soma (derivada (playing/addend exp) var)
                   (derivada (playing/augend exp) var)))
        ((produto? exp)
         (soma
           (produto(playing/multiplier exp)
                         (derivada (playing/multiplicand exp) var))
           (produto (derivada (playing/multiplier exp) var)
                         (playing/multiplicand exp))))
        (t (error "unknown expression type -- DERIV" exp))))


(derivada entrada 'x)

(print entrada)