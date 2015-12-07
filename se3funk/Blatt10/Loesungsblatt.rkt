#lang racket
;;; Autoren:
;;;  * Arne Beer
;;;  * Sören Nykamp
;;;  * Lars Thoms

;; Aufgabe 1.1


;; Aufgabe 1.1.1
(define (every p? xs)
  (foldl (lambda (x y) (and x y))
    #t
    (map p? xs)))


;; Aufgabe 1.1.2
(define (some f xs) (if (ormap f xs) (car (filter f xs)) #f))


;; Aufgabe 1.2

; Die Ausgangsmenge
(define menge (list 1 2 3 4 5))

; Symmetrisch, Transitiv, reflexiv
(define sym (list '(1 . 2) '(2 . 1) '(1 . 3) '(2 . 3) '(3 . 2) '(3 . 1) '(1 . 1) '(2 . 2) '(3 . 3)))

; Asymmetrisch, nicht transitiv, nicht reflexiv
(define asym (list '(1 . 2) '(2 . 3) ))

; Reflexiv
(define refl (list '(1 . 1) '(2 . 2) '(3 . 3) '(1 . 2)))

(define (symmetrisch? r)
  (every (lambda (x) (member (cons (cdr x) (car x)) r)) r)
)

(write "symmetrischer Test")
(symmetrisch? sym)
(symmetrisch? asym)

(define (asymmetrisch? r)
  (every (lambda (x) (not(member (cons (cdr x) (car x)) r))) r)
)

(write "asymmetrischer Test")
(asymmetrisch? asym)
(asymmetrisch? sym)

(define (reflexiv? r)
  (every
   (lambda (x)
      (and
        (member (cons (car x) (car x)) r)
        (member (cons (cdr x) (cdr x)) r))) 
        r))

(write "reflexiver Test")
(reflexiv? refl)
(reflexiv? asym)

(define (merge l1 l2)
      (if (null? l1) l2
          (if (null? l2) l1
              (cons (car l1) (cons (car l2) (merge (cdr l1) (cdr l2)))))))

(define (tranhelper rel m r xs)
    (if (empty? m)
        #t
        (if (some (curry equal? (cons (cdr rel) (car m))) (merge r xs))
            (if (some (curry equal? (cons (car rel) (car m))) (merge r xs))
                (tranhelper (cons (car rel) (car m)) (cdr m) r xs)
                #f )
            (tranhelper rel (cdr m) r xs))
))


(define (transitiv? m r [xs '()])
    (if (empty? r)
        #t
        (if (tranhelper (car r) m r xs)
            (transitiv? m (cdr r) (cons (car r) xs)) 
            #f)))

(write "transitiver Test")
(transitiv? menge sym)
(transitiv? menge asym)

;(define (aequivalenzrelation? xs) (and (reflexiv? xs) (symmetrisch? xs) (transitiv? xs)))

;(define (strordnungsrelation? xs) (and (asymmetrisch? xs) (transitiv? xs)))


;Aufgabe 2.1

(define (Kreuzprodukt xs ys)
  (cond ((empty? xs) (map list ys))
        ((empty? ys) (map list xs))
        (else
         (for*/list ([a xs]
                     [b ys]
                     )
            (cons a b)))))

;Aufgabe 2.2
(define (Produkt xs)
  (if (empty? xs)
      '()
      (Kreuzprodukt (car xs) (Produkt (cdr xs)))))

;; Aufgabe 3.1

; a) -1
; b) '(+ ,(- 2 4) 2)
; c) 'Alle
; d) '(auf (dem See))
; e) '(Listen sind einfach)
; f) '(Paare . auch)
; g) #t
; h) #f
; i) '(1 8 27)
; j) '(1 3 5)
; k) 2
; l) #t


;; Aufgabe 3.2

; Die Definition »test« ist kaputt. »let« braucht einen weiteren Bindungspartner
; Habe den Bug gefixt, damit überhaupt etwas funktioniert...

; 1) *a* bildet auf den Wert 10 ab
; 2) Man kann keine Zahl auf ein Symbol addieren
; 3) 20; »eval« entfernt die Quotierung bei *b*
; 4) wertet zu #f aus, aber nur, weil Racket die erste Bedingung überprüft hat.
;    Die zweite ist fehlerhaft (Zahl kleiner als Symbol?!)
; 5) Fehlerhaft, da durch Null geteilt wird
; 6) Fehlerhaft, man kann eine Zahl nicht mit einer Prozedur addieren
; 7) 5, da durch die zusätzliche Klammerung, das Ergebnis der übergebenen
;    Prozedur ausgegeben wird.
; 8) Nach dem Bugfix kommt 16 raus. Vor dem Bugfix gibt die Definition selber
;    einen Fehler aus, da »let« einen weiteren Bindungspartner braucht.


;; Aufgabe 3.3

; a) (+ (* 3 4) (* 5 6))
; b) (sqrt (- 1 (sqr (sin x))))


;; Aufgabe 3.5

; a) (- (+ 1 (/ 4 2)) 1)
; b) (/ (- 2 (/ (+ 1 3) (+ 3 (* 2 3)))) (sqrt 3))


;; Aufgabe 3.6

; (1 + 2 + 3) * (2 - 3 - (2 - 1))


;; Aufgabe 3.8

(define (make-length value unit)
    (list value unit))


(define (value-of-length len)
    (car len))

(define (unit-of-length len)
    (cadr len))

(define (scale-length len fac)
    (make-length (* fac (value-of-length len)) (unit-of-length len)))

(define *conversiontable*
    '(
        (m . 1)
        (cm . 0.01)
        (mm . 0.001)
        (km . 1000)
        (inch . 0.0254)
        (feet . 0.3048)
        (yard . 0.9144)))

(define (factor unit)
    (cdr (assq unit *conversiontable*)))

(define (length->meter len)
    (make-length
        (value-of-length
            (scale-length len (factor (unit-of-length len)))) 'm))

(define (length< len1 len2)
    (<
        (value-of-length (length->meter len1))
        (value-of-length (length->meter len2))))

(define (length= len1 len2)
    (=
        (value-of-length (length->meter len1))
        (value-of-length (length->meter len2))))

(define (length+ len1 len2)
    (make-length
        (+
            (value-of-length (length->meter len1))
            (value-of-length (length->meter len2)))
        'm))

(define (length- len1 len2)
    (make-length
        (-
            (value-of-length (length->meter len1))
            (value-of-length (length->meter len2)))
        'm))

(define xs '((6 km) (2 feet) (1 cm) (3 inch)))

(map length->meter xs)


