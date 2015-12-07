%% Arne Beer, Felix Favre
%% In Zusammenarbeit mit Gruppe Arne Struck und Jan Esdonk entstanden
%% SE3LP_G8_Beer_Meyer_Favre

%% =============Aufgabe 1==============
% ?-["texte.pro"].

% delstop(+Startlist, +Unwanted, -Endlist)
% Rekursionsabbruch, falls der komplette Text aus Stoppwoertern besteht
delstop([],_,[]).
% Rekursionabbruch, falls keine Stoppwoerter mehr vorhanden sind
delstop(Result,[],Result).


delstop(Text,[H|T],Result):-   
    % Entfernt alle Stoppwoerter aus dem Text und gibt den modifizierten Text aus
    delete(Text, H, NText),
    % Rekursiver Aufruf fuer die restlichen Stoppwoerter mit dem modifizierten Text
    delstop(NText, T, Result).



%% =============Aufgabe 2==============


% Helperfunktion fuer finden der Sublist
findSublist(Element, [[H, T]|Tail], Counter) :-
    % Prueft ob Element in der Sublist vorhanden ist
    nth1(_, [H,T], Element) -> 
    % Falls dies stimmt, wird der Counter mit T unifiziert fuer den spaeteren Gebrauch
    Counter = T
    % Rekursiver Aufruf auf den Rest der Liste
    ; findSublist(Element, Tail, Counter).


% Rekursionsabbruch, falls die urspruengliche Liste leer ist.
hauefigkeithelper([], X, X).
hauefigkeithelper([H|T], Endlist, Res) :-
%Falls eine Sublist mit dem keyword existiert
    findSublist(H,  Endlist, Counter)->
%wird diese Sublist geloescht
    delete(Endlist, [H, Counter], Templist),
%der Counter der geloeschten Sublist imkrementiert
    CounterInk is Counter + 1,
%und eine neue Sublist mit inkrementierem Counter hinzugefuegt
    append(Templist, [[H, CounterInk]], Finallist),
%anschliessend rekursiver Aufruf auf den Rest der Liste
    hauefigkeithelper(T, Finallist, Res)
    ; 
%Da die Sublist noch nicht existiert wird hier eine Sublist mit dem Counter 1 hinzugefuegt
    append(Endlist, [[H, 1]], Finallist),
%Rekursiver Aufruf auf den Rest der Liste
    hauefigkeithelper(T, Finallist, Res).

% hauefigkeit(+List, -Endlist) 
hauefigkeit(Startlist, Endlist) :-
    hauefigkeithelper(Startlist, [], Endlist).


%% =============Aufgabe 3==============

% 3.1

% Abbruchbedingung
indize([], _, X, X).
% Indiziert alle Woerter einer Liste
indize([H|T], Index, Endlist, Res) :-
    % Falls eine Subliste gefunden wird, wird zum naechsten Wort gegangen
    findSublist(H,  Endlist, _)->
    indize(T, Index, Endlist, Res); 
    % Falls keine Subliste gefunden wird, wird ein neuer Eintrag vorgenommen
    % mit erhoehtem Indize.
    Counter is Index + 1,
    append(Endlist, [[H, Counter]], Finallist),
    indize(T, Counter, Finallist, Res).

% Indiziert eine Liste 
indizieren(Startlist, Endlist) :-
    indize(Startlist, 0, [], Endlist).


% 3.2

% findSublist ist in diesem Falle die gewuenschte Funktion

% ?- findSublist(hallo, [[ja, 1], [nein, 2], [hallo, 3]], Index).
% Index = 3.

% 3.3

% Abbruchbedinung
ersetze([], _, []).
ersetze([H|T], Indexlist, Endlist) :-
    % Falls es eine Sublist gibt, wird der Counter ausgewertet
    findSublist(H, Indexlist, Counter) ->
        % Rekursiver Aufruf auf den Rest der Liste
        ersetze(T, Indexlist, Zwischenlist),
        % Einfuegen des Counters an den Head er Liste
        Endlist = [Counter|Zwischenlist];
        % Falls kein Index vorhanden ist, wird das Wort beibehalten.
        ersetze(T, Indexlist, Zwischenlist),
        Endlist = [H|Zwischenlist].

% ersetze([hallo, ich, bin, der, arne, mit, dem, bier], [[hallo, 1], [arne, 9001], [bier, 1337]], List).
% List = [1, ich, bin, der, 9001, mit, dem, 1337].

%% =============Aufgabe 4==============

% 4.1

% Der Baum selbst besteht aus Knoten, sodass das Praedikat, welches diesen
% Knoten repräsentiert soll einen Index und zwei Kinder besitzen muss. 
% Ebenfalls muss es einen Inhalt, also das Wort beinhalten.

% Baum(Wort, Index, Child1, Child2)

% Die jeweiligen Kinder sind Listen, welche wiederum nach dem selben 
% Prinzip angeordnet sind.

test_baum([1, test,
                [2, hallo,
                [3, welt, [], []],
                    [4, foo, [], []]],
                [5, bar, [], []]]).


% 4.2 TODO

% 4.3

getIndex(_, [], _) :- fail.

getIndex(Wort, [BaumIndex, BaumWort, Kind1, Kind2], Index) :-
        Wort = BaumWort ->
            BaumIndex = Index,
            !
        ;
        getIndex(Wort, Kind1, Index);
        getIndex(Wort, Kind2, Index).

% Test:
% ?- test_baum(Baum), getIndex(hallo, Baum, Index).
% Baum = [3, test, [1, hallo, [], [0, welt|...]], [4, bar, baum, [], []]],
% Index = 1.

% 4.4 TODO