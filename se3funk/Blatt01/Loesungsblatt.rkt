#lang racket
;;; Autoren:
;;;  * Arne Beer
;;;  * Sörne Nykamp
;;;  * Lars Thoms


;; Aufgabe 1.1

; Gradzahl nach Bogenmaß
(define degrees2radians
  (lambda (x)
    (* (/ (* 2 pi) 360) x))) ; (2*pi)/360*x

; Bogenmaß nach Gradzahl
(define radians2degrees
  (lambda (x)
    (* (/ 360 (* 2 pi)) x))) ; 360/(2*pi)*x


;; Aufgabe 1.2
(define my_acos
  (lambda (x)
    (if (< x 0)    
      (- pi (my_acos (* -1 x)))
    ; else
      (if (= x 0)
        (/ pi 2)
      ; else
        (atan (/ (sqrt (- 1 (* x x))) x))))))


;; Aufgabe 1.3
(define nm2km
  (lambda (x)
    (* x 1.852)))


;; Aufgabe 2.1
(define distanzAB
  (lambda (phi_A lambda_A phi_B lambda_B)
    (nm2km
      (* 60 
        (radians2degrees
          (my_acos
            (+ (* (sin (degrees2radians phi_A)) (sin (degrees2radians phi_B))) (* (cos (degrees2radians phi_A)) (cos (degrees2radians phi_B)) (cos (degrees2radians (- lambda_B lambda_A)))))))))))

; Oslo - Hongkong
(distanzAB 59.93 10.75 22.20 114.10)

; San Francisco - Honolulu
(distanzAB 37.75 -122.45 21.32 -157.83)

; Osterinsel - Lima
(distanzAB -27.10 -109.40 -12.10 -77.05)





;; Aufgabe 2.2
(define directionAB
  (lambda ( phi_A lambda_A phi_B lambda_B)
    (if (< lambda_A lambda_B)
     (radians2degrees
      (my_acos
        (/ 
          (- (sin (degrees2radians phi_B))
             (* (cos(distanzAB phi_A lambda_A phi_B lambda_B)) (sin(degrees2radians phi_A))))
               (* (cos(degrees2radians phi_A)) (sin (distanzAB phi_A lambda_A phi_B lambda_B))))))
      (radians2degrees
      (- 360
      (my_acos
        (/ 
          (- (sin (degrees2radians phi_B))
             (* (cos(distanzAB phi_A lambda_A phi_B lambda_B)) (sin(degrees2radians phi_A))))
               (* (cos(degrees2radians phi_A)) (sin (distanzAB phi_A lambda_A phi_B lambda_B)))))))
     )))

;; Aufgabe 2.3.1

(define (cardinaldir a)
  (cond
    [(or (and (< a 11.5) (> a 0)) (and (< a 360))) (write "N") ]
    [(and (>= a 11.5) (< a 23)) (write "NNE")]
    [(and (>= a 34) (< a 56.5)) (write "NE")]
    [(and (>= a 56.5) (< a 79)) (write "EEN")]
    [(and (>= a 79) (< a 101.5)) (write "E")]
    [(and (>= a 101.5) (< a 124)) (write "EES")]
    [(and (>= a 124) (< a 146.5)) (write "ES")]
    [(and (>= a 146.5) (< a 169)) (write "ESS")]
    [(and (>= a 169) (< a 191.5)) (write "S")]
    [(and (>= a 191.5) (< a 214)) (write "SSW")]
    [(and (>= a 214) (< a 236.5)) (write "SW")]
    [(and (>= a 236.5) (< a 259)) (write "SWW")]
    [(and (>= a 259) (< a 281.5)) (write "W")]
    [(and (>= a 281.5) (< a 304)) (write "WWN")]
    [(and (>= a 304) (< a 326.5)) (write "WN")]
    [(and (>= a 326.5) (< a 349.0)) (write "WNN")]
    ))

(write "Testaufgabe fuer cardinaldir")
(cardinaldir 42)


;; Aufgabe 2.3.2

(define (cardtodegree card)
(cond
     [(equal? "N" card) 0 ]
     [(equal? "NNE" card) 22.5 ]
     [(equal? "NE" card) 45 ]
     [(equal? "ENE" card) 67.5 ]
     [(equal? "E" card) 90 ]
     [(equal? "ESE" card) 112.5 ]
     [(equal? "SE" card) 135 ]
     [(equal? "SSE" card) 157.5]
     [(equal? "S" card) 180 ]
     [(equal? "SSW" card) 202.5 ]
     [(equal? "SW" card) 225 ]
     [(equal? "WSW" card) 247.5 ]
     [(equal? "W" card) 270 ]
     [(equal? "WNW" card) 292.5 ]
     [(equal? "NW" card) 315]
     [(equal? "NNW" card) 337.5]
     [else "fuckyou" ]
     )
  )

(cardtodegree "ENE")