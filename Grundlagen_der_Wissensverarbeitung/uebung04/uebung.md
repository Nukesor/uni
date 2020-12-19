% Grundlagen der Wissensverarbeitung – Tutorial 3, Gruppe 4 
% Arne Beer MN 6489196; Marta Nevermann MN 6419716; Daniel Waller MN 6813853, Julius Hansen MN 6455291


# HowTo

Zum Ausfuehren der Datei eine der folgenden Moeglichkeiten Ausfuehren:

        ./finder --watch 
        ./finder --watch --blatt4a
        ./finder --watch --blatt4b

## Exercise 1.2.1

Als Heuristik haben wir hier die einfache Manhatten Distance genommen. Dies zeigt den moeglichen kuerzesten Weg von Start zu Ziel an. Die Heuristik unterschätzt optimal.


## Exercise 1.2.2

In dieser Umgebung wird das komplette Grid erforscht. Das Programm terminiert , da eine open und closed list gemanaged wird.
Jeder besuchte Node wird auf die closedList gesetzt und nur reaktiviert, wenn ein kürzerer Weg zu dieser Node gefunden wird.
Da dies bei einem voll erforschten Grid mit zusätzlichen Iterationen nicht möglich ist, haben wir eine garantierte Terminiertung.

## Exercise 1.2.4

### 1.2.1
Open Nodes: 28
Closed Nodes: 82
Opened Nodes: 163

### 1.2.2
Open Nodes 0
Closed Nodes 99
Opened Nodes 190

### 1.2.3

Open Nodes 37
Closed Nodes 65
Opened Nodes 135

