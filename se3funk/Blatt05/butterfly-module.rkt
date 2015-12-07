#lang racket
(require 2htdp/image)
(provide 
 some-butterflies
 show-butterfly
 set-size!)

(define size 100)
(define kopfbreite (/ size 7))
(define bodycolor 'black)

(define (set-size! s)
  ;setze die Laenge der Schmetterlinge
  (set! size s))

(define (streifen)
  (above
   (rhombus (/ size 4.8) 170 'solid 'black)
   (rhombus (/ size 2.8) 170 'solid 'black)
   (rhombus (/ size 1.8) 170 'solid 'black)
   (rhombus (/ size 2.8) 170 'solid 'black)
   (rhombus (/ size 4.8) 170 'solid 'black)
   ))

(define (punkte)
  (beside
   (overlay 
    (circle (/ size 12.8)  'solid 'black)
    (circle (/ size 9.8)  'solid 'gray)
    )
   (overlay 
    (circle (/ size 7.8)  'solid 'black)
    (circle (/ size 5.8)  'solid 'gray)
    )
   (overlay 
    (circle (/ size 12.8) 'solid 'black)
    (circle (/ size 9.8) 'solid 'gray)
    )))

(define (stern)
 (star-polygon (/ size 5) 5 3 "solid" 'black))

(define (rauten-fluegel farbe)
  (rhombus (/ size 1.5) 120 'solid farbe))

(define (hexagon-fluegel farbe)
  (scale/xy 2 1 (regular-polygon (/ size 3.5) 6 'solid farbe)))

(define (ellipsen-fluegel farbe)
  (ellipse (* size 1.1) (/ size 1.8) 'solid farbe))
 

(define (fluegel-segm muster fluegelform)
  ;zeichne ein Segment des Fluegels als Rhombus
    (if muster (overlay muster fluegelform) fluegelform ))

(define (linker-fluegel muster fluegelform)
  ; setze zwei Rhomben zum linken Fluegel zusammen
  (let ([l_oben 
         (rotate -40 (fluegel-segm muster fluegelform))])
    (above l_oben (flip-vertical l_oben))))


(define (fluegel muster fluegelform)
  ; das Fluegelpaar: spiegele den linken Fluegel als rechten Fluegel
  (let ([links (linker-fluegel muster fluegelform)])
    (beside links  (flip-horizontal links))))

(define (fuehler-krumm)
  ; zeichne gekruemmte Fuehler
  (crop 0 (/ kopfbreite 2) 
        (* 2 kopfbreite) (/ kopfbreite 0.7)
        (circle kopfbreite 'outline bodycolor)))

(define (fuehler-gerade)
  ; zeichne gerade Fuehler
  (crop 0 (* 2 kopfbreite) 
        (* 2 kopfbreite) (* kopfbreite 1.5)
        (rhombus (* kopfbreite 2) 60 'outline bodycolor)))

(define (fuehler-gewellt)
  ; zeichne gewellte Fuehler
  ;  (beside
  (add-curve
   (add-curve 
    (add-curve
     (add-curve
      (rectangle 2 2 'outline 'white)
      0 0 0 1/2
      10 10 0 1/2
      bodycolor)
     
     10 10 0 1/2
     20 20 0 1/2
     bodycolor)
    20 20 0 1/2
    30 10 0 1/2
    bodycolor)
   30 10 0 1/2
   40 0 0 1/2
   bodycolor))

(define (body fuehler)
  ; zeichne Rumpf, Kopf und Fuehler
  (above 
   fuehler
   (circle (/ kopfbreite 2)'solid bodycolor)
   (ellipse kopfbreite ( * size 0.8) 'solid bodycolor)))

(define (butterfly muster fuehler fluegelform)
  (overlay (body fuehler) (fluegel muster fluegelform)))

(define (show-butterfly 
         the_color the_pattern the_feeler-shape the_wing-shape)
  ; the_color: 'red, 'green, 'blue, 'yellow
  ; the_pattern: 'plain, 'stripes, 'dots
  ; the_shape: 'straight, 'curved
  (butterfly
   (case the_pattern
     [(star) (stern)]
     [(stripes) (streifen)]
     [(dots) (punkte)]
     [else #f]); default: uni
   (case the_feeler-shape
     [(straight) (fuehler-gerade)]
     [(curved) (fuehler-krumm)]
     [(curly) (fuehler-gewellt)]
     [else #f])
   (case the_wing-shape
     [(rhomb) (rauten-fluegel the_color)]
     [(hexagon) (hexagon-fluegel the_color)]
     [(ellipse) (ellipsen-fluegel the_color)]
     [else #f])
  ))


;testing
(define some-butterflies
  ; ein Bild mir drei Schmetterlingen Seite an Seite
  (beside 
   (show-butterfly 'red 'stripes 'curved 'rhomb)
   (rhombus (/ size 10) 90 'outline 'orange); abstand
   (show-butterfly 'green 'stripes 'straight 'hexagon)
   (rhombus (/ size 10) 90 'outline 'orange); abstand
   (show-butterfly 'blue 'dots 'curly 'ellipse)
   ))

(define Antonia-Anton-Toni
  ; ein Bild mir drei Schmetterlingen Seite an Seite
  (beside 
   (above (show-butterfly 'blue 'stripes 'curved 'hexagon)
          (text "Antonia" 24 'black))
   (rhombus (/ size 10) 90 'outline 'orange); abstand
   (above (show-butterfly 'green 'star 'curly 'rhomb)
          (text "Anton" 24 'black))
   (rhombus (/ size 10) 90 'outline 'orange); abstand
   (above (scale 0.5 (show-butterfly 'red 'star 'curved 'hexagon))
          (text "Toni" 24 'black))
   (rhombus (/ size 10) 90 'outline 'orange); abstand
   (above (scale 0.5 (show-butterfly 'green 'dots 'straight 'rhomb))
          (text "Tini" 24 'black))
   (rhombus (/ size 10) 90 'outline 'orange); abstand
   (above (scale 0.5 (show-butterfly 'yellow 'stripes 'curly 'ellipse))
          (text "Tina" 24 'black))
   ))
;(save-image some-butterflies "butterfly-pic.png")
 ;some-butterflies
 ;Antonia-Anton-Toni
