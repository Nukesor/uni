#lang racket
;;; Autoren:
;;;  * Arne Beer
;;;  * Sören Nykamp
;;;  * Lars Thoms


;; Aufgabe 1.1

(max (min 2 (- 2 5)) 0)
; 0
; Es wird 2-5 ausgewertet -> -3
; Dann das Minimum von 2 und -3 ausgewählt -> -3
; Und schließlich das Maximum aus -3 und 0 -> 0


;; Aufgabe 1.2

'(+ (- 2 13) 2)
; '(+ (- 2 13) 2)
; Das Quote verhindert die Evaluation des Ausdrucks


;; Aufgabe 1.3

(cadr '(Alle Jahre wieder))
; 'Jahre
; Wir erhalten das erste Element des zweite Teils der Liste


;; Aufgabe 1.4

(cddr '(kommt (das Weihnachtsfest)))
; '()
; Wir haben eine Liste aus zwei Elementen + das implizite Element.
; Mit dem ersten d wird das kommt abgeschnitten wir haben also die 
; Liste aus der Liste '(das Weihnachtsfest) und der leeren Liste
; mit dem zweiten d bekommen wir somit den hinteren Teil, also die leere Liste.


;; Aufgabe 1.5

(cons 'Listen '(ganz einfach und))
; '(Listen ganz einfach und)
; Wir bilden das paar aus 'Listen und einer Liste,
; dies ist wieder eine Liste per Definition.


;; Aufgabe 1.6

(cons 'Paare 'auch)
; '(Paare . auch)
; Da wir nur zwei Symbole mit cons verbinden,
; haben wir ein Paar, keine Liste


;; Aufgabe 1.7

(equal? (list 'Racket 'Prolog 'Java) '(Racket Prolog Java))
; #t
; Die Funktion list baut aus 'Racket 'Prolog und 'Java
; Die Liste '(Racket Prolog Java), somit ist dies gleich mit
; '(Racket Prolog Java)


;; Aufgabe 1.8

(eq? (list 'Racket 'Prolog 'Java) (cons 'Racket '(Prolog Java)))
; #f
; eq? liefert true, wenn die übergebenen Werte auf das selbe Object verweisen
; Dies ist bei den beiden Listen nicht der Fall.
; equal? hätte in diesem Fall ebenfalls true geliefert.


;------------------------------------------------------------------------------

;; Aufgabe 2.1

; <Notruf> ::= "MAYDAY MAYDAY MAYDAY" <Eigenmeldung> <Standortangabe>
;              <Notfallangabe> <Sendezeichen> <Unterschrift> "OVER"
; <Eigenmeldung> ::= <Hier> <Schiffsname> <Schiffsname> <Schiffsname>
;                    <Rufzeichen> "MAYDAY" <Schiffsname> "ICH BUCHSTABIERE"
;                    <Schiffsname Buchstabiert> "RUFZEICHEN" <Rufzeichen>
; <Hier> ::= "HIER IST" | "DELTA ECHO"
; <Schiffsname> ::= {<Buchstabe>}
; <Buchstabe> ::= "A" | "B" | "C" | "D" | "E" | "F" | "G" | "H" | "I" | "J" |
;                 "K" | "L" | "M" | "N" | "O" | "P" | "Q" | "R" | "S" | "T" |
;                 "U" | "V" | "W" | "X" | "Y" | "Z"
; <Rufzeichen> ::= <Buchstabiert> <Buchstabiert> <Buchstabiert> <Buchstabiert>
; <Buchstabiert> ::= "ALFA" | "BRAVO" | "CHARLIE" | "DELTA" | "ECHO" | "FOXTROTT" |
;                    "GOLF" | "HOTEL" | "INDIA" | "JULIETT" | "KILO" | "LIMA" |
;                    "MIKE" | "NOVEMBER" | "OSCAR" | "PAPA" | "QUEBECK" | "ROMEO" |
;                    "SIERRA" | "TANGO" | "UNIFORM" | "VIKTOR" | "WHISKEY" |
;                    "X-RAY" | "YANKEE" | "ZULU"
; <Schiffsname Buchstabiert> ::= {<Buchstabiert>}
; <Standortangabe> ::= {<Buchstabe>|<Ziffer>}
; <Ziffer> ::= "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9"
; <Notfallangabe> ::= {<Buchstabe>|<Ziffer>}
; <Sendezeichen> ::= "ICH SENDE DEN TRÄGER --"
; <Unterschrift> ::= <Schiffsname> <Rufzeichen>


;; Aufgabe 2.2

(define Buchstaben
     (list '(#\A . "ALFA ")
           '(#\B . "BRAVO ")
           '(#\C . "CHARLIE ")
           '(#\D . "DELTA ")
           '(#\E . "ECHO ")
           '(#\F . "FOXTROTT ")
           '(#\G . "GOLF ")
           '(#\H . "HOTEL ")
           '(#\I . "INDIA ")
           '(#\J . "JULIETT ")
           '(#\K . "KILO ")
           '(#\L . "LIMA ")
           '(#\M . "MIKE ")
           '(#\N . "NOVEMBER ")
           '(#\O . "OSCAR ")
           '(#\P . "PAPA ")
           '(#\Q . "QUEBEC ")
           '(#\R . "ROMEO ")
           '(#\S . "SIERRA ")
           '(#\T . "TANGO ")
           '(#\U . "UNIFORM ")
           '(#\V . "VIKTOR ")
           '(#\W . "WHISKEY ")
           '(#\X . "X-RAY ")
           '(#\Y . "YANKEE ")
           '(#\Z . "ZULU ")))

(define (findChar X)
    (letrec ([findCharFromList (lambda (X Y)
                                   (if (eqv? X (caar Y)) (cdar Y)
                                   (findCharFromList X (cdr Y))))])
    (findCharFromList X Buchstaben)))

(define (charsForString String)
    (letrec ([List (string->list String)]
             [flagging (lambda (Liste)
                       (if (empty? Liste) '()
                           (cons (findChar (car Liste)) (flagging (cdr Liste)))))])
    (flagging List)))


(define (mayday name rufzeichen position information)
    (string-append
        "MAYDAY MAYDAY MAYDAY DELTA ECHO "
        name " " name " " name " "
        (string-append* (charsForString rufzeichen))
        "MAYDAY " name " ICH BUCHSTABIERE "
        (string-append* (charsForString name))
        "RUFZEICHEN "
        (string-append* (charsForString rufzeichen))
        position " "
        information " "
        "ICH SENDE DEN TRÄGER -- "
        name " "
        (string-append* (charsForString rufzeichen))
        "OVER"))


;; Aufgabe 2.3

(mayday "BABETTE" "DEJY" "NOTFALLPOSITION UNGEFÄHR 10 SM NORDÖSTLICH LEUCHTTURM
    KIEL" "NOTFALLZEIT 1000 UTC SCHWERER WASSEREINBRUCH WIR SINKEN KEINE
    VERLETZTEN VIER MANN GEHEN IN DIE RETTUNGSINSEL SCHNELLE HILFE ERFORDERLICH")
; "MAYDAY MAYDAY MAYDAY DELTA ECHO BABETTE BABETTE BABETTE DELTA ECHO JULIETT
; YANKEE MAYDAY BABETTE ICH BUCHSTABIERE BRAVO ALFA BRAVO ECHO TANGO TANGO ECHO
; RUFZEICHEN DELTA ECHO JULIETT YANKEE NOTFALLPOSITION UNGEFÄHR 10 SM NORDÖSTLICH
; LEUCHTTURM KIEL NOTFALLZEIT 1000 UTC SCHWERER WASSEREINBRUCH WIR SINKEN KEINE
; VERLETZTEN VIER MANN GEHEN IN DIE RETTUNGSINSEL SCHNELLE HILFE ERFORDERLICH ICH
; SENDE DEN TRÄGER -- BABETTE DELTA ECHO JULIETT YANKEE OVER"

(mayday "AMIRA" "AMRY" "NOTFALLPOSITION 57 GRAD 46 MINUTEN NORD 6 GRAD 31
    MINUTEN OST" "NOTFALLZEIT 0640 UTC KENTERUNG WIR SINKEN 9 MANN AN BORD
    SCHIFF 15M LANG GRUENER RUMPF")
; "MAYDAY MAYDAY MAYDAY DELTA ECHO AMIRA AMIRA AMIRA ALFA MIKE ROMEO YANKEE
; MAYDAY AMIRA ICH BUCHSTABIERE ALFA MIKE INDIA ROMEO ALFA RUFZEICHEN ALFA
; MIKE ROMEO YANKEE NOTFALLPOSITION 57 GRAD 46 MINUTEN NORD 6 GRAD 31 MINUTEN
; OST NOTFALLZEIT 0640 UTC KENTERUNG WIR SINKEN 9 MANN AN BORD SCHIFF 15M LANG
; GRUENER RUMPF ICH SENDE DEN TRÄGER -- AMIRA ALFA MIKE ROMEO YANKEE OVER"


;------------------------------------------------------------------------------

;; Aufgabe 3.1

; Eine innere Reduktion reduziert die Terme von innen nach außen.
; Eine äußere Reduktion jedoch reduziert von außen nach innen.
; innere Reduktion
; (sqr (* 3 (+ 1 (sqr 2))))
; ->(sqr (* 3 (+ 1 (* 2 2))) ;(sqr)
; ->(sqr (* 3 (+ 1 4)) ;(*)
; ->(sqr (* 3 5)) ;(+)
; ->(sqr 15) ;(*)
; ->(* 15 15) ;(sqr)
; ->225 ;(*)

; äußere Reduktion
; (sqr (* 3 (+ 1 (sqr 2))))
; ->(* (* 3 (+ 1 (sqr 2))) (* 3 (+ 1 (sqr 2))) ;(sqr)
; ->(* (* 3 (+ 1 (* 2 2))) (* 3 (+ 1 (sqr 2))) ;(sqr)
; ->(* (* 3 (+ 1 4)) (* 3 (+ 1 (sqr 2))) ;(*)
; ->(* (* 3 5) (* 3 (+ 1 (sqr 2))) ;(+)
; ->(* 15 (* 3 (+ 1 (sqr 2))) ;(*)
; ->(* 15 (* 3 (+ 1 (* 2 2))) ;(sqr)
; ->(* 15 (* 3 (+ 1 4))) ;(*)
; ->(* 15 (* 3 5)) ;(+)
; ->(* 15 15) ;(*)
; ->225 ;(*)


;; Aufgabe 3.2

; Für normale Funktionen wird die innere Reduktion angewendet. Für Spezialformen die äußere Reduktion.


;; Aufgabe 3.3

; Wenn die Funktion aufgerufen wird, geraet diese in eine 
; Endlosschleife und liefert keinen Rueckgabewert.
; Dies passiert an der Stelle des faculty-Aufrufs, welcher 
; in der Else-Clause ausgefuert wird. Dabei entsteht eine 
; Endlosschleife solbald der Rekursionsschluss erreicht
; ist und dennoch immmer weiter die faculty Funktion 
; aufgerufen wird.