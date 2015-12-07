#lang swindle
;;; Autoren:
;;;  * Arne Beer
;;;  * Sören Nykamp
;;;  * Lars Thoms

(require swindle/clos swindle/setf swindle/misc)

;; Aufgabe 1.1

; Eine wissenschaftliche Publikation
(defclass* paper ()
  (id
   :initarg :id
   :type <string>
   :documentation "The unique key of this paper"
   )
  (author
   :initarg :author
   :reader get_author
   :type <string>
   :documentation "The authors of this paper"
   )
  (year
   :initarg :year
   :reader get_year
   :type <integer>
   :documentation "The year of publication of this paper"
   )
  (title
   :initarg :title
   :reader get_title
   :type <string>
   :documentation "The title of this paper"
   )
  :autopred #t
  :printer #t
  :documentation "Ich bin ein wissenschaftliche Publikation, lies mich :)")

; Ein Buch
(defclass* book (paper)
  (publisher
   :initarg :publisher
   :reader get_publisher
   :type <string>
   :documentation "The publisher of this book"
   )
  (place
   :initarg :place
   :reader get_place
   :type <string>
   :documentation "The publishing place of this book"
   )
  (series
   :initarg :series
   :reader get_series
   :type <string>
   :documentation "The series of this book"
   )
  (number
   :initarg :number
   :reader get_number
   :type <integer>
   :documentation "The number of the series of this book"
   )
  :autopred #t
  :printer #t
  :documentation "Ich bin ein Buch, lies mich :)")

; Ein Sammelband
(defclass* miscellany (book)
  (editor
   :initarg :editor
   :reader get_editor
   :type <string>
   :documentation "The publisher of this miscellany"
   )
  (page
   :initarg :page
   :reader get_page
   :type <integer>
   :documentation "The page of an specific article"
   )
  :autopred #t
  :printer #t
  :documentation "Ich bin ein Sammelband, lies mich :)")

; Ein Zeitschriftenartikel
(defclass* article (paper)
  (name
   :initarg :name
   :reader get_name
   :type <string>
   :documentation "The name of the journal"
   )
  (reel_number
   :initarg :reel_number
   :reader get_reel_number
   :type <integer>
   :documentation "The reel number of the journal"
   )
  (number
   :initarg :number
   :reader get_number
   :type <integer>
   :documentation "The number of the journal"
   )
  (month
   :initarg :month
   :reader get_month
   :type <integer>
   :documentation "The month of publication"
   )
  :autopred #t
  :printer #t
  :documentation "Ich bin ein Sammelband, lies mich :)")

; Die Bibliographie als Beispiele
(define Nessie1790 (make book
                         :id "Nessie1790"
                         :author "Nessie"
                         :year 1790
                         :title "Mein Leben im Loch Ness: Verfolgt als Ungeheuer"
                         :number 1
                         :series "Die besondere Biographie"
                         :publisher "Minority-Verlag"
                         :place "Inverness"))

(define Prefect1979 (make miscellany
                          :id "Prefect1979"
                          :author "Prefect, F."
                          :year 1979
                          :title "Mostly harmless - some observations concerning the third planet of the solar sytem"
                          :editor "Adams, D."
                          :number 5
                          :series "Travel in Style"
                          :publisher "Galactic Press"
                          :place "Vega-System, 3rd planet"
                          :page 500))

(define Wells3200 (make article
                        :id "Wells3200"
                        :author "Wells, H. G."
                        :year 3200
                        :title "Zeitmaschinen leicht gemacht"
                        :name "Heimwerkerpraxis für Anfänger"
                        :reel_number 500
                        :number 3))


;; Aufgabe 1.2

; Generische Methoden definieren
(defgeneric* cite ((qu book)))
(defgeneric* cite ((qu miscellany)))
(defgeneric* cite ((qu article)))

; Methode fürs Zitieren aus wissenschaftlichen Publikationen
(defmethod cite ((qu paper))
  (display (get_author qu))
  (display " (")
  (display (number->string (get_year qu)))
  (display "). ")
  (display (get_title qu)))

; Ergänzungsmethode fürs Zitieren aus Büchern
(defmethod cite :after ((qu book))
  (display ", Band ")
  (display (number->string (get_number qu)))
  (display " der Reihe: ")
  (display (get_series qu))
  (display ". ")
  (display (get_publisher qu))
  (display ", ")
  (display (get_place qu)))

; Ergänzungsmethode fürs Zitieren aus Sammelbändern
(defmethod cite :after ((qu miscellany))
  (display (string-append ", S. "
                          (number->string (get_page qu)))))

; Ergänzungsmethode fürs Zitieren aus Zeitschriften
(defmethod cite :after ((qu article))
  (display ". ")
  (display (get_name qu))
  (display ", ")
  (display (number->string (get_reel_number qu)))
  (display "(")
  (display (number->string (get_number qu)))
  (display ")."))

; Beispiele
(cite Nessie1790)
(cite Prefect1979)
(cite Wells3200)


;; Aufgabe 1.3

; Mit einer Ergänzungsmethode ist es möglich, dass Methoden von vererbten
; Klassen auf die vorhandenen Methoden der Vorfahrenklasse aufbauen.
; Mit »:before«, »:after« und »:around« ist es möglich, zu einem bestimmten
; Zeitpunkt die vorhandene Methode zu ergänzen.

; Daraus resultiert ein großer Vorteil: Man muss nicht eine vorhandene Methode
; neu implementieren und quasi Code duplizieren.
; Die Vorzüge gegenüber den »super-calls«, wie sie in Java zu finden sind,
; bestehen darin, dass man keinen Methodenaufruf vergessen kann, da sie auf
; jedenfall (vorher oder nachher) ausgeführt werden.

; Eine Implementation wurde schon mit Ergänzungsmethoden realisiert!


;; Aufgabe 2.1

(defclass fahrzeug())

(defclass landfahrzeug(fahrzeug))

(defclass schienenfahrzeug(landfahrzeug))

(defclass straßenfahrzeug(landfahrzeug))

(defclass wasserfahrzeug(fahrzeug))

(defclass luftfahrzeug(fahrzeug))

(defclass amphibienfahrzeug(wasserfahrzeug landfahrzeug))

(defclass amphibienflugzeug(luftfahrzeug amphibienfahrzeug))

(defclass zweiwegefahrzeug(schienenfahrzeug straßenfahrzeug))

(defclass zeitzug(schienenfahrzeug luftfahrzeug))


;; Aufgabe 2.2

; Da jedes Medium interessant ist, in dem das Fahrzeug unterwegs sein kann,
; sollte hierbei eine Kombination genutzt werden. Die zurückgegebenen Werte
; werden auf eine Liste gesetzt.
(defgeneric getMedium ((f fahrzeug))
  :combination generic-list-combination)

; Da hier die Maximalgeschwindigkeit (nicht die Maximalgeschwindigkeit innerhalb
; der jeweiligen Medien) gefragt ist, so wird hierbei die generic-max-comination
; genutzt
(defgeneric getMaxV ((f fahrzeug))
  :comination generic-max-combination)

; Bei der Zuladung interessiert uns, welches Gewicht das jeweilige Fahrzeug denn
; nun transportieren kann. Es ist also die spezialisierteste Methode interessant,
; daher erfolgt keine Kombination von Methoden
(defgeneric getMaxZuladung ((f fahrzeug)))

; Bei Fahrzeugen mit mehreren Antriebsarten ist der Verbrauch auf hundert
; Kilometer je nach gerade in Nutzung befindlichem Antrieb unterschiedlich.
; Daher sollte keine Information verloren gehen, sodass die list Komination
; sinnvoll erscheint
(defgeneric getVerbrauch ((f fahrzeug))
  :combination generic-list-combination)

; Bei den Passagieren verhält es sich genau wie mit der Zuladung,
; die spezialisierteste Methode ist hierbei für uns interessant
(defgeneric getPassagiere ((f fahrzeug)))


;; Aufgabe 2.3

; Gewählt wurde die Wiedergabe des Transportmediums
(defmethod getMedium ((l landfahrzeug))
  'land)
(defmethod getMedium ((w wasserfahrzeug))
  'wasser)
(defmethod getMedium ((l luftfahrzeug))
  'luft)
(defmethod getMedium ((s schienenfahrzeug))
  'schiene)
(defmethod getMedium ((s straßenfahrzeug))
  'straße)

; Die Klassenpräzedenzliste ist hierbei unerlässlich,
; da sie die Reihenfolge bestimmt, in der die Methoden angewandt werden

; Amphibienfahrzeug
; (getMedium (make amphibienfahrzeug))
; Für das Amphibienfahrzeug wurde in der Vererbung festgelegt, dass das
; Landfahrzeug wichtiger ist als das Wasserfahrzeug, somit ist die
; Präzedenzliste in der Reihenfolge amphibienfahrzeug, landfahrzeug,
; wasserfahrzeug, fahrzeug und die sich ergebende Ausgabe '(wasser land)

; Amphibienflugzeug
; (getMedium (make amphibienflugzeug))
; Für das Amphibienflugzeug wurde festgelegt, dass das Flugzeug wichtiger ist
; als das Amphibienfahrzeug, somit steht das Luftfahrzeug vor dem
; Amphibienfahrzeug in der Präzedenzliste es ergibt sich also die
; Liste '(luft wasser land) als Ergebnis

; Zweiwegefahrzeug
; (getMedium (make zweiwegefahrzeug))
; Das Ergebnis ist '(schiene straße land)
; Da die Präzedenzliste die Reihenfolge zweiwegefahrzeug, schienenfahrzeug,
; straßenfahrzeug, landfahrzeug, fahrzeug hat.
; Bei diesem Beispiel lässt sich besonders schön beobachten, dass gemeinsame
; Vorgänger nachgelagert sind.
; (Anhand des Nachlagerns von Landfahrzeug gegenüber dem Straßenfahrzeug)

; Zeitzug
; (getMedium (make zeitzug))
; '(schiene land luft)
; Die Reihenfolge auf der Präzedenzliste ist zeitzug schienenfahrzeug
; landfahrzeug luftfahrzeug fahrzeug
; Somit werden sie in dieser Reihenfolge abgearbeitet und die Ergebnisse auf
; die Liste gepackt. Da Zeitzug und Fahrzeug keine Methode anbieten für
; getMedium ist die entgültige Liste.
; '(schiene land luft)
