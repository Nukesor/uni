preis(PId, Preis) :-
    produkt(PId, _, _, _, _, _, _),
    verkauft(PId, 2012, Preis, _).

zuletzt(PId, Jahr1) :-
    produkt(PId, _, _, _, _, _, _),
    verkauft(PId, Jahr1, _, _),
    \+ (verkauft(PId, Jahr2, _, _),
    Jahr1@<Jahr2).

vorhanden(PId) :-
    produkt(PId, _, _, _, _, _, Bestand),
    \+verkauft(PId, 2012, _, _),
    Bestand@>0.

anzahlprodukte(Kategorie, Laenge) :-
    findall(PId, produkt(PId,Kategorie, _, _, _, _,_), X),
    length(X, Laenge).

add([], 0).

add([H|T], Sum) :-
    add(T, Sum2),
    Sum is Sum2 + H.

anzahlverkauft(Kategorie, Anzahl) :-
    findall(V,(produkt(PId, Kategorie, _, _, _, _, _), verkauft(PId, _, _, V)), Vlist),
    add(Vlist, Anzahl).

%erkaufserloes(Pid, Jahr, Verluste).


%verkaufserloes(Jahr, Verluste).


untergeordnet(Kategorie, List) :-
    findall(U, kategorie(U, _, Kategorie), List).

duplikate(Endlist) :-
    findall(D, (kategorie(U,D,_), kategorie(V,D,_), U\=V), List),
    sort(List, Endlist).

nosub(Id, Name) :-
    kategorie(Id, Name, _),
    \+kategorie(_, _, Id).

nosup(Id, Name) :-
    kategorie(Id, Name, Sup),
    \+kategorie(Sup, _, _).

%4.2.1
oberkategorien(UnterId, OberName, OberKey) :- 
    kategorie(UnterId,_,OberKey), 
    kategorie(OberKey,OberName,_).

oberkategorien(UnterId, OberName, OberKey) :- 
    kategorie(UnterId,_,UnOberKey), 
    oberkategorien(UnOberKey,OberName,OberKey).

%4.2.2



%4.2.3

findsub(Id, Sid, Sname) :-
    kategorie(Id, _, Sid),
    kategorie(Sid, Sname, _);
    ( kategorie(Id, _, Zid),
        findcat(Zid, Sid, Sname)).

findsup(Id, Names) :-
    findall(Name, findsu(Id, _, Name), Name1),
    reverse(Name1, Names).

findsu(Id, Suid, Suname) :-
    kategorie(Suid, Suname, Id);
    (kategorie(Zsuid, _, Id),
        findsu(Zsuid, Suid, Suname)).



%5.2


nextp(X, s(X)).
prevp(s(X), X).

subp(A, 0, A). 

subp(A, B, End) :-
    prev(A, Ax), 
    prev(B, Bx),
    sub(Ax, Bx, End).

addp(0, B, B).

addp(s(A), B, End) :-
    add(A, s(B), End).

maxp(0, 0).

maxp(A, Max) :-
    prev(A, X),
    max(X, Max2),
    Max is Max2 +1.

maxp(A, B, Max) :-
    max(A, Max1),
    max(B, Max2),
    (Max1@>Max2 -> Max is Max1 ; Max is Max2), !.


%5.3


%6.1

zins(Anlage, _, 0, Anlage) :- !.

zins(Anlage, Faktor, Dauer, Betrag) :-
    Zanlage is Anlage * (1 + Faktor),
    ZDauer is Dauer - 1,
    zins(Zanlage, Faktor, ZDauer, Betrag).

zins2(Anlage, Faktor, Dauer, Betrag) :-
    Betrag is Anlage * (Faktor+1)**Dauer.

zins3(Anlage, _, 0, Anlage) :- !.

zins3(Anlage, Faktor, Dauer, Betrag) :-
    ZDauer is Dauer-1, 
    zins3(Anlage, Faktor, ZDauer, ZBetrag),
    Betrag is ZBetrag * (1+Faktor).


zins4(Anlage, 0, _, _, Anlage) :- !. 

zins4(Anlage, Dauer, Alter, Zins, Betrag) :-
    NZins is Zins + (0.02*((1/2)**Alter)),
    NAnlage is Anlage * (NZins + 1),
    NDauer is Dauer -1,
    NAlter is Alter + 1,
    zins4(NAnlage, NDauer, NAlter, NZins, Betrag). 

zins4(Anlage, Dauer, Betrag) :-
    zins4(Anlage, Dauer, 0, 0.01, Betrag).

besser(Anlage, Start, Dauer) :-
    zins4(Anlage, Start, Betrag1),
    zins(Anlage, 0.04, Start, Betrag2),
    (Betrag1 @> Betrag2 -> Dauer is Start, ! ; 
        ZStart is Start + 1, 
        besser(Anlage, ZStart, Dauer)).

besser(Anlage, Dauer) :-
    besser(Anlage, 1, Dauer).


%6.2

pi(0, _, Akku, Akku) :- !.

pi(Deep, Counter, Akku, Result) :-
    ZAkku is Akku + 4*((-1**(Counter+1))/((2*Counter)-1)),
    ZDeep is Deep -1,
    ZCounter is Counter +1,
    pi(ZDeep, ZCounter, ZAkku, Result).

pi(Deep, Result) :-
    pi(Deep, 1, 0, Result).

%6.3.1
natZahl(Temp, Result):-
    Result is Temp;
    ZTemp is Temp + 1,
    natZahl(ZTemp, Result).

natZahl(Result) :-
    natZahl(0, Result).

%6.3.2
natoZahl(Max, _, Max) :- !.

natoZahl(Temp, Result, Max) :- Result is Temp;
    ZTemp is Temp +1,
    natoZahl(ZTemp, Result, Max).

natoZahl(Result, Max) :-
    natoZahl(0, Result, Max).

%7.2

inter([],_ , Akku, Table) :-
    Akku = Table, !.

inter([H|T], Set2, Akku, Table) :-
    (member(H, Set2) -> ZAkku = [H|Akku], inter(T, Set2, ZAkku, Table);
        inter(T, Set2, Akku, Table)).

inter( Set1, Set2, Table) :-
    inter(Set1, Set2, [], Table).


%7.3



%8.1

% Stoppwortbehandlung

%8.1.1

stoppweg([], _, []).

stoppweg([H|T], W, Endlist) :-
    stoppweg(T, W, ZEndlist),
    (member(H, W) -> Endlist = ZEndlist; Endlist = [H|ZEndlist]).


%8.2

wordcount(_, [], 1).
    
wordcount(Element, [H|T], Count) :-
    (Element = H -> wordcount(Element, T, ZCount), Count is ZCount + 1;
        wordcount(Element, T, ZCount), Count is ZCount).

haufen([], List, List).


haufen([H|T], Start, Endlist) :-
    (member([H|_], Start) -> haufen(T, Start, Endlist);
       wordcount(H, T, Count), ZStart = [[H, Count]|Start], haufen(T, ZStart, Endlist)). 

haufen(List, Endlist) :-
    haufen(List, [], Endlist).

%8.3

index([], List, List).


index([H|T], List, Endlist) :-
    (member([H|_], List) -> index(T, List, Endlist);
       length(List, Count), ZList = [[H, Count]|List], index(T, ZList, Endlist)). 

index(List, Endlist) :-
    index(List, [], Endlist).

schluessel(Wort, List, Index) :-
    member([Wort, Index], List).

replace([], _, Akku, Akku):- !.

replace([H|T], Indexlist, Akku, Endlist) :-
    member([H,Index], Indexlist),
    ZAkku = [Index|Akku],
    replace(T, Indexlist, ZAkku, Endlist), !;
    replace(T, Indexlist, Akku, Endlist).

replace(List, Indexlist, Endlist) :-
    replace(List, Indexlist, [], ZEndlist),
    reverse(ZEndlist, Endlist).

skalar( [],_,R, R) :- !.

skalar([H1|T], [H2| T2], Akku, R) :-
    ZAkku is H1*H2 + Akku,
    skalar(T, T2, ZAkku, R).

skalar(List, List2, R) :-
    skalar(List, List2, 0, R).


betrag(V1, R) :-
    skalar(V1, V1, R1),
    R is sqrt(R1).

cos(V1, V2, R) :-
    skalar(V1, V2, S1),
    betrag(V1, R1), 
    betrag(V2, R2),
    R is S1/(R1*R2).

komprimieren([], _, Akku, Back) :-
    reverse(Akku, Back).

komprimieren([H|T], Counter, Akku, Back) :-
    ZCounter is Counter + 1,
    (H = 0 -> komprimieren(T, ZCounter, Akku, Back) ;
        ZAkku = [H, Counter|Akku],
        komprimieren(T, ZCounter, ZAkku, Back)).

komprimieren(List, Back) :-
    komprimieren(List, 1, [], Back).

modskalar([], _, R, R) :- !.
modskalar(_, [], R, R) :- !.

modskalar([I1, H1|T1], [I2, H2|T2], Akku, R) :-
     I1 @< I2,
     modskalar(T1, [I2, H2|T2], Akku, R);
     I2 @< I1,
     modskalar([I1, H1|T1], T2, Akku, R);
     I1 = I2,
     ZAkku is H1*H2 + Akku,
     modskalar(T1, T2, ZAkku, R).

modskalar(V1, V2, R) :-
    modskalar(V1, V2, 0, R), !.

test([_]).

counter(_, 0, Akku, Akku).

counter([H|T], Counter, Akku, Back) :-
    ZC is Counter - 1,
    ZAkku = [H|Akku],
    counter(T, ZC, ZAkku, Back).

counter(List, Counter, Result) :-
    counter(List, Counter, [], Back),
    reverse(Back, Result), !.

divide(Teiler, A, B) :-
    B is A/Teiler.
