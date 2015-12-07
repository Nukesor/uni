#lang racket
;;; Autoren:
;;;  * Arne Beer
;;;  * Sören Nykamp
;;;  * Lars Thoms

;Aufgabe 1.1

; Eine Funktion hoeherer Ordnung ist eine Funktion, welche entweder 
; eine Funktion als Parameter uebertragen bekommt oder eine Funktion
; zurueckgibt. Dies wird in der Regel mithilfe des Lambda-Kalkuels 
; realisiert


; 1.2

; foldl ist eine Funktion hoeherer Ordnung, da sie als ersten 
; Parameter eine Funkion erwartet

;  kopf−oder−schwanz ist eine Funktion hoeherer Ordnung, da
; hier abhaengig vom Wert x entweder die Funktion car oder
; die Funktion cdr zurueckgegeben wird.

; pimento  ist theoretisch eine Funktion hoeherer Ordnung,
; da die Funktion als ersten Parameter eine Funktion erwartet,
; Es wird eine Funktion zurueckgegeben, die einen weiteren
; Parameter erwartet

; my-tan ist eine keine Funktion hoeherer Ordnung, da sie 
; lediglich feste Werte als Parameter annimmt und keine 
; Funktion zurueckgibt.


; 1.3


; In der Funktion pimento wird dynamisch eine neue Funktion
; erstellt, welche eine uebergebene Funktion auf 2 zu uebergebende
; Parameter anwendet. Der erste Parameter wird bereits in der pimento
; Funktion angewendet und der zweite dann als Parameter in der Lambda
; Funktion erwartet

; Die zurueckgegebene Funktion addiert auf den gegebenen Wert 1. 
; Der urspruengliche Wert evaluiert dementsprechend auf 4.


; 1.4

; 1.4.1

; Der Ausdruck evaluiert zu 48.
; 2*1*1 = 2
; 2*2*2 = 8
; 2*8*3 = 48

; Es wird immer der Init-Wert mit dem linken Element der Liste 
; und dem festen Wert 2 multipliziert.

; 1.4.2

; Der Ausdruck evaluiert zu '(('(1 2 3) . 1) ('(1 2 3) . 2) ('(1 2 3) . 3))
; Durch map cons wird immer ein paar mit der Liste und dem jeweiligen Wert
; in der Liste errechnet. Da der Wert jedoch an das hintere Ende der 
; Liste angehaengt wird, entsteht lediglich ein Paar und keine Liste.

; 1.4.3

; Der Ausdruck evaluiert zu '(), da kein Element der urspruenglichen 
; Liste ein Paar ist. filter wendet auf alle Elemente der Liste die 
; uebergebene Funktion an und falls diese #t zurueckgibt, wird das 
; Element in die finale Liste uebernommen

; 1.4.4

; Bei diesem Ausdruck wird map als Funktion eine Kombination von 
; (curry + 32) und (curry * 1.8) uebergeben. 
; Nun wird auf jedes Element zuerst (curry * 1.8) und anschliessend
; (curry + 32) angewendet. 

; Der Ausdruck muesste zu '(9941 212 32 -459.67) evaluieren


; Aufgabe 2


; 2.1

(define (absolut x) (map abs x))

; 2.2

(define (sieben x) 
  (filter (lambda (y)
            (if (= (modulo y 7) 0)
                #t
                #f))
          x))

; 2.3 

(define (biggerodd x) 
  (filter odd? (filter (curry < 3) x)))

; 2.4
(define (split x)
  (list (filter odd? x) (filter even? x)))

; Aufgabe 3
(require se3-bib/setkarten-module)

;3.1
;Vier Listen um die möglichen Ausprägungen zu definieren:

(define n 
  '(1 2 3))
(define pattern
  '(waves oval rectangle))
(define mode
  '(outline solid hatched))
(define color
  '(red green blue))

;Eine Spielkarte soll als Liste der vier Werte definiert sein
;beispiel: '(2 'oval 'outlined 'green)

;3.2
;die Liste cards ist definiert als das kartesische Produkt der vier Listen in
;denen die möglichen Werte stehen
;for*/list sorgt dafür, dass die Funktion für jede Kombination der Eingabelistenelemente
;angewandt wird
(define cards
  (for*/list ([a n]
        [b pattern]
        [c mode]
        [d color])
    (list a b c d)))

;show-cards nimmt eine Liste von Kartendefinitionen und wendet die Funktion für eine einzelne Karte darauf an
(define (show-cards list)
  (map show-card list))
;show-card bekommt eine einzelne Karte und lässt sie darstellen
(define (show-card list)
  (show-set-card (car list) (cadr list) (caddr list) (cadddr list)))

;3.3
;testet ob alles gleich ist, ergibt eine Liste mit Wahrheitswerten für die
;vier Eigenschaften
(define (test-set1 card1 card2 card3)
  (for/list ([a card1]
             [b card2]
             [c card3])
    (and (eq? a b) (eq? b c) (eq? a c))))
;testet ob es paarweise verschieden ist, ergibt ebenfalls eine Liste mit Wahrheitswerten
(define (test-set2 card1 card2 card3)
  (for/list ([a card1]
             [b card2]
             [c card3])
    (not (or (eq? a b) (eq? b c) (eq? a c)))))


;drei Karten sind ein set, wenn sie entweder in mindestens einem Element gleich sind (ormap Teil)
;oder wenn sie paarweise verschieden sind (andmap Teil)
(define (is-a-set card1 card2 card3)
  (let ((a (test-set1 card1 card2 card3))
        (b (test-set2 card1 card2 card3)))
    (or (ormap eq? '(#t #t #t #t) a) (andmap eq? '(#t #t #t #t) b))))

;Als Test sollen folgende Kartenkombinationen zum Einsatz kommen:
;ein Satz der vollständig unterschiedlich ist -> #t
;ein Satz bei den zwei Karten eine eigenschaft Teilen, aber die dritte nicht -> #f
;vier Kartensätze, die in einem Wert gleich sind wobei dies bei der 1. bis 4. Eigenschaft der Fall ist ->#t
;ein Kartensatz der bei zwei Werten identisch ist ->#t
;ein Kartensatz der bei drei Werten gleich ist ->#t
;den Fall, dass alles gleich ist könnten wir uns eigentlich sparen, da man nie drei identische Karten haben
;kann, er ist aber dennoch aufgeführt. ->#t

;vollständig unterschiedlich 
(is-a-set '(3 waves solid blue) '(2 rectangle hatched red) '(1 oval outlined green))
;zwei ähnlich einer nicht
(is-a-set '(3 waves solid blue) '(1 oval outlined green) '(2 oval outlined green))
;vier die sich jeweils in einem gleichen
(is-a-set '(1 waves solid blue) '(1 rectangle hatched red) '(1 oval outlined green))
(is-a-set '(3 waves solid blue) '(2 waves hatched red) '(1 waves outlined green))
(is-a-set '(3 waves solid blue) '(2 rectangle solid red) '(1 oval solid green))
(is-a-set '(3 waves solid blue) '(2 rectangle hatched blue) '(1 oval outlined blue))
;zwei Werte gleich
(is-a-set '(2 waves solid blue) '(2 rectangle hatched blue) '(2 oval outlined blue))
;drei Werte gleich
(is-a-set '(2 waves solid blue) '(2 waves hatched blue) '(2 waves outlined blue))
;vier Werte gleich
(is-a-set '(2 waves solid blue) '(2 waves solid blue) '(2 waves solid blue))
