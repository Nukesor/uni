% Abgabe Arne Beer, Anne-Victoria Meyer, Felix Favre

% Uebungsgruppe 7

/* Aufgabe 1

In der logischen Programmierung erhalten Variablen ihren Wert
lediglich durch Unifikation. Dieser Wert kann im Gegensatz zu
anderen Programmiersprachen nun nur ueber einen bestimmten
Mechanismus, das Backtracking, aufgeloest werden. In Gegensatz
dazu stehen z.B. die objektorientierte Programmiersprachen, bei
denen eine Variable einer tatsaechlichen Speicherzuweisung auf
einem pysikalischem Speicher entspricht. In der funktionalen
Programmierung hingegen werden Variablen hauptsaechlich dazu
verwendet Werte an Funktionen zu uebergeben. Zu beachten ist
hier, dass der Scope einer Variable nur lokal ist.
Eine Variable wird in der logischen Programmierung immer
dynamisch waehrend der Laufzeit instanziiert. Hier gibt es
auch nichtinstanziierte Variablen, die zwar bereits existieren,
aber noch keine gueltige Bindung an ein Datenobjekt besitzen.
Durch nicht instanziierte Variablen lassen sich in der
Logikprogrammierung unterspezifizierte Ziele definieren.

*/

% Aufgabe 2.1
% get_price(Pid, Kategorie,Titel,Autor,Verlag, Preis)
get_price(Pid, Kategorie, Titel, Autor, Verlag, Preis) :-
    produkt(Pid, Kategorie, Titel, Autor, Verlag, _ , _ ),
    verkauft(Pid, Year1, Preis, _ ),
    \+ (verkauft(Pid, Year2,_,_),
        Year2 > Year1).

/*
Es wird ein neues Praedikat definiert, welches ein Produkt sucht,
 das anschliessend die PId zurueckgibt und den Preis, als es das
 letzte Mal verkauft wurde.

get_price(Pid, buch, sonnenuntergang, hoffmann_susanne, meister, Preis).
Pid = 12345,
Preis = 23 ;
false

*/


% Aufgabe 2.2
% last_offer(Pid, Kategorie, Titel, Autor, Verlag, Year1)
last_offer(Pid, Kategorie, Titel, Autor, Verlag, Year1) :-
    produkt(Pid, Kategorie, Titel, Autor, Verlag, _ , _ ),
    verkauft(Pid, Year1, _ , _ ),
    \+ (verkauft(Pid, Year2, _, _),Year2 > Year1).
/*
Sucht die jeweilige Pid fuer die passenden Attribute des Produkts und
sucht fuer die jeweilige Pid das neuste Jahr im Praedikat verkauft/4

?- last_offer(Pid, buch, sonnenuntergang, hoffmann_susanne, meister, Year1).
Pid = 12345,
Year1 = 2012 ;
false.

*/

% Aufgabe 2.3

% not_offered(Pid, Number)
not_offered(Pid, Number1) :-
    verkauft(Pid, Year1, _, Number1),
    Number1 > 0,
    \+ (produkt(Pid, _, _, _, _, _, _ )),
    \+ (verkauft(Pid, Year2, _, _), Year1 > Year2).

/*
Es wird im Praedikat verkauft nach einer Pid gesucht deren Produkt bereits
verkauft wurde, nun jedoch nicht mehr als Produkt angeboten werden.
Ausserdem wird der neuste Verkauf gesucht und darauf geachtet, dass die
Anzahl nach dem Verkauf gleich 0 ist.

?- not_offered(Pid, Number).
Pid = 66666,
Number = 83 ;
false.
*/

% Aufgabe 3.1

% productcount(Kategorie, Anzahl)
productcount(Kategorie, Anzahl):-
    findall(Kategorie, produkt(_ , Kategorie, _, _, _, _, _), List),
    length(List, Anzahl).

/*
Es wird ein neuens Praedikat erstellt, dass mit Hilfe von findall eine
Liste mit allen Produkten der jeweiligen Kategorie anlegt und
anschliessend mit dem bereits gegebenen Praedikat length die
jeweilige Laenge dieser Liste zurueckgibt.
*/

% Aufgabe 3.2


list_sum([], 0).
list_sum([Head | Tail], TotalSum) :-
    list_sum(Tail, Sum1),
    TotalSum is Head + Sum1.

verkaufte_exemplare(Kategorie, Anzahl) :-
    findall(Anzahl_pro_verkauft, (
        produkt(Pid, Kategorie, _, _, _, _, _),
        verkauft(Pid, _, _, Anzahl_pro_verkauft)),
        Liste_gesamt),
    list_sum(Liste_gesamt, Anzahl).

% Aufgabe 3.3





% Aufgabe 4
% 4.1
subcategories(KategorieId, Name) :-
    kategorie(_, Name, KategorieId).

/*
Es werden alle Kategorien ausgegeben, die als Oberkategorie die übergebene Kategorie besitzen.

?- kategorie(_, Name, 1).
Name = kinder ;
Name = krimi ;
Name = roman ;
Name = sachbuch ;
Name = lyrik.
*/

% 4.2


% Eigene Memberfunktion um das Backtracking einzugrenzen. Sonst bildet das set Prädikat die selbe Liste mehrmals.

/* 
 Hier wird geschaut, ob das Element in der Liste vorhanden ist. Wenn die das erste Element der Restliste 
 gleich dem Head der usprungsliste ist, wird ein cut zurueckgegeben, welches alle Ausswagen wahr werden laesst und 
 weiteres Backtracking verhindert. Falls dies nicht der Fall ist, wird weiterhin in der Liste nach einer Uebereinstimmung 
 gesucht. Falls diese nicht gefunden wird, findet das Praedikat keine wahre loesung und gibt ein false aus, welches durch 
 not negiert wird und somit true wird.
*/
set_member(Var,[Var|_]) :- !.
set_member(Var,[_|Tail]) :- set_member(Var,Tail).

% Das set Prädikat macht aus einer Liste ein set. (Entfernt alle Duplikate)
set([],[]).
/*
 Wenn keine Belegung gefunden wird, fuer die der Head in der gegebenen Liste eine Kopie innerhalb der Liste besitzt, wird 
 der Head an die Out Liste konkateniert und rekursiv set auf den Rest der Liste aufgerufen mit der unkonkatenierten Out-Liste.
*/
set([Head|Tail],[Head|Out]) :-
    not(set_member(Head,Tail)),
    set(Tail,Out).
/*
 Wenn eine Belegung gefunden wird, fuer die der Head in der gegebenen Liste eine Kopie innerhalb der Liste besitzt, wird 
 der Head nicht konkateniert und rekursiv set auf den Rest der Liste aufgerufen.
*/
set([Head|Tail],Out) :-
    set_member(Head,Tail),
    set(Tail,Out).


duplicate_categories(List) :-
    findall(Name1 , (kategorie(Id1, Name1, _), kategorie(Id2, Name2, _), \+(Id1 == Id2), (Name1 == Name2)), FullList),
    set(FullList, List).

/*
?- duplicate_categories(A).
A = [kinder, krimi, roman, sachbuch, lyrik] ;
false.

Erst werden mit findall alle Kategorien gefunden, die den Selben Namen haben, danach filtert das set die Duplikate raus.
*/
% 4.3
no_subcategories(Name) :-
    kategorie(Id1, Name, _),
    \+ kategorie(_, _, Id1).
/*
Ermittelt all die Kategorien, für die es keine Subkategorie gibt, welche die Id der Kategorie als superkategorie hat.

?- no_subcategories(Kategorie).
Kategorie = kinder ;
Kategorie = kinder ;
Kategorie = krimi ;
Kategorie = krimi ;
Kategorie = krimi ;
Kategorie = roman ;
Kategorie = roman ;
Kategorie = roman ;
Kategorie = sachbuch ;
Kategorie = bilderbuch ;
Kategorie = reisefuehrer ;
Kategorie = lexikon ;
Kategorie = lyrik ;
Kategorie = lyrik ;
Kategorie = bastelbuch ;
Kategorie = woerterbuch.


*/
% 4.4
broken_categories(Name) :-
    kategorie(_, Name, Superkategorie),
    Superkategorie \= 0,
    \+ kategorie(Superkategorie, _, _).