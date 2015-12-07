#lang racket
;;; Autoren:
;;;  * Arne Beer
;;;  * Sören Nykamp
;;;  * Lars Thoms

( define miau 'Katze )
( define plueschi miau )
( define peter 'miau )
( define ( welcherNameGiltWo PersonA PersonB )
( let ( ( PersonA 'Sam)
( PersonC PersonA ) )
PersonC ) )
( define xs1 ' ( 0 1 2 miau plueschi ) )
( define xs3 ( list miau plueschi ) )
( define xs2 ( cons plueschi miau ) )


;; Aufgabe 1

;  1. 'Katze           (Variable -> Symbol)
;  2. 'Katze           (Variable -> Variable -> Symbol)
;  3. 'miau            (Variable -> Symbol)
;  4. 'plueschi        (quote erstellt ein Symbol aus dem Namen)
;  5. 'Katze           (eval macht aus 'miau die Variable miau)
;  6. undefined        (Definition Katze gibt es nicht)
;  7. 'Katze           (Wandelt 'plueschi in plueschi um)
;  8. 'Ich             (die Reihenfolge bei let legt Racket fest,
;                      somit wird PersonA nicht überschrieben)
;  9. '(miau plueschi) (cdddr nimmt die letzten beiden Elemente der
;                      Liste x1)
; 10. 'Katze           (cons erstellt ein neues Paar und dank cdr
;                      wird nur das letzte Element ausgewählt)
; 11. '(Katze)         (list erstellt eine neue Liste und dank cdr
;                      wird nur das letzte Element ausgewählt)
; 12. 0.1411200080598672 (sin 3 ergibt schon ein Symbol, dementsprechend
;                      ändert sich durch eval nichts)
; 13. 'peter           (welcherNameGilt spuckt 'peter aus und ein
;                      Symbol von einem Symbol ist nach eval ein
;                      Symbol)
; 14. 'miau            (miau wurde von einer variable zu einem Symbol
;                      umgewandelt und wird somit nicht vorher
;                      ausgewertet [Katze])



;; Aufgabe 2.1:

(define (fac n)
  (if (= n 0)
    1
    (* n (fac (- n 1)))
  )
)

(fac 3)

;; Aufgabe 2.2:
(define (power r n)
  (if (= n 0)
    1
    (if (odd? n)
    (*
      (power r (- n 1))
      r
    )
    (sqr
      (power r (/ n 2))
    )
    )
  )
)

;; Aufgabe 2.3

;myEuler arbeitet mit einer rekursiven inneren Funktion,
;dabei wird solange ein weiterer Schritt gegangen bis der neue
;Term klein genug ist. 
(define (myEuler)
	(letrec ([eulerIntern (lambda (x)
                (let ([a (/ 1 (fac x))]
                    [b (/ 1 (expt 10 1000))])
		(if (< a b) a (+ a (eulerIntern (+ x 1))))))])
          (eulerIntern 0))
  )

(define (showEuler)
  (* (myEuler) (expt 10 1001)))


;; Aufgabe 2.4:

(define (leibnizReihe n)
  (if (= n 0)
    1 (+ (/ (1) (+ (* 2 n) 1 )) (leibnizReihe(- n 1)))
    ))

;; Aufgabe 3:

(define (type-of x)
    (cond
      ((boolean? x) 'boolean)
      ((pair? x) 'pair)
      ((list? x) 'list)
      ((symbol? x) 'symbol)
      ((number? x) 'number)
      ((char? x) 'char)
      ((string? x) 'string)
      ((vector? x) 'vector)
      ((procedure? x) 'procedure)
      ))

;(type-of (+ 3 7)) -> 'number
;zunächst wird der innere Ausdruck evaluiert zu 10, dann als Number erkannt und ausgegeben

;(type-of type-of) -> 'procedure
;type-of wird als das erkannt, was es ist: Eine Funktion

;(type-of (type-of type-of)) -> 'symbol
;Da wir uns in unserer Implementation dazu entschieden haben, 
;Symbole für die Ausgabe zu nutzen,
;ist der Typ der Typausgabe von type-of ('procedure) ein Symbol

;(type-of (string-ref "Schneewitchen_und_die_7_Zwerge" 2)) -> 'char
;string-ref gibt das Zeichen an der bezeichneten Stelle im String wieder
;dieses ist als Teil eines Strings ein char

;(type-of (lambda (x) x)) -> 'procedure
;Auch eine Funktion ohne Namen ist eine Funktion und damit ergibt sich 'procedure

(define (id z) z)

;(type-of (id cos)) -> 'procedure
;id gibt das wieder was es bekommt(also die Identität).
;Bei cos handelt es sich um eine Funktion, daher ergibt
;sich 'procedure als Ergebnis der type-of Anfrage

;(type-of '(1 2 3)) -> 'pair
;Eine Liste ist ein Paar aus dem ersten Element und der Restliste
;Hätten wir erst gefragt, ob es eine Liste ist und dann erst ob es ein Paar ist,
;so wäre das Ergebnis 'list gewesen

;(type-of '()) -> 'list
;Die leere Liste ist zwar eine Liste per Definition, aber kein Paar
