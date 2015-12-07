#lang racket
;;; Autoren:
;;;  * Arne Beer
;;;  * Sören Nykamp
;;;  * Lars Thoms

(require 2htdp/image)
(require math/number-theory)

;; Aufgabe 1
; Lineare Rekursion/Baumrekursion: Bei einer linearen Rekursion darf es in jedem
; möglichen Fall von Fallunterscheidungen nur maximal einen Aufruf der Funktion
; geben. Bei Kopfstück und Endstück ist dies der Fall, da sie eh nur einen
; rekursiven Aufruf haben, bei Merge, da die beiden Aufrufe in verschiedenen
; Fällen stehen, sodass immer nur einer davon zum tragen kommt.

; Merge-Sort hingegen hat als Parameter für Merge zwei Ergebnisse eines
; rekursiven Aufrufs, daher ist dies baumrekursiv, nicht linear rekursiv.

; Die anderen drei sind nicht baumrekursiv der Definition nach, dass in einem
; Fall mehrfach auf die Definition Bezug genommen wird.

; Geschachtelte Rekursion: Keine der vier Funktionen ist geschachtelt, da keiner
; sie selbst als Parameter in einem rekursiven Aufruf übergeben wird.
; (Geschachtelt wäre z.B. (merge (merge xs) (merge ys)))

; Direkte/indirekte Rekursion: Eine Rekursion wäre indirekt, wenn zwei oder mehr
; Funktionen sich wechselseitig aufrufen würden. Dies kommt hier nicht vor.
; Die einzige Funktion, die andere Funktionen verwendet ist die merge-sort
; Funktion. Dies geschieht jedoch nicht wechselseitig, sondern ist eine
; einseitige Beziehung. Somit sind alle vier Funktionen direkt rekursiv.


;; Aufgabe 2

; Rekursiver Weihnachtsbaum ohne Stamm
(define (weihnachtsbaum_tanne iteration)
  (if (= iteration 0)
      ; Die leuchtene Spitze
      (star-polygon 50 7 4 "solid" "gold")
      (overlay/offset
       ; Rekursiver Aufruf des Tannenbaumstücks
       (scale 0.8 (weihnachtsbaum_tanne (- iteration 1)))
       0 80
       (underlay/offset
        ; Tannenbaumstück
        (triangle/aas -40 -40 320 "solid" "darkgreen")
        0 70
        ; Weihnachtskugeln
        (overlay/offset (circle 10 "solid" "red") 280 0 (circle 10 "solid" "red"))))))

; Kompletter Weihnachtsbaum mit Stamm
(define (weihnachtsbaum iteration)
  (underlay/offset
   (rectangle 40 80 "solid" "brown")
   0 -120
   (weihnachtsbaum_tanne iteration)))

; Ein Pascalsches Dreieck kann auch aussehen wie ein Shirpinski-Dreieck
(define (pascal k n max string image)
  (if (= n max)
      image
      (if (> k n)
          (pascal 0 (+ n 1) max "" (overlay/offset image 0 (* 5 n) (text/font string 10 "darkgreen" #f 'symbol 'normal 'bold #f)))
          (pascal (+ k 1) n max (string-append string
                                               ; Wenn die Zahl gerade ist, wird sie durch ein Leerzeichen ersetzt
                                               (if (even? (binomial n k))
                                                   "  "
                                                   ; Wenn die Zahl mehrstellig ist, dann ersetze sie durch ein anderes Zeichen
                                                   (if (> (binomial n k) 9)
                                                       "# "
                                                       (number->string (binomial n k)))) "  ")
                  image))))

; Sterne
(define (sterne iteration)
  (if (= iteration 0)
      ; Ein Stern - nein - doch - ooohhhh
      (star-polygon 10 7 4 "solid" "gold")
      ; Baum-Rekursion »wuhuu«
      (overlay/offset
       (sterne (- iteration 1))
       (random 1000) (random 100)
       (sterne (- iteration 1)))))

; Scenenaufbau
(place-image
 ; Merry Christmas
 (text "merry christmas!" 50 "gold")
 1000 450
 
 (place-image
  (text "--[ 0nykamp | 2beer | 2thoms ]--" 20 "gold")
  1100 500
  
  (place-image
   (above (pascal 0 1 32 "" (text/font "1 " 20 "gold" #f 'symbol 'normal 'bold #f))
          (text/font "--[ Wacław Sierpiński | Blaise Pascal ]--" 10 "darkgreen" #f 'symbol 'normal 'bold #f))
   640 340
   
   (place-image
    ; Weihnachtsbaum
    (weihnachtsbaum 4)
    300 400
    
    ; Sterne
    (place-image
     (sterne 9)
     640 100
     
     ; Schnee
     (place-image
      (rectangle 1278 198 "solid" "white")
      640 500
      ; Neue Scene erstellen
      (empty-scene 1280 600 "lightblue")))))))
 