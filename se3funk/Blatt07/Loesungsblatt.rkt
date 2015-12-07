#lang racket
;;; Autoren:
;;;  * Arne Beer
;;;  * Sören Nykamp
;;;  * Lars Thoms

(require 2htdp/image)
(require 2htdp/universe)

;; Aufgabe 1

; Allgemein rekursive Funktion
(define (produktrek xs y)
    (if [empty? xs]
        '()
        [cons (* (car xs) y) (produktrek (cdr xs) y)]
))
(produktrek '(12 13 14 15) 5 )
; '(60 65 70 75)

; Endrekursive Funktion
(define (produktend n f [akku '()])
    (if (empty? n) (reverse akku)
        (produktend (cdr n) f (cons (* f (car n)) akku))))

(produktend '(12 13 14 15) 5 )
; '(60 65 70 75)


; Produkt mit Funktionen hoeherer Ordnung
(define (produkt  xs y)
    (map (curry * y) xs))

(produkt '(12 13 14 15) 5 )
; '(60 65 70 75)



;; Aufgabe 2

; 2.1

; Es existieren 7 Striche, welche zur Darstellung von Zahlen
; verwendet werden koennen. Dementsprechen brauchen wir eine
; 7x9 Matrix um alle Zustaende fuer die jeweiligen Ziffern 
; darzustellen. Dies laesst sich am besten mithilfe von Listen
;  und #t #f implementieren
(define statesList
  (list
    (list #t #t #t #f #t #t #t)
    (list #f #f #t #f #f #t #f)
    (list #t #f #t #t #t #f #t)
    (list #t #f #t #t #f #t #t)
    (list #f #t #t #t #f #t #f)
    (list #t #t #f #t #f #t #t)
    (list #t #t #f #t #t #t #t)
    (list #t #f #t #f #f #t #f)
    (list #t #t #t #t #t #t #t)
    (list #t #t #t #t #f #t #t)
  )
)

; 2.2 


(define (siebenSegment n)
  (let ([x (map (lambda (element)(if (equal? element #t) "Red" "DimGray" ))
        (if (and (<= 0 n) (>= 9 n))
          (list-ref statesList n)
          (list #f #f #f #f #f #f #f)
        )
      )
    ])
    (overlay/offset
      (rectangle 80 10 "solid" (list-ref x 0))
      0 90
      (overlay/offset
        (rectangle 10 80 "solid" (list-ref x 1))
        45 45
        (overlay/offset
          (rectangle 10 80 "solid" (list-ref x 2))
          -45 45
          (overlay/offset
            (rectangle 80 10 "solid" (list-ref x 3))
            0 0
            (overlay/offset
              (rectangle 10 80 "solid" (list-ref x 4))
              45 -45
              (overlay/offset
                (rectangle 10 80 "solid" (list-ref x 5))
                -45 -45
                (overlay/offset
                  (rectangle 80 10 "solid" (list-ref x 6))
                  0 -90
                  (rectangle 100 200 "solid" "black")
                )
              )
            )
          )
        )
      )
    )
  )
)

(map siebenSegment (list 0 1 10 6 4 5 6 10020 8 9))

; 2.3



(define (zeige-7segmenthelper t update limit)
    (siebenSegment  (modulo (floor (/ t (* update 28))) limit)
))

(define (zeige-7segment t)
    (zeige-7segmenthelper t 1 5)
)

; (animate zeige-7segment)

; 2.4

(define (clock t)
    (beside
        (rectangle 20 200 "solid" "black")
        (zeige-7segmenthelper t 86400 10) ; Tage 3
        (rectangle 60 200 "solid" "black")
        (zeige-7segmenthelper t 36000 3) ; Stunden 1
        (rectangle 20 200 "solid" "black")
        (zeige-7segmenthelper t 3600 10) ; Stunden 2
        (rectangle 60 200 "solid" "black")
        (zeige-7segmenthelper t 600 6) ; Minuten 1
        (rectangle 20 200 "solid" "black")
        (zeige-7segmenthelper t 60 10) ; Minuten 2
        (rectangle 60 200 "solid" "black")
        (zeige-7segmenthelper t 10 6) ; Sekunden 1
        (rectangle 20 200 "solid" "black")
        (zeige-7segmenthelper t 1 10) ; Sekunden 2
        (rectangle 20 200 "solid" "black")
))

(animate clock)