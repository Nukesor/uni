%% Arne Beer, Felix Favre
%% =============Aufgabe 1==============
%% 1

%% rekursive Berechnungsvorschrift
%% zins(+Anlagebetrag, +Zinsfaktor, +Anlagedauer, -Endguthaben)
zins(Anlagebetrag, _, 0, Anlagebetrag). %Rekursionsabschluss

%% Rekursionsschritt
zins(Anlagebetrag, Zinsfaktor, Anlagedauer, Endguthaben):-
    Anlagedauer > 0,
    X is Anlagedauer - 1,
    zins(Anlagebetrag, Zinsfaktor, X, Y),
    Endguthaben is (1 + Zinsfaktor) * Y.
%% ?- zins(500, 0,5, 0, Endguthaben).
%% Endguthaben = 500 ;
%% false.
%%
%% ?- zins(500, 0.5, 1, Endguthaben).
%% Endguthaben = 750.0 ;
%% false.
%%
%% ?- zins(500, 0.5, 2, Endguthaben).
%% Endguthaben = 1125.0 :
%% false.
%% ?- zins(500, 0.05 , 211, Endguthaben).
%% Endguthaben = 14788090.78578775 ;



%% 2

%%
%% nicht rekursive Berechnungsvorschrift
%% zins2(+Anlagebetrag, +Zinsfaktor, +Anlagedauer, -Endguthaben)
zins2(Anlagebetrag, Zinsfaktor, Anlagedauer, Endguthaben):-
    Endguthaben is
    (Anlagebetrag * (1 + Zinsfaktor) ** Anlagedauer).

%% ?- zins2(500, 0.5 , 0, Endguthaben).
%% Endguthaben = 500.0.
%%
%% ?- zins2(500, 0.5 , 1, Endguthaben).
%% Endguthaben = 750.0.
%%
%% ?- zins2(500, 0.5 , 2, Endguthaben).
%% Endguthaben = 1125.0.

%% ?- zins2(500, 0.05 , 211, Endguthaben).
%% Endguthaben = 14788090.785787735.

%% Zunachst faellt auf das in der nicht rekursiven Berechnung auch fuer 0 Jahre 500.0 errechnet wird (im Gegensatz zu 500).
%% Denn hier wird in jedem Fall eine Berechnung durchgefuehrt und so die Ganzzahl zur Fliesskommazahl.
%% Die Rekursionsvariante dagegen spring im Fall 0 Jahre direkt zum Rekursionsende und gibt somit nur die Eingabe zurueck.
%% Dann scheinen die Ergebisse zunachst nicht abzuweichen, erst fuer sehr grosse Werte gibt es wieder Unterschiede.
%% Diese entstehen vermutlich durch Rundungsfehler die sich in der Rekursionsvariante immer weiter aufaddieren.
%% Ansonsten sind die Resulate gleich.

%% 3
%% endrekursive Berechnungsvorschrift
zins3(Anlagebetrag, _, 0, Anlagebetrag). % REkursionsabschluss


%% zins3(+Anlagebetrag, +Zinsfaktor, +Anlagedauer, -Endguthaben)
zins3(Anlagebetrag, Zinsfaktor, Anlagedauer, Endguthaben):-
    Anlagedauer > 0,
    Anlagebetrag1 is Anlagebetrag * (1 + Zinsfaktor),
    Anlagedauer1 is Anlagedauer - 1,
    zins3(Anlagebetrag1, Zinsfaktor, Anlagedauer1, Endguthaben).

%% ?- zins3(500, 0.5 , 0, Endguthaben).
%% Endguthaben = 500 ;
%% false.
%%
%% ?- zins3(500, 0.5 , 0, Endguthaben).
%% Endguthaben = 500 ;
%% false.
%%
%% ?- zins3(500, 0.5 , 2, Endguthaben).
%% Endguthaben = 1125.0 ;
%% false.



% 4
% Hilfsprädikat
% bonuszins(+Basiszins, +Jahr, +Zuwachs,-Zins)
%
% Rekursionsabschluss
bonuszinsH(Basiszins, 0, _, Zins):-
    Zins is Basiszins + 1. %stets ein Basiszins von 1%
bonuszinsH(Basiszins , 1, _, Zins):-
    Zins is Basiszins + 3. % im ersten Jahr 1% + 2% = 3%

bonuszinsH(Basiszins, Jahr, Zuwachs, Zins):-
    Jahr > 1, %Weil in jedem weiteren Jahr nach dem ersten
    Jahr1 is Jahr - 1,+
    Zuwachs1 is Zuwachs * 0.5,
    Basiszins1 is Basiszins + Zuwachs1,
    bonuszinsH(Basiszins1, Jahr1, Zuwachs1, Zins).

bonuszins(Jahr, Zins):-
    bonuszinsH(0, Jahr, 2, Zins). % Zuwachs ist 2 im ersten Jahr
                                      % daher Zuwachs = 2

% Berechnung mit nicht konstantem Zins
% zins4(+Anlagebetrag, +Anlagedauer, -Endguthaben)
zins4(Anlagebetrag, 0, Endguthaben):-
    Endguthaben is Anlagebetrag * 1.01.

zins4(Anlagebetrag, Anlagedauer, Endguthaben):-
    Anlagedauer > 0,
    bonuszins(Anlagedauer, Zinsfaktor),
    Anlagebetrag1 is Anlagebetrag * (1 + (Zinsfaktor/ 100)),
    Anlagedauer1 is Anlagedauer - 1,
    zins4(Anlagebetrag1, Anlagedauer1, Endguthaben).

% ?- zins4(100, 0, Endguthaben).
% false.
%
 %?- zins4(100, 1, Endguthaben).
% Endguthaben = 104.03 ;
% false.
%
% ?- zins4(100, 2, Endguthaben).
% Endguthaben = 2020.0 .
%
% ?- zins4(100, 3, Endguthaben).
% Endguthaben = 113.05980400000001 ;
% false.

%% Endrekursion ist unserer Ansicht nach der bessere Ansatz. Da die Zwischenergebnisse jederzeit per Akkumulator "mitgetragen" werden,
%% denn hier machen auch die Zwischenergebnisse Sinn.
%% 5

mehrGeld(Jahre):-
zins3(500, 0.04, Jahre, GeldFest),
zins4(500, Jahre, GeldBonus),
GeldFest < GeldBonus.

%% ?- mehrGeld(1).
%% true ;
%% false.

%% ?- mehrGeld(2).
%% false.

%% ?- mehrGeld(2).
%% false.

%% ?- mehrGeld(3).
%% false.

%% ?- mehrGeld(4).
%% false.

%% ?- mehrGeld(5).
%% false.

%% ?- mehrGeld(6).
%% false.

%% ?- mehrGeld(7).
%% false.

%% ?- mehrGeld(100).
%% false.

%% ?- mehrGeld(1000).
%% false.

%% ?- mehrGeld(10000).
%% false.

%% ?- mehrGeld(50).
%% false.

%% Nur Im ersten Jahr ist das Geld aus dem Festzinssatz mehr, fuer den Anleger lohnt es sich also fuer Anlagezeitraume ueber einem Jahr stets den Bonuszinssatz zu nehmen.

%% =============Aufgabe 2:==============
%% Aufsteigend rekursive Implementation:
aufsteigendPi(1, 4) :- !.

aufsteigendPi(Schritte, Resultat) :-
    RekursionsSchritte is Schritte - 1,
    aufsteigendPi(RekursionsSchritte, RekursionsResultat),
    Resultat is RekursionsResultat + (4 * (-1 ** (Schritte+1))/((2*Schritte) - 1)).

%% Endrekursive Implementation:
endPi(Schritte, Resultat) :-
    endPi(Schritte, 0, Resultat),!.

endPi(1, Akkumulator, Resultat) :-
    Resultat is 4 + Akkumulator.

endPi(Schritte, Akkumulator, Resultat) :-
    RekursionsResultat is Akkumulator + (4 * (-1 ** (Schritte+1))/((2*Schritte) - 1)),
    RekursionsSchritte is Schritte - 1,
    endPi(RekursionsSchritte, RekursionsResultat, Resultat).


%% Die endrekursive Lösung ist deutlich schneller als die aufsteigend
%% rekursive Implementation, allerdings wird auch mehr Code benötigt.
%% Beide Implementationen liefern bei gleichvielen Iterationen
%% das gleiche Ergebnis.

%% Es werden 10794 Approximationsschritte benötigt, um Pi auf 4 Stellen
%% nach dem Komma zu berechnen:

%% ?- endPi(10794,R).
%% R = 3.1415000095284764.
%% Zu beachten ist, dass endPi(10795) nicht mehr auf 4 Nachkommastellen
%% genau ist.

%% Ein Aufruf beider Prädikate mit time/1:

%% ?- time(endPi(10000,R)).
%% % 20,001 inferences, 0.020 CPU in 0.020 seconds (99% CPU, 1006702 Lips)
%% R = 3.1414926535900434.

%% ?- time(aufsteigendPi(10000,R)).
%% % 19,999 inferences, 0.680 CPU in 0.679 seconds (100% CPU, 29424 Lips)
%% R = 3.1414926535900345.

%-----------Aufgabe 3------------

%3.1
%nat_zahl(?Result)
nat_zahl(Result):-
    Result is 0;
    nat_zahl_rek(Result, 0).

nat_zahl_rek(Result, Last):-
    Result is Last + 1;
    NewLast is Last + 1,
    nat_zahl_rek(Result, NewLast).

/*
?- nat_zahl(R).
R = 0 ;
R = 1 ;
R = 2 ;
R = 3 ;
R = 4 ;
R = 5 ;
R = 6 ;
*/

%3.2
% nat_zahl_limit(?Result, int Limit)
nat_zahl_limit(Result, Limit):-
    Result is 0;
    nat_zahl_limit_rek(Result, 0, Limit).

nat_zahl_limit_rek(Result, Last, Limit):-
    Result is Last + 1,
    Result =< Limit;
    NewLast is Last + 1,
    NewLast =< Limit,
    nat_zahl_limit_rek(Result, NewLast, Limit).

/*
?- nat_zahl_limit(R,5).
R = 0 ;
R = 1 ;
R = 2 ;
R = 3 ;
R = 4 ;
R = 5 ;
false.
 */

%3.3


%3.4
%-


%-----------Aufgabe 4------------

%4.1

% Zuerst verschiedene Rechenregeln.
binomial_coefficient(X,X,1):- !. %Wenn k=n, dann Ergebnis = 1

binomial_coefficient(_,0,1):- !. %sonst, wenn k=0, dann Ergebnis = 1

binomial_coefficient(0,_,0):- !. %sonst, wenn n=0, dann Ergebnis = 0

binomial_coefficient(N,1,N):- !. %sonst, wenn k=1, dann Ergebnis = n

binomial_coefficient(N,K,Result):-  %sonst rekursive Berechnung
         N1 is N-1, % Hilfsvariablen
         K1 is K-1,
         binomial_coefficient(N1,K1,Res1), %Erster Rekursionsast
         binomial_coefficient(N1,K,Res2), %Zweiter Rekursionsast
         Result is Res1 + Res2. % Addition

/*
?- binomial_coefficient(10,5,R).
R = 252.

?- binomial_coefficient(12,6,R).
R = 924.

?- binomial_coefficient(20,5,R).
R = 15504.

?- binomial_coefficient(24,2,R).
R = 276.

*/
