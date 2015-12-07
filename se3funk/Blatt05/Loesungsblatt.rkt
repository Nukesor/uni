#lang racket
;;; Autoren:
;;;  * Arne Beer
;;;  * Sören Nykamp
;;;  * Lars Thoms

(require se3-bib/butterfly-module)

;;Aufgabe 1
;Zu lösende Teilprobleme:
;0. Ermitteln, welches von zwei Ausprägungen dominant ist
;1. Erstellung von rezessiven Allelen für einen Schmetterling
;2. Erstellung eines Schmetterlings aus den Allelen seiner Eltern
;3. Ermitteln der dominanten Allele des Schmetterlings
;4. Darstellung der Schmetterlinge
;5. Erzeugen der geforderten n Schmetterlinge bei gegebenen Elternpaar und Darstellung dieser

;Entwurf:
;Ein Schmetterling ist definiert durch eine Liste von Paaren für jedes
;der Attribute eines. Dies gibt uns Vorteile bei der Auswahl eines Allels
;für das Kind
;Die Attribute treten immer in der Reihenfolge auf:
;Fluegelfarbe, Musterung, Fuehlerform, Fluegelform
;Diese Reihenfolge leitet sich von der Attributsreihenfolge der zeichnenden Funktion her.

;Wir brauchen eine Funktion die abschließend n Kinder für ein Elternpaar erzeugt und diese darstellt
;Funktion: nKind
;Attribute N (number) - Anzahl der zu erzeugenden Kinder, Vater(Liste), Mutter(Liste)
;Vater und Mutter sind jeweils unvollständige Listen nur mit den dominanten Genen der Eltern.
;Dies ist die Funktion, die von außen am wahrscheinlichsten aufgerufen wird.
;Ausgabe: Bilder der zu erstellenden Schmetterlingfamilie

;Da unsere Struktur erweitertes Wissen über den Schmetterling hat gegenüber dem, was das
;Zeichen-Modul nimmt, sollten wir noch eine Funktion erstellen, die für uns das auflösen
;unserer Struktur übernimmt
;Funktion zeichne
;Attribute Liste - ein Schmetterling wie er oben definiert ist
;Ausgabe: Bild

;Die nachfolgenden Funktionen werden jeweils für weiter oben stehende Funktionen benötigt
;angefangen mit der Funktion, die wir brauchen um eine Definitionsliste für ein Kind zu erhalten.

;Die Funktion kind soll ein einzelnes Kind anhand der übergebenen Elternlisten erstellen
;Die Eltern sind hierbei vollständig zu übergeben (mit dominanten und rezessiven Genen)
;Funktion: kind
;Attribute Vater(Liste) Mutter(Liste) 
;Ausgabe: Liste, die ein Kind definiert
;
;Wir kennen nur die dominanten Gene eines Elter, müssen also den Rest hinzufügen
;Diese Funktion erhält eine Liste mit einfachen Genbeschreibungen und gibt
;eine Liste von Paaren wieder.
;Funktion: rezessivAdd
;Attribute: Liste
;Ausgabe: Liste, die dominante und rezessive Gene enthält

;Wir werden noch weitere Funktionen brauchen (Dominanzprüfung, Zufallselement),
;die jedoch eher immer wiederkehrende Hilfsfunktionen sind
;Sollten wir mit provide Funktionen zur Verfügung stellen, so wären diese nicht darunter.

;;Implementation

;zu 0:
;Wir benötigen eine Funktion, die zwei Ausprägungen bekommt und für sie prüft,
;welches von diesen beiden dominanter ist. Für diese Prüfung nutzen wird Listen,
;die mit den verschiedenen Ausprägungen gefüllt sind. Weiter vorne in der Liste 
;bedeutet dabei, größere Dominanz.
(define Fluegelfarbe '(red green blue yellow))
(define Musterung    '(dots stripes star))
(define Fuehlerform  '(straight curved curly))
(define Fluegelform  '(rhomb hexagon ellipse))
;Diese Listen lassen sich nun sehr einfach rekursiv durchsuchen, wodurch wir
;die Eigenschaft der Liste leicht von Vorne zugänglich zu sein, als Metainformation benutzen
;Wir definieren hierfür die Funktion dominant die eine dieser Listen und zwei Allele bekommt
;Sollte sich keines der Allele in der Liste befinden, so gibt sie false zurück
;Diese Funktion wird aber nicht für außerhalb des Moduls zur Verfügung gestellt, da 
;sie nur für uns immer wieder Hilfe Leistung bieten soll.
;Wir als Ergebnis geben wir ein Paar zurück, bei dem das dominante Allel vorne steht.
(define (dominant Typ Allel1 Allel2)
  (cond ((null? Typ) #f) 
        ((equal? Allel1 (car Typ)) (cons Allel1 Allel2))
        ((equal? Allel2 (car Typ)) (cons Allel2 Allel1))
        (else (dominant (cdr Typ) Allel1 Allel2))))

;zu 1:
;Da wir nur die dominanten Gene des Elter kennen, müssen wir rezessive noch zufällig hinzufügen.
;Dies geschieht mit der Funktion Zufallselement die zufällig auf ein Element der ihr übergebenen
;Liste zugreift und dieses zurückgibt. Dies wenden wir auf den Teil der zugehörigen Dominanzliste
;an, der nach anwenden der member Funktion übrig bleibt (member erzeugt die Restliste ab dem 
;gesuchten Element)
(define (rezessivAdd Liste)
  (list (cons (car Liste) (zufallselement (member (car Liste) Fluegelfarbe)))
        (cons (cadr Liste) (zufallselement (member (cadr Liste) Musterung)))
        (cons (caddr Liste) (zufallselement (member (caddr Liste) Fuehlerform)))
        (cons (cadddr Liste) (zufallselement (member (cadddr Liste) Fluegelform)))
        ))

;Dieser Funktion kann entweder eine Liste oder ein Paar gegeben werden
;Bei einer Liste wird zufällig nach deren Länge ein Element gewählt,
;bei einem Paar das erste oder zweite Element.
;list-ref und length funktionieren nicht bei Paaren
(define (zufallselement Liste)
  (if (list? Liste) (list-ref Liste (random (length Liste)))
      (if (= (random 2) 1) (cdr Liste)
          (car Liste))))

;zu 2 und 3: 
;Die Liste des Kindes besteht für jedes Attribut aus einem zufällig ausgewählten Gen
;jedes Elternteils vom jeweiligen Attribut. Auf diese Kombination muss die Dominanzfunktion
;angewandt werden, um die Reihenfolge dominant-rezessiv zu erhalten
(define (kind Vater Mutter)
  (list (dominant Fluegelfarbe (zufallselement (car Vater)) (zufallselement (car Mutter)))
        (dominant Musterung (zufallselement (cadr Vater)) (zufallselement (cadr Mutter)))
        (dominant Fuehlerform (zufallselement (caddr Vater)) (zufallselement (caddr Mutter)))
        (dominant Fluegelform (zufallselement (cadddr Vater)) (zufallselement (cadddr Mutter)))
        ))

;zu 4:
;Wir holen die dominanten Eigenschaften und lassen diese Zeichnen.
(define (zeichne Liste)
  (show-butterfly (caar Liste) (caadr Liste) (caaddr Liste) (car(cadddr Liste))))

;zu 5:
;Diese Funktion nimmt eine Zahl N, einen nur dominant spezifizierten Vater
;und ebenso die Mutter. Vater und Mutter werden jeweils mit rezessiven Genen ausgestattet
;und darauf hin rekursiv eine Liste mit den Kindern erstellt
;die Funktion zeichne wird auf die Liste gemappt die aus Vater, Mutter und der Kinderliste
;entsteht.
(define (nKind N Vater Mutter)
  (letrec ((rezVater (rezessivAdd Vater))
    (rezMutter (rezessivAdd Mutter))
    (kinder (lambda (Vat Mut Zahl)
              (if (= 0 Zahl) '()
                  (cons (kind Vat Mut) (kinder Vat Mut (- Zahl 1))))))
    )
    (map zeichne (cons rezVater (cons rezMutter (kinder rezVater rezMutter N))))
    )
  )

;;Testen
;Zum testen nehmen wir zunächst jeweils Paare mit gleichen dominanten Genen, dabei seien
;die Gene bei einem Paar stark dominant, bei einem mittel und bei einem dritten die jeweils
;rezessivste Stufe. Für jedes dieser Paare werden 2x5 Kinder erzeugt.
(nKind 5 '(red dots straight rhomb) '(red dots straight rhomb))
(nKind 5 '(red dots straight rhomb) '(red dots straight rhomb))
(nKind 5 '(green stripes curved hexagon) '(green stripes curved hexagon))
(nKind 5 '(green stripes curved hexagon) '(green stripes curved hexagon))
(nKind 5 '(yellow star curly ellipse) '(yellow star curly ellipse))
(nKind 5 '(yellow star curly ellipse) '(yellow star curly ellipse))
;Bei diesen Eltern sollten stark gleichförmige Kinder rauskommen, da die Wahrscheinlichkeit
;für die gemeinsamen Merkmale stark erhöht ist
;Gleich wohl sollten nur bei den oberen vier Elternpaaren anders farbige oder förmige
;Kinder erzeugt werden. Bei den unteren zwei müssen Eltern und Kinder alle gleich aussehen.

;Die nächsten Eltern sollen nun stärker gemischt sein, wobei jeweils ein dominantes
;auf ein rezessives Gen bei den dominanten Genen der Eltern stoßen sollen
(nKind 5 '(red star straight ellipse) '(blue dots curly rhomb))
(nKind 5 '(yellow dots curly rhomb) '(red star straight ellipse))
;Jeweils seien hierbei auch die Positionen der dominanten Gene zwischen
;erstem und zweitem Partner vertauscht.
;Hierbei sollten nun gemischtere Kinder entstehen (was aber natürlich auch nur
;eine Sache von Wahrscheinlichkeiten ist)