#lang racket
;;; Autoren:
;;;  * Arne Beer
;;;  * Sören Nykamp
;;;  * Lars Thoms


;Aufgabe 1.1
; Es wird eine assoziative Liste verwendet.
; Es wird ein Char eingegeben und der jeweilige String ausgegeben.
(define Internationale-Buchstabiertafel
   '((#\A . "Alfa")
     (#\B . "Bravo")
     (#\C . "Charlie")
     (#\D . "Delta")
     (#\E . "Echo")
     (#\F . "Foxtrott")
     (#\G . "Golf")
     (#\H . "Hotel")
     (#\I . "India")
     (#\J . "Juliett")
     (#\K . "Kilo")
     (#\L . "Lima")
     (#\M . "Mike")
     (#\N . "November")
     (#\O . "Oscar")
     (#\P . "Papa")
     (#\Q . "Quebec")
     (#\R . "Romeo")
     (#\S . "Sierra")
     (#\T . "Tango")
     (#\U . "Uniform")
     (#\V . "Viktor")
     (#\W . "Whiskey")
     (#\X . "X-ray")
     (#\Y . "Yankee")
     (#\Z . "Zulu")
     (#\0 . "Nadazero")
     (#\1 . "Unaone")
     (#\2 . "Bissotwo")
     (#\3 . "Terrathree")
     (#\4 . "Kartefour")
     (#\5 . "Pantafive")
     (#\6 . "Soxisix")
     (#\7 . "Setteseven")
     (#\8 . "Oktoeight")
     (#\9 . "Novenine")
     (#\, . "Decimal")
     (#\. . "Stop")))




;Aufgabe 1.2

(define (char->name_ c list)
    (cond
        [(empty? list) (error (string-append "Kein Name gefunden für: #\\" (string c)))]
        [(equal? c (caar list)) (cdar list)]
        [else (char->name_ c (cdr list))]))

(define (char->name c)
    (char->name_ c buchstabiertafel))



;Aufgabe 1.3

(define (downchar->name c)
    (char->name_ (char-upcase c) buchstabiertafel))



;Aufgabe 1.4

(define (char->iname c) (char->name (char->upper c)))

(define (buchstabiere a)
    (cond
        [(string? a) (buchstabiere (string->list a))]
        [(empty? a) ""]
        [else (let ([append (string-append (if (empty? (cdr a)) "" " ") (buchstabiere (cdr a)))])
            (string-append (char->iname (car a)) append))])




;;Aufgabe 2
(require se3-bib/flaggen-module)

;Es wird eine Liste von Paaren genutzt.
;So ist jedem Char der richige Buchstabe zugeordnet,
;der bei Evaluierung zur Anzeige der Flagge führt.
;Die Reihenfolge folgt dabei in etwa der Verteilung
;der Buchstaben in einem durchschnittlichen deutschen Text,
;damit für häufige Buchstaben, wie etwa das N nicht erst die
;halbe Liste durchlaufen werden muss.
;Jeder Eintrag ist explizit ein Paar, keine Liste, da somit die
;leere Liste kein Problem darstellt.
(define Flaggenalphabet
  (list '(#\E . E)
        '(#\N . N)
        '(#\I . I)
        '(#\S . S)
        '(#\R . R)
        '(#\A . A)
        '(#\T . T)
        '(#\D . D)
        '(#\H . H)
        '(#\U . U)
        '(#\L . L)
        '(#\C . C)
        '(#\G . G)
        '(#\M . M)
        '(#\O . O)
        '(#\B . B)
        '(#\W . W)
        '(#\F . F)
        '(#\K . K)
        '(#\Z . Z)
        '(#\P . P)
        '(#\V . V)
        '(#\J . J)
        '(#\Y . Y)
        '(#\X . X)
        '(#\Q . Q)
        '(#\0 . Z0)
        '(#\1 . Z1)
        '(#\2 . Z2)
        '(#\3 . Z3)
        '(#\4 . Z4)
        '(#\5 . Z5)
        '(#\6 . Z6)
        '(#\7 . Z7)
        '(#\8 . Z8)
        '(#\9 . Z9)))

;findFlag läuft mit einer inneren Funktion,
;die die Flaggen für das jeweilige Zeichen heraussucht.
;Dabei ist ein eval anzuwenden, um auch tatsächlich die Flagge zu bekommen
(define (findFlag X)
  (letrec ([findFlagFromList (lambda (X Y)
                         (if (eqv? X (caar Y)) (cdar Y)
                             (findFlagFromList X (cdr Y))))])
    (eval (findFlagFromList X Flaggenalphabet))))

;Die innere Funktion von flagsForString wurde einzig und allein dazu erschaffen,
;nicht in jedem Schritt für die restlichen Buchstaben wieder das Char equivalent
;errechnen zu müssen.
;Sie überprüft in jedem Schritt, ob die übergebene Liste leer ist, sollte sie das 
; nicht sein, so ist das Ergebnis das Flaggensymbol zum ersten Char zu einem Paar vereint mit dem
;Ergebnis der restlichen Liste

(define (flagsForString String)
  (letrec ([List (string->list String)]
           [flagging (lambda (Liste)
                       (if (empty? Liste) '()
                           (cons (findFlag (car Liste)) (flagging (cdr Liste)))))])
    (flagging List)))

