% Grundlagen der Wissensverarbeitung – Tutorial 2, Gruppe 4 
% Arne Beer MN 6489196; Marta Nevermann MN 6419716; Daniel Waller MN 6813853


## Exercise 1.1

### 1.


Im Rahmen eines Routenplaners für öffentlichen Nahverkehr setzt sich der Zustandsraum wie folgt zusammen: Der `search space` besteht aus allen möglichen Routen, die zum gewünschten Ziel führen, eingeschränkt durch vorhandene Stationen (Knoten) und deren Verbindung (Kanten) durch verschiedene öffentliche Verkehrsmittel. Die Kosten berechnen sich aus der Fahrtzeit von einer Station zur nächsten. Im Prinzip kann jeder Knoten zum Start- und Zielknoten werden, abhängig von der Auswahl des Starts und des Ziels.
Der Zustand des Agenten könnte folgendermaßen beschrieben werden: [ station, linie, f ], also die Station, die aktuelle Linie (öffentliches Verkehrsmittel) und ob das gewünschte Ziel schon erreicht wurde oder nicht.

### 2.

#### (a)

- Mögliche Zustände: \{\newline
  S1   (4lJug = 0L, 3lJug = 0L),\newline
  S2   (4lJug = 1L, 3lJug = 0L),\newline
  S3   (4lJug = 2L, 3lJug = 0L),\newline
  S4   (4lJug = 3L, 3lJug = 0L),\newline
  S5   (4lJug = 4L, 3lJug = 0L),\newline
  S6   (4lJug = 0L, 3lJug = 1L),\newline
  S7   (4lJug = 1L, 3lJug = 1L),\newline
  S8   (4lJug = 2L, 3lJug = 1L),\newline
  S9   (4lJug = 3L, 3lJug = 1L),\newline
  S10  (4lJug = 4L, 3lJug = 1L),\newline
  S11  (4lJug = 0L, 3lJug = 2L),\newline
  S12  (4lJug = 1L, 3lJug = 2L),\newline
  S13  (4lJug = 2L, 3lJug = 2L),\newline
  S14  (4lJug = 3L, 3lJug = 2L),\newline
  S15  (4lJug = 4L, 3lJug = 2L),\newline
  S16  (4lJug = 0L, 3lJug = 3L),\newline
  S17  (4lJug = 1L, 3lJug = 3L),\newline
  S18  (4lJug = 2L, 3lJug = 3L),\newline
  S19  (4lJug = 3L, 3lJug = 3L),\newline
  S20  (4lJug = 4L, 3lJug = 3L)\newline\}

- Start/Ziel Zustände der Behälter:\newline
Start: S1 (4lJug = 0L, 3lJug = 0L)\newline
Goal: { S3 (4lJug = 2L, 3lJug = 0L), S8 (4lJug = 2L, 3lJug = 1L),\newline S13 (4lJug = 2L, 3lJug = 2L), S18 (4lJug = 2L, 3lJug = 3L) }

- Übergänge zwischen den Zuständen:\newline
Transitions: { (S17 -> S16), (S5 -> S1), (S10 -> S17), (S3 -> S18),\newline (S16 -> S1), (S16 -> S4), (S15 -> S11), (S15, S20), (S3, S5), (S3, S1),\newline (S2 -> S17), (S11 -> S15), (S16 -> S20), (S5 -> S17), (S11 -> S16),\newline (S4 -> S16), (S18 -> S20), (S19 -> S16), (S19 -> S15), (S4 -> 19'),\newline (S11 -> S3'), (S11 -> S1), (S4 -> S5), (S1 -> S5), (S4 -> S1),\newline (S17 -> S20), (S15 -> S5), (S10 -> S20), (S3 -> S11), (S15 -> S19),\newline (S6 -> S1), (S6 -> S2), (S18 -> S10), (S20 -> S5), (S2 -> S6), (S10, S6), (S2 -> S1), (S10 -> S5), (S20 -> S16), (S6 -> S10), (S6 -> S16),\newline (S19 -> S4), (S19 -> S20), (S18 -> S3), (S18 -> S16), (S17 -> S2),\newline (S17 -> S5), (S1 -> S16), (S5 -> S20) }\newline

- Übergangsfolge, die zum Ergebnis führt:\newline
{ (S1 -> S16), (S16 -> S4), (S4 -> S19), (S19 -> S15), (S15 -> S11),\newline (S11 -> S3) }\newline
Diagramm siehe Anhang

#### (b)

Da die einzige Möglichkeit, zum Zielzustand S3 zu kommen, über den Zustand S11 ist, und man S11 nur über S15 erreicht (4l Wein/Wasser wegkippen), sollte man dieses Rätsel lieber nur mit Wasser durchführen. Also: nein.


\pagebreak

## Exercise 1.2

Im Folgenden orientieren wir uns anhand des Beispiels `path findings` von
Navigationsgeräten. In dieser Situation ist der `search space` unendlich groß,
nämlich jede mögliche Route, die zu dem angegebenen Ziel führt.  Der `start
state` ist die Position, von der die Reise beginnt, solange noch keine Strecke
zurückgelegt wurde. Der `end state` ist an der genannten Zielposition mit einer
unbegrenzten zurückgelegten Strecke oder keiner zurückgelegten Strecke, falls
End- und Startpunkt übereinstimmen.   
Die Transitionen für die Suche/Problemlösung ist räumliche Fortbewegung.
Hierbei wird sich im Falle eines Navigationsgerätes anhand der Straßen
orientiert.   
Das größte Problem, welches hierbei auftritt, ist die Definition von räumlicher
Forzbewegung. Da man Raum in der Theorie in unendlich kleine Teile aufspalten
kann, muss man den tatsächlichen Raum abstrahieren. Dies wird meist mit
Aufteilung von Staßen in z.B. Abschnitte gelöst oder noch gröber, die
Aufteilung von Oberfläche in ein Grid. Durch dieses Verfahren ist es einfach
die Kanten/Transitionen zwischen zwei `grid tiles` zu gewichten, meist anhand
der Differenz zu der Luftlinie zwischen Start- und Endpunkt. Ein weiteres
Problem ist die Verarbeitung von Metainformationen, wie z.B. Sackgasse oder
Geschwindigkeitsbegrenzungen. Im Fall einer Sackgasse wird diese entweder mit
einem sehr honen Gewicht ausgestattet oder aus dem Graphen ausgeschlossen,
außer es handelt sich um die Zielstraße. Im Falle einer 100km langen 30km/h
Zone und einer parallelen 105km langen Autobahn, bei selbem Ankuntsziel, muss
die Fahrtzeit größer gewichtet werden, als die tatsächlich zurückzulegende
Strecke.  Je mehr Metainformationen und Sonderfälle beachtet werden müssen,
desto schwerer lassen sich die Transitionen definieren, da es sich um einen
zunehmend wachsenden `search space` handelt, mit einer zunehmenden Anzahl von
Transitionen pro Node. 
