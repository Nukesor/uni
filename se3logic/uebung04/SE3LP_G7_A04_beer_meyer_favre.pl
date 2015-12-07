:- [medien2].
%%% Arne Beer, Felix Favre, Anne-Victoria Meyer %%%
%%% Aufgabe 1 %%%
/*
A ist Mutter von B: 
  Nicht symmetrisch, da das Kind einer Mutter nicht gleichzeitig die Mutter 
  der eigenen Mutter sein kann.
  Nicht reflexiv, da niemand Mutter von sich selbst sein kann. 
  Nicht transitiv. Jedes Kind hat genau eine Mutter, die Mutter der Mutter 
  waere wiederum die Großmutter, nicht eine weitere Mutter der Kindes.
  Funktional in einem der Argumente, da jedes Kind genau eine Mutter hat, 
  eine Mutter jedoch mehrere Kinder haben kann.

A ist Nachbarland von B:
  Symmetrisch. Wenn zwei Laender nebeneinander liegen, so ist jedes das 
  Nachbarland vom jeweils anderen.
  Nicht reflexiv. Ein Land kann kein Nachbarland von sich selbst sein.
  Nicht transitiv, da nicht jedes Land A, das eine Grenze zu Land B hat, 
  auch eine Grenze zu jedem anderen Land, das an B grenzt, hat.
  Funktional in keinem der Argumente, da jedes Land mehrere Nachbarlaender 
  haben und zugleich Nachbarland von beliebig vielen Laendern sein kann.

A ist Vorfahre von B:
  Nicht symmetrisch. Wenn A von B abstammt, dann kann B nicht auch von 
  A abstammen.
  Nicht reflexiv. Niemand ist Vorfahre von sich selbst.
  Transitiv, da ein Vorfahre A eines Vorfahren B von Person C immer 
  auch ein Vorfahre von C ist.
  Funktional in keinem der Argumente, da jede Person mehrere Vorfahren hat 
  und selbst Vorfahre von mehreren Personen sein kann.

A ist groesser oder gleich B:
  Nicht symmetrisch. Wenn A groesser oder gleich B ist, dann muss A entweder 
  gleich B oder echt groesser als B sein. Wenn A echt groesser als B ist, so 
  kann B nicht groesser oder gleich A sein, also ist die Relation nicht 
  symmetrisch.
  Reflexiv. Eine Zahl ist immer groesser oder gleich sich selbst, da jede 
  Zahl gleich sich selbst ist.
  Transitiv. Wenn A groesser oder gleich B und B groesser oder gleich C, 
  so ist auch A groesser oder gleich C.
  Funktional in keinem der Argumente, da jede Zahl groesser oder gleich 
  mehreren anderen Zahlen ist und mehrere andere Zahlen groesser oder gleich 
  dieser Zahl sind.

A und B spielen eine Rolle im gleichen Film:
  Symmetrisch. Wenn A und B Rollen im gleichen Film spielen, so spielen auch 
  B und A eine Rolle im gleichen Film.
  Reflexiv, da A und A dieselbe Person sind.
  Nicht transitiv. Wenn A und B in Film X zusammen spielen, und B und C 
  in Film Y zusammen spielen, so spielen nicht zwingend auch A und C 
  zusammen in einem Film.
  Funktional in keinem der Argumente, da eine Person mit beliebig vielen anderen 
  Personen eine Rolle im Film spielen kann und beliebig viele andere Personen 
  zusammen mit dieser einen Person eine Rolle spielen koennen.

A ist gleich B:
  Symmetrisch. Wenn A gleich B, dann muss B gleich A sein.
  Reflexiv. Alles ist gleich zu sich selbst.
  Transitiv. Wenn A gleich B und B gleich C, dann muss auch A gleich C
  sein.
  Funktional in beiden Argumenten. Jede Zahl ist zu genau einer Zahl gleich: 
  zu sich selbst.
*/

%%% Aufgabe 2 %%%
/*2.1 Versucht Kategorie und passende Oberkategorie mit Schluessel der 
Oberkategorie zu finden. Bei nicht instanziiertem Aufruf wird ueber 
Backtracking zu jeder Kategorie die Oberkategorie mit Schluessel 
ausgegeben. Wird Category mit einer Kategorie unifiziert, so wird die 
Oberkategorie mit ihrem Schluessel ausgegeben. 
*/
parents(Category,Name_parent,Key_parent):-
    kategorie(_,Category,Key_parent),
    kategorie(Key_parent,Name_parent, _).

% 2.2

% Hier ist der Abbruchfall, falls die parentid == 0 ist. 
pathfinder(ID, _) :-
    kategorie(ID, _, Head),
    \+ kategorie(Head, _, _).


% Hier wird die Id vorrausgesetzt und anschliessend eine verkettete Liste 
% mit den categories und ids, der Parents, zurueckgegeben wird. 

pathfinder(ID, [Head | Tail]) :-
    kategorie(ID , _, Pid),
    kategorie(Pid, Head , _),
    pathfinder(Pid, [Tail]).


/* 
Gesucht war eine Funktion, die einem alle uebergeordneten Categories 
der jeweiligen Category ausgibt. 
*/

copylist([],[]) :- !.

copylist([Head | Tail], [Head | Endlist]) :-
    copylist(Tail, Endlist).


% 2.3

findproducts(id, [], _) :-
  \+ kategorie( _, _, id).

findproducts(Id, Startlist, Finallist) :-
    findall(Pid, produkt(Pid, Id, _, _, _, _, _), Sublist),
    append(Sublist, Startlist, Endlist),
    Finallist = Endlist,
    kategorie(Childid, _, Id),
    findproducts(Childid, Endlist, Finallist).


%%% Aufgabe 3 %%%


liegt_rechts_von(A,B) :-
    unmittelbar_rechts_von(A,B).

liegt_rechts_von(A, B) :-
    \+ unmittelbar_rechts_von(A, B),
    unmittelbar_rechts_von(A, C),
    liegt_rechts_von(C, B).


/*
Dieses Praedikat prueft, ob der direkte Nachbar das gewuenschte
Ziel ist. Falls dies nicht der Fall ist, sucht er sich den
naechsten rechten Knoten und prueft nun rekursiv, ob der folgende Nachbar
das gewuenschte Ziel ist.
*/

liegt_unterhalb_von(A,B) :-
    unmittelbar_unterhalb_von(A,B).

liegt_unterhalb_von(A, B) :-
    \+ unmittelbar_unterhalb_von(A, B),
    unmittelbar_unterhalb_von(A, C),
    liegt_unterhalb_von(C, B).

/*
Exakt die selbe Funktionsweise wie das vorherige Praedikat
*/

liegt_links_von(A, B) :-
    liegt_rechts_von(B, A).

/*
Wenn A rechts von B ist, dann ist B, links von A. Symmetrie
*/

liegt_oberhalb_von(A,B) :-
    liegt_unterhalb_von(B, A).
/*
Wenn A unterhalb von B ist, ist B oberhalb von A. Symmetrie
*/


ist_unmittelbar_benachbart_mit(A,B) :-
    unmittelbar_unterhalb_von(A,B);
    unmittelbar_unterhalb_von(B,A);
    unmittelbar_rechts_von(B,A);
    unmittelbar_rechts_von(A,B).

unmittelbar_unterhalb_von(a, b).
unmittelbar_unterhalb_von(b, c).
unmittelbar_unterhalb_von(c, d).
unmittelbar_rechts_von(e, b).
unmittelbar_rechts_von(b, f).
unmittelbar_rechts_von(f, g).

/*
?- liegt_rechts_von(e, g).
true .

?- liegt_rechts_von(g, e).
false.

?- liegt_links_von(g, e).
true .

?- liegt_oberhalb_von(d, a).
true .

?- liegt_unterhalb_von(a, d).
true .

?- liegt_unterhalb_von(d, a).
false.

?- ist_unmittelbar_benachbart_mit(b,c).                                                                           
true .                                                                                                            
                                                                                                                  
?- ist_unmittelbar_benachbart_mit(b,d).                                                                         
false.
*/

%%% Aufgabe 4 %%%

phelper(A, C) :-
  p(B, C),
  \+ p(A, B),
  phelper(A, B).

phelper(A, C) :-
  p(B, C),
  p(A, B).

p(a, b).
p(b, c).
p(c, d).
p(d, e).
p(f, g).

/*
Hier wird eine Helperfunktion aufgerufen, die auf Transition 
pruefen soll. Falls er keine direkte Transition findet, sucht er 
rekursiv nach weiteren Elementen, die eine moegliche Transitivitaet
erfuellen.
*/


/*
?- phelper(a, d).
true .

?- phelper(b, d).
true.

?- phelper(a, g).
false.
*/
