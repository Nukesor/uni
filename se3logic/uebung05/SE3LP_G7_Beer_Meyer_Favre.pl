/*
Blatt 5
Arne Beer, Felix Favre, Anne-Victoria Meyer
*/
%%% Aufgabe 1 %%%
/*
?- a(B,C) = a(m,p).
B = m,
C = p.
Da Name und Stelligkeit der Praedikate uebereinstimmen,
und jeweils eines der beiden Argumente spezifiziert ist und
das andere nicht, koennen diese einfach unifiziert werden.

?- s(1,2) = s(P,P).
false.

Dir Unifikation scheitert, da auf der rechten Seite eine Koreferenz
der beiden unterspezifizierten Argumente besteht, auf der linken Seite
jedoch beide Argumente spezifiert sind, aber mit unterschiedlichen
Zeichen. Also muesste P=1 und P=2 gelten, was nicht moeglich ist.

?- g(f(s,R),f(R,s)) = g(f(S,t(T)),f(t(t),S)).
R = t(t),
S = s,
T = t.

Der Name und die Stelligkeit des Praedikates sind gleich. Fuer die
Belegung S=s R=t(t) und T=t sind die inneren Praedikate f ebenfalls
erfuellt, wodurch die Unifikation erfolgreich ist.

?- q(t(r,s),c(g),h(g(T)),t)=q(Y,c(f(r,T)),h(Y)).
false.

Nicht unifizierbar, da zwar der Name beider Praedikate gleich ist,
die Stelligkeit jedoch unterschiedlich. q/4 ist nie mit q/3 unifizierbar.

?- true = not(not(True)).
false.

%%%%%%%%%%%% (TODO: ERKLAERUNG) %%%%%%%%%%%%

?- True = not(false).
True = not(false).

%%%%%%%%%%%% (TODO: ERKLAERUNG) %%%%%%%%%%%%
*/


%%% Aufgabe 2 %%%

% Less than, siehe Script
lt(0, s(_)).
lt(s(X), s(Y)) :- lt(X, Y).

% Addition, siehe Script
add(0,X,X).
add(s(X), Y, s(R)) :- add(X,Y,R).

/*
Definition der Peano-Terme, entnommen aus dem Skript.
peano(+Term)
Term ist ein Peano-Term
*/
peano(0).
peano(s(X)) :- peano(X).

% 2.1

nachfolger(Peano,Nachfolger):-
    peano(Peano),
    Nachfolger = s(Peano).
/*
Relation, die beschreibt, dass das zweite Argument der direkte
Nachfolger des ersten Arguments ist (beide Peano-Terme).

nachfolger(+Term1,+Term2)
Ist Term2 der direkte Nachfolger von Term1?
?- nachfolger(0,s(0)).
true.

nachfolger(+Term1,-Term2)
Was ist der Nachfolger von Term1?
?- nachfolger(0,Nachfolger).
Nachfolger = s(0).

nachfolger(-Term1,+Term2)
Wovon ist Term2 der Nachfolger.
Findet richtiges Ergebnis, sucht dann jedoch weiter bis Stack voll.
Folglich Einschraenkung der Richtungsunabhaengigkeit.
?- nachfolger(Peano,s(0)).
Peano = 0 ;
ERROR: Out of global stack

nachfolger(-Term1,-Term2)
Was sind Nachfolger welcher Terme?
Gibt beliebig viele Ergebnisse aus, wenn nach jeder gefundenen
Belegung wieder ';' eingegeben wird.
?- nachfolger(Peano,Nachfolger).
Peano = 0,
Nachfolger = s(0) ;
Peano = s(0),
Nachfolger = s(s(0)) ;
Peano = s(s(0)),
Nachfolger = s(s(s(0))) ;
Peano = s(s(s(0))),
Nachfolger = s(s(s(s(0)))) .
*/

% vorgaenger(?Peano, ?Vorgaenger)
vorgaenger(Peano,Vorgaenger):-
    peano(Peano),
% Der Vorgaenger wird durch s(Vorgaenger) ermittelt.
    Peano = s(Vorgaenger).
/*
?- vorgaenger(s(s(0)),Vorgaenger).
Vorgaenger = s(0).

?- vorgaenger(s(s(1)),Vorgaenger).
false.

?- vorgaenger(0,Vorgaenger).
false.
*/


%subbtraktion(?Minuend,?Subtrahend,?Ergebnis)
subtraktion(X,0,X).
subtraktion(s(X),s(Y),Ergebnis):-
        peano(X),
        peano(Y),
% Die abzuziehende Peano-Zahl muss kleiner sein.
        lt(X,Y),
        subtraktion(X,Y,Ergebnis).


/*
?- subtraktion(s(s(s(s(0)))),s(s(0)),X).
X = s(s((0)) ;
*/

%max(?Peano1,?Peano2,?PeanoMax)
max(X,X,X).
max(Peano1,Peano2,Max):-
        peano(Peano1),
        peano(Peano2),
% Je nachdem welche Peano-Zahl groesser ist, wird Max
% mit der groessten Zahl unifiziert.
        (lt(Peano1,Peano2) -> Max = Peano2; Max = Peano1).



%mod(?Peano1,Peano2,?PeanoZ)
%X mod Y = Z
%Rekusrsionsende
mod(X, Y, X) :- lt(X, Y).
%Rekursion
mod(X, Y, Z) :- add(X1, Y, X), mod(X1, Y, Z).
% Wir ziehen solange Y von X ab, bis X kleiner Y ist.
% Dann ist X mod Y = X

%?- mod(s(s(s(s(s(0))))), s(s(s(0))), X).
%X = s(s(0)) .

%?- mod(s(s(s(s(s(0))))), s(s(s(s(0)))), X).
%X = s(0) .

%?- mod(0, s(s(s(s(0)))), X).
%X = 0 .

%?- mod(s(0), s(s(s(s(0)))), X).
%X = s(0) .


%sToInt(?Peano, ?Int)
%Rekursionsende: 0 = 0
sToInt(0,0).
%Rekursion
sToInt(s(N),X):- sToInt(N,X1), X is X1+1.
%Wir dekrementieren N und X solange um 1,
%bis wir bei 0,0 angekommen sind.

/*
?- sToInt(0,0).
true.

?- sToInt(0,1).
false.

?- sToInt(0,-1).
false.

?- sToInt(s(0),1).
true.

?- sToInt(s(0),2).
false.

?- sToInt(s(s(s(s(0)))),X).
X = 4.

 */

% 2.2

lt_test(0, s(_)).
lt_test(s(X), s(Y)) :-
    peano(s(X)),
    peano(s(Y)),
    lt(X, Y).

/*
Das Verhalten ändert sich nicht.

?- lt_test(0,s(0)).
true.

?- lt_test(0,s(s(0))).
true.

?- lt_test(s(0),s(s(0))).
true.

?- lt_test(0,0).
false.

?- lt_test(s(0),0).
false.

?- lt_test(s(s(0)),s(0)).
false.
*/

add_test(0,X,X).
add_test(s(X), Y, s(R)) :-
    peano(s(X)),
    peano(Y),
    peano(s(R)),
    add(X,Y,R).

%Verhalten ändert sich nicht.
%?- add_test(0,0,0).
%true.

%?- add_test(0,s(0),s(0)).
%true.

%?- add_test(s(0),0,s(0)).
%true.

%?- add_test(s(s(0)),s(0),s(s(s(0)))).
%true.

%?- add_test(0,s(0),0).
%false.

%?- add_test(s(0),s(0),s(0)).
%false.


%%% Aufgabe 3 %%%

% 3.1
% Die Musterloesung des letzten Blattes
find_all_unterprodukte(KId, PId) :-
    produkt(PId, KId, _, _, _, _, _);
    kategorie(UKId, _, KId),
    find_all_unterprodukte(UKId, PId).

%get_verkaufspreis(-PId, +KId, +Jahr, -Preis)
get_verkaufspreis(PId, KId, Jahr, Preis) :-
    % Finden der jeweiligen Unterkategorien
    find_all_unterprodukte(KId, PId),
    % Abfrage des jeweiligen Preises
    verkauft(PId, Jahr, Preis, _).

%durchschnitt_verkaufspreis(?KId,Jahr,Verkaufspreis)
durchschnitt_verkaufspreis(KId,Jahr, Verkaufspreis):-
% Ermitteln der Preise einer Kategorie
        findall(Preis,get_verkaufspreis(_,KId,Jahr,Preis),Preisliste),
% Aufsummierung aller Preise der Liste
        sum_list(Preisliste, Preis_summe),
% Elemente der Liste
        length(Preisliste, Length),
        \+ Length == 0,
% Alle Preise durch die Gesamtanzahl der Preise.
        Verkaufspreis is Preis_summe / Length.

% 3.2

% TODO


%%% Aufgabe 4 %%%

ist_voraussetzung_fuer(dachstuhl_errichten,dach_decken).
ist_voraussetzung_fuer(dach_decken, dachausbau).
ist_voraussetzung_fuer(dach_decken, boden_verlegen).
ist_voraussetzung_fuer(ziegel_kaufen, mauern).
ist_voraussetzung_fuer(mauern, dachstuhl_errichten).
ist_voraussetzung_fuer(fundament, mauern).
ist_voraussetzung_fuer(zement_kaufen, fundament).
ist_voraussetzung_fuer(grundstueck_kaufen, fundament).
ist_voraussetzung_fuer(kaufvertrag_aufsetzen, grundstueck_kaufen).

ist_voraussetzung_fuer(Vorraussetzung, Arbeitsschritt):-
    ist_voraussetzung_fuer(Vorraussetzung, VorherigerArbeit),
    ist_voraussetzung_fuer(VorherigerArbeit, Arbeitsschritt).

/*
 ?- ist_voraussetzung_fuer(mauern, dachstuhl_errichten).
 true.

 ?- ist_voraussetzung_fuer(fundament, dachstuhl_errichten).
 true.

 ?- ist_voraussetzung_fuer(mauern, irgendwas_invalides).
 ERROR: Out of local stack

 Das Praedikat ist Transitivi, nicht funktinal und weder
 symmetrisch noch reflexiv.

 Es wird kein Hilfspraedikat verwendet. Das Rekusrsionsende steht
 also direkt im gleichen Praedikat.

 Die Implementierung terminiert nicht wenn es sich um eine Invalide
 Eingabe handelt. Da dann keiner der cut Befehle (!) erreicht wird.
*/