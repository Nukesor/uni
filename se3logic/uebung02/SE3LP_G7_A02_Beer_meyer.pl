%Abgabe Arne Beer, Anne-Victoria Meyer

% Uebungsgruppe 7

/* Aufgabe 1
 
Die Anfrage 'vater_von(P1,X),mutter_von(X,P1)' berechnet Belegungen der Variablen P1, P2, X, 
sodass P2 das Kind einer Tochter von P1 ist. Also wäre P1 dann der Großvater mütterlicherseits von P2.

Die Anfrage 'vater_von(X,P1),vater_von(X,P2),P1\=P2' berechnet alle vorhandenen Kombinationen 
von zwei verschiedenen Kindern P1, P2, die denselben Vater haben. Also sind P1 und P2 Geschwister oder Halbgeschwister.

Die Anfrage 'mutter_von(X,P1),mutter_von(Y,X),mutter_von(Y,P2),vater_von(P2,Z),X\=P2' berechnet 
Belegungen, unter denen Y die Großmutter von Z und P1 ist, wobei Y die Großmutter 
muetterlicherseits von P1 und die Großmutter väterlicherseits von Z ist. Also wäre P2 ein Onkel muetterlicherseits von P1.

Die Anfrage 'mutter_von(X,P1),mutter_von(X,Y),mutter_von(Y,Z),vater_von(P2,Z),Y\=P2' berechnet Belegungen, 
unter denen P2 der Vater eines Kindes ist, dessen Mutter die Schwester oder Halbschwester mütterlicherseits 
von P1 ist. P1 und P2 könnten also verschwägert sein.

Die Anfrage 'vater_von(X,P1),vater_von(Y,P2),mutter_von(Z,P1),mutter_von(Z,P2),P1\=P2,X\=Y' berechnet 
Belgegungen, unter denen P1 und P2 zwei Kinder mit derselben Mutter und verschiedenen Vätern sind. 
P1 und P2 wären somit Halbgeschwister.
*/

/* Aufgabe 2.1
Es wird nach allen Hoerbuch-Cds gesucht, welche 2012 erschienen sind. 
Hierzu sollen die jeweiligen PIds, Autoren und Titel ausgegeben werden.

?- produkt(PId,hoerbuch,Titel,Autor,_,2012,_).
false.

?- asserta(produkt(65549,hoerbuch,die_drei_fragezeichen,alfred_hitchcock,audio,2012,30)).
true.

?- produkt(PId,hoerbuch,Titel,Autor,_,2012,_).PId = 65549,
Titel = die_drei_fragezeichen,
Autor = alfred_hitchcock.
*/

/* Aufgabe 2.2
Gesucht ist ein eine Belegung von produkt/7, fuer die gilt, dass 
die Anzahl groesser als 100 ist.

?- produkt(PId,dvd,Titel,Autor,_,_,Anzahl),Anzahl>100.
false.

?- asserta(produkt(65565,dvd,Transporter,none,luc_besson,2013,9001)).
True.

?- produkt(PId,dvd,Titel,Autor,_,_,Anzahl),Anzahl>100.
PId = 65565,
Titel = Transporter,
Autor = none,
Anzahl = 9001.
*/

/* Aufgabe 2.3
Um einen Preisvergleich zum vorherigen Jahr nachzuvollziehen, 
muss man den Vergleich ueber das Praedikat verkauft/4 abwickeln.

?- produkt(PId,buch,Titel,_,_,_,_),verkauft(PId,2012,preis2012,_),verkauft(PId,2011,preis2011,_),preis2012<preis2011.
PId = 12345,
Titel = sonnenuntergang,
preis2012 = 23,
preis2011 = 29 ;
PId = 12347,
Titel = winterzeit,
preis2012 = 9,
preis2011 = 19 ;
PId = 12349,
Titel = winterzeit,
preis2012 = 14,
preis2011 = 19 ;
false.
*/


/* Aufgabe 2.4
Gesucht sind Buecher und E-Buecher, welche den selben Autoren und Titel besitzen.

?- produkt(PIdBuch,buch,Titel,Autor,_,_,_),produkt(PIdebuch,ebuch,Titel,Autor,_,_,_).
PIdBuch = 12345,
Titel = sonnenuntergang,
Autor = hoffmann_susanne,
PIdBuch = 12348,
Titel = blutrache,
Autor = wolf_michael,
PIdHoerbuch = 23458 ;
*/


/* Aufgabe 2.5
Es werden die Buecher Gesucht, welche noch nicht als E-Buch angeboten werden.

?- produkt(PIdBuch,buch,Titel,Autor,_,_,_),(\+ produkt(PIdebuch,ebuch,Titel,Autor,_,_,_)).
PIdBuch = 12345,
PIdBuch = 12346,                                                                                                     
Titel = hoffnung,                                                                                                    
Autor = sand_molly ;                                                                                                 
PIdBuch = 12347,                                                                                                     
Titel = winterzeit,                                                                                                  
Autor = wolf_michael ;                                                                                               
PIdBuch = 12349,                                                                                                     
Titel = winterzeit,                                                                                                  
Autor = wolf_michael.
*/


/* Aufgabe 2.6

?- produkt(PId,buch,_,_,_,_,_),verkauft(PId,2012,_,Anzahl),
assertz(anzahl(PId,Anzahl));
anzahl(_,Anzahl1),anzahl(_,Anzahl2),Anzahl1\=Anzahl2,maxVerkauf(Anzahl1,Anzahl2);
anzahl(ErgebnisPId,ErgebnisAnzahl),retract(anzahl(_,_)).

PId = 12345, Anzahl = 8 ;
PId = 12346, Anzahl = 2 ;
PId = 12347, Anzahl = 0 ;
PId = 12348, Anzahl = 12 ;
PId = 12349, Anzahl = 83 ;
Anzahl1 = 8, Anzahl2 = 2 ;
Anzahl1 = 8, Anzahl2 = 0 ;
Anzahl1 = 8, Anzahl2 = 12 ;
Anzahl1 = 12, Anzahl2 = 83 ;
ErgebnisPId = 12349, ErgebnisAnzahl = 83.

*/

/*
?-[SE3LP-G7-A02-Beer-meyer-fps]

Beispielanfragen:

Alle Spieler , welche in der Competition 1 mitgespielt haben:
competition(1, Team1, Team2), team(Team1,Player1,Player2,Player3,Player4,_), team(Team2,Player5,Player6,Player7,Player8,_).
Team1 = 1,
Team2 = 2,
Player1 = nukesor,
Player2 = lonje,
Player3 = arnatar,
Player4 = xkcd,
Player5 = svenstaro,
Player6 = raffomania,
Player7 = opatut,
Player8 = megaman.


Alle Spieler, die mehr als 100 Kills haben:
player(Name,_,StatsID), statistic(StatsID,Kills,_,_),Kills>100.

Name = nukesor,
StatsID = 1,
Kills = 1000 ;
Name = svenstaro,
StatsID = 5,
Kills = 999 ;
Name = megaman,
StatsID = 8,
Kills = 9001.


Alle Teams, die gewonnen haben:
team(TeamId,_,_,_,_,true).
TeamId = 1.


Die Id des letzten Spiels eines Spielers:
player(nukesor,CompetitionID,_).
CompetitionID = 1.

Das Team, welches in einer Competition gewonnen hat.
competition(1, Team1, Team2), team(Team1,_,_,_,_,Team1Won), team(Team2,_,_,_,_,Team2Won).
Team1 = 1,
Team2 = 2,
Team1Won = true,
Team2Won = false.

*/

/* Aufgabe 4
 
Ein Prädikat ist eine Menge von Fakten, wobei der Name und die Anzahl der Argumente bei allen Fakten gleich sein muss. Ein Beispiel wäre:
schueler(hans,mueller).
schueler(tim,bauer).
schueler(malte,jahn).

Klauseln sind eine Art Verallgemeinerung von Fakten, Regeln und Zielen:
hat_raeder(auto):-ist_komplett(auto).
ist_rot(auto).
ist_rot(X).

Eine Struktur ist ein Prädikatsname mit Argumenten in den Klammern.
schueler(hans,mueller)
schueler(hans,X)
mutter_von(X,Y)

*/