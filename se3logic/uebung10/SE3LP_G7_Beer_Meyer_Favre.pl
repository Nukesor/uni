%% Arne Beer, Felix Favre
%% SE3LP_G8_Beer_Favre

%% =============Aufgabe 1==============

% Das Aufgabenblatt ist leider nicht mehr ganz aktuell.
% SE3 ist kein Pflichmodul mehr.
% Hier wird es aber dennoch als Pflichmodul definiert,
% um dem Aufgabenblatt zu entsprechen.

% Einige Pflichmodule definiert.
isa(se1, pflichtmodul).
isa(se2, pflichtmodul).
isa(rs, pflichtmodul).
isa(ikon, pflichtmodul).
isa(ad, pflichtmodul).
isa(seminar, pflichtmodul).
isa(projekt, pflichtmodul).
isa(praktikum, pflichtmodul).
isa(dm,pflichtmodul).
isa(ala,pflichtmodul).
isa(se3,pflichtmodul).

% Enige wahlpflichtmodule definiert.
isa(gdb, wahlpflichtmodul).
isa(gwv, wahlpflichtmodul).
isa(hlr, wahlpflichtmodul).
isa(sto, wahlpflichtmodul).
isa(opt, wahlpflichtmodul).


% Hat ein Modul keine Vorlesung schliesst man es
% mit einem Eintrag keineVorlesung(V) aus.

keineVorlesung(seminar).
keineVorlesung(projekt).
keineVorlesung(praktikum).


% Mathemodule müssen extra dafiniert werden
mathemodul(dm).
mathemodul(ala).
mathemodul(sto).
mathemodul(opt).

% Eine Veranstaltung hat genau dann eine Übung,
% wenn sie ein Pflichtmodul oder ein Wahlpflichtmodul ist.
isa(Veranstaltung,uebung):-
    isa(Veranstaltung, pflichtmodul);
    isa(Veranstaltung, wahlpflichtmodul).


% Eine Veranstaltung hate genau dann eine Vorlesung,
% wenn sie ein Pflichmodule oder ein Wahlpflichtmodul ist
% und nicht durch das keineVorlesung Praedikat ausgeschlossen wurde.
isa(Veranstaltung,vorlesung):-
    (
        isa(Veranstaltung,pflichtmodul);
        isa(Veranstaltung,wahlpflichtmodul)
    ),
    \+ keineVorlesung(Veranstaltung).



% Es gibt wahrscheinlich mehr nicht Pflichtmodule,
% daher keinen Default auf Pflichtmodul.
% isa(_,pflichtmodul).



ort(ad, uebung, zbh).

% Die Vorlesung AD gehört ebenfalls zu einem Pflichtmodul, findet aber
% teils im Philturm und teils im Hörsaal Erziehungswissenschaft statt.
ort(ad, vorlesung, erziehungswissenschaften).
ort(ad, vorlesung, philturm) :- !.


% Die Vorlesung SE 3 gehört zwar zu einem Pflichtmodul,
% findet aberim Hauptgebäude statt.
ort(se3, vorlesung, hauptgebaeude) :- !.

% Alle Mathematikveranstaltungen findem im Geomatikum statt.
ort(Veranstaltung, Veranstaltungsart, geomatikum) :-
    % Nur Orte für reale Veranstaltungen angeben.
    isa(Veranstaltung, Veranstaltungsart),
    mathemodul(Veranstaltung), !.

% Die Vorlesungen der Pflichtmodule finden aber im Philturm statt.
ort(Veranstaltung, vorlesung, philturm) :-
    isa(Veranstaltung, pflichtmodul),
    % Nur Orte für reale Veranstaltungen angeben.
    isa(Veranstaltung, vorlesung),
    !.

%Lehrveranstaltungen finden im Prinzip immer in Stellingen statt.
ort(Veranstaltung, Veranstaltungsart, stellingen) :-
    % Nur Orte für reale Veranstaltungen angeben.
    isa(Veranstaltung, Veranstaltungsart).

/*
Folgende Anfragen zeigen die Erfüllung
sämtlicher Sonderregeln.

?- ort(se1, vorlesung, Ort).
Ort = philturm.

?- ort(se3, vorlesung, Ort).
Ort = hauptgebaeude.

?- ort(ad, vorlesung, Ort).
Ort = erziehungswissenschaften ;
Ort = philturm.

?- ort(dm, vorlesung, Ort).
Ort = geomatikum.

?- ort(dm, uebung, Ort).
Ort = geomatikum.

?- ort(ad, uebung, Ort).
Ort = zbh ;
Ort = stellingen ;
false.

?- ort(se1, uebung, Ort).
Ort = stellingen ;
false.

?- ort(gwv, uebung, Ort).
Ort = stellingen ;
false.
*/


% Unterspezifizierte Anfragen werden
% beim Backtracking durch Cuts unterbrochen
% und sind hierdurch unvollstaendig
%
% Um dies zu verhindern, kann man an dieser
% Stelle unterspezifizierte Anfragen mit var(X)
% verhindern
% Dannach stellt man eine vollständige
% Suchanfrage, die alle möglichen Veranstaltungen
% und Typen ausprobiert. Der Cut unterbricht hier nicht
% , da man auf die Existenz eines Faktes im
% allgemeinen prueft.


%% =============Aufgabe 2==============
means(he, er).
means(caught, fing).
means(a, ein).
means(a, eine).
means(a, einen).
means(butterfly, schmetterling).
means(makes, macht).
means(the, der).
means(the, die).
means(the, das).
means(profession, beruf).
means(job, beruf).
means(occupation, beruf).
means(career, beruf) .
means(ergreift, [takes, up]).

notranslation(X, X).



translate([], []).
translate([GerHead|GerTail], [EngHead|EngTail]):-
    (
        means(EngHead, GerHead);
        (
            \+ means(EngHead, GerHead),
            notranslation(GerHead, EngHead)
        )
    ),
    translate(GerTail,EngTail).




%% =============Aufgabe 3==============

% Laden der Hilfs-library
:-use_module(library(clpfd)).

% Praedikat fuer die maplist
isQuatrupel(List) :-
    length( List, 4).

findeFahrer(L) :-

    %   1            2       3         4       5
    %   Archie      Gunter  Hanserich Jupp    Walter
    %   Citroen     Granada Porsche   Sierra  Volvo
    %   Elbchaussee A1      A7        B4      B432
    %   118         123     128       133     138

    % [Fahrer, Auto, Straße, Geschwindigkeit]

    % 5 Quatrupel
    length(L,5),
    % Jedes Element von L ist ein Quatrupel
    maplist(isQuatrupel, L),
    % Jeder wert ist eine Zahl von 1 bis 5
    append(L, Werte), Werte ins 1..5,


    % LT enthält 4 Listen a 5 Elemente
    % Eine Liste mit allen Autos, eine mit den Fahrern usw.
    transpose(L, LT),

    % Überprüfe für diese Liste, ob sie Duplikate enthalten.
    % So kann kein Fahrer, Auto, usw. doppelt belegt werden.
    maplist(all_different, LT),


    % Bedingung 1
    member([4,1,_,SpeedJuppCitroen],L),
    member([_,_,2,SpeedA1],L),
    % Da alle Geschwindigkeiten eine Differenz von
    % 5km/h zur nächten haben, kann man sie mit den
    % zahlen 1-5 einfach vergleichen
    % 5km/h mehr ist die nächstgrößere Geschwindigkeit

    SpeedA1+1 #= SpeedJuppCitroen,

    % Bedingung 2
    % Walter(5) war der schnellste (5)
    member([5,_,LocationWalter,5],L),
    % Er war nicht auf der A1
    LocationWalter #\= 2,
    % Und auch nicht auf der A7
    LocationWalter #\= 3,

    % Der Fahrer des Sierra(4)
    member([_,4,LocationSierra,_],L),
    (
        %War auf der A1
        LocationSierra #= 2;
        %Oder der A7
        LocationSierra #= 3
    ),


    % Bedingung 3
    % Der Fahrer des Granada(2)
    member([_,2,LocationGranada,_],L),
    (
        % War auf der B4
        LocationGranada #= 4;
        % Oder der B432
        LocationGranada #= 5
    ),

    % Bedingung 4
    % Der Fahrer des Volvo(5), unterwegs mit 133km/h (4)
    member([DriverVolvo,5,_,4],L),
    % Heißt nicht Archie
    DriverVolvo #\= 1,
    % Und auch nicht Hanserich
    DriverVolvo #\= 3,

    % Hanserich
    member([3,_,LocationHanserich,_],L),
    (
        % War unterwegs auf der B4
        LocationHanserich #= 4;
        % Oder der B432
        LocationHanserich #= 5
    ),

    % Bedingung 5
    % Weder Gunter
    member([2,_,LocationGunter,_],L),
    % Noch der Fahrer des Porsche
    member([_,3,LocationPorsche,_],L),
    % Waren unterwegs auf der Elbchaussee
    LocationGunter #\=1 ,
    LocationPorsche #\=1 ,

    % Bedingung 6
    % Der Wagen auf der B432, welcher mit 118km/h geblitzt wurde
    member([_,CarB432,5,1],L),
    % war kein Porsche
    CarB432 #\= 3.

% ?- findeFahrer(L).
% L = [ [4, 1, 1, 3], [1, 4, 2, 2], [5, 3, 4, 5],
%       [3, 2, 5, 1], [2, 5, 3, 4] ] .
% Übersetzt:
% Jupp      Citroen Elbchaussee 128
% Archie    Sierra  A1          123
% Walter    Porsche B4          138
% Hanserich Granada B432        118
% Günter    Volvo   A7          133


