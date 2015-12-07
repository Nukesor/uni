%% Arne Beer, Felix Favre
%% SE3LP_G8_Beer_Favre

%% =============Aufgabe 1==============

/*
Aufgabe 1.1

(list (car (cdr (quote (1 2 3 4)))) (cdr (quote (1 2 3 4))) )
    (car (cdr (quote (1 2 3 4))))
        (cdr (quote (1 2 3 4)))
            (quote (1 2 3 4))
            ==> (1 2 3 4)
        ==> (2 3 4)
    ==> 2
    (cdr (quote (1 2 3 4)))
        (quote (1 2 3 4))
        ==> (1 2 3 4)
    ==> (2 3 4)
==> (2 (2 3 4))

Aufgabe 1.2

(if (< (car (quote (5 -3 4 -2))) 0) 0 1)
    (< (car (quote (5 -3 4 -2))) 0)
        (car (quote (5 -3 4 -2)))
            (quote (5 -3 4 -2))
            ==> (5 -3 4 -2)
        ==> 5
        0
    ==> #f
==> 1

Aufgabe 1.3

(cons (cdr (quote (1 2 3 4))) (car (quote (1 2 3 4))) )
    (cdr (quote (1 2 3 4)))
        (quote (1 2 3 4))
        ==> (1 2 3 4)
    ==> (2 3 4)
    (car (quote (1 2 3 4)))
        (quote (1 2 3 4))
        ==> (1 2 3 4)
    ==> 1
==> ((2 3 4) . 1)

Aufgabe 1.4

(map (lambda (x) (if (pair? x) (car x) x))
    (quote (lambda (x) (if (pair? x) (car x) x))) )

    (lambda (x) (if (pair? x) (car x) x))
    ==> #<procedure>
    (quote (lambda (x) (if (pair? x) (car x) x)))
    ==>(lambda (x) (if (pair? x) (car x) x))
==> (lambda x if)

Aufgabe 1.5

(filter (curry > 5) (reverse (quote (1 3 5 7 9))) )
    (curry > 5)
    ==> ==> #<procedure:curried>
    (reverse (quote (1 3 5 7 9)))
        (quote (1 3 5 7 9))
        ==>(1 3 5 7 9)
    ==> (9 7 5 3 1)
==> (3 1)

Aufgabe 1.6

(filter (compose positive? (lambda (x) (- x 5)) )
    (quote (1 3 5 7 9)) )

    (compose positive? (lambda (x) (- x 5)) )
    ==> #<procedure:composed>
    (quote (1 3 5 7 9))
    ==> (1 3 5 7 9)
==>(7 9)

*/

%% =============Aufgabe 2==============


%  Aufgabe 2.1
/*
 (define (foo1 x y)
    (if (and (null? x) (list? y))
        #t
        (if (eq? (car x) (car y))
            (foo1 (cdr x) (cdr y))
            #f ) ) )

Die Funktion berrechnet, ob die Elemente der Liste x
equivalent zu den ersten Elementen der Liste y sind.
Falls dies nicht der Fall ist wird #f ausgegeben, ansonsten
wird #t ausgegeben.

*/

%Abbruchbedingung der Rekursion
foo1([], []):- !.
foo1([], [_]):- !.
foo1([], [_|_]):- !.

%foo(+Liste1, +Liste2)
foo1([XH|XT], [YH|YT]) :-
% Check auf Gleichheit der ersten Elemente
XH == YH,
% Rekursiver Durchgang durch die Listen
foo1(XT, YT).

/*
Der rekursive Durchgang durch die Listen ist equivalent
und beide Implementationen sind normal rekursiv.
*/

%  Aufgabe 2.2
/*
(define (foo2 x)
    (if (null? x)
        (quote ())
        (if (member (car x) (cdr x))
            (foo2 (cdr x))
            (cons (car x) (foo2 (cdr x)) ) ) ) )

Diese Funktion entfernt saemtliche Duplikate
aus einer Liste.
*/

% Rekursiver Membercheck
mymember(X,[X|_]) :- !.
mymember(X,[_|T]) :- mymember(X,T).

not(A) :- \+ call(A).

foo2([],[]).
foo2([H|T],[H|Out]) :-
%Rekursiver Aufruf, falls kein Member
not(mymember(H,T)),
foo2(T,Out).
foo2([H|T],Out) :-
% Rekursiver Aufruf falls Member, aber
% ohne den Head an die zurueckgegebene
% Liste anzuhaengen.
mymember(H,T),
foo2(T,Out).


%  Aufgabe 2.3
/*
 (define (foo3 x y)
    (if (null? x)
        (quote ())
        (if (member (car x) y)
            (cons (car x) (foo3 (cdr x) y))
            (foo3 (cdr x) y) ) ) )

Sucht alle Elemente von x, welche auch in y vorhanden sind
und gibt diese als Liste zurueck.
*/

foo3([],_,[]).
foo3([H|T], Y,[H|Out]) :-
% Rekursiver Aufruf falls Member, aber
% ohne den Head an die zurueckgegebene
% Liste anzuhaengen.
not(mymember(H,Y)),
foo3(T,Y,Out).
foo3([H|T],Y,Out) :-
%Rekursiver Aufruf, falls kein Member
mymember(H,Y),
foo3(T,Y,Out).

%  Aufgabe 2.4
/*
 (define (foo4 x)
    (letrec ((foo4a
        (lambda (x y)
            (if (null? x)
                y
                (foo4a (cdr x) (cons (car x) y)) ) ) ) )
    (foo4a x (quote ())) ) )

Dreht die übergebene Liste um.
*/

% Abbruchbedingung
foo4([],[]).

%Rekursive Funktionsdefinition
foo4([Head|Tail],ReverseList) :-
foo4(Tail,Y),
append(Y,[Head],ReverseList).


%   Aufgabe 2.5
/*
 (define (foo5 x)
    (if (null? x)
        (quote ())
        (if (pair? (car x))
            (append (foo5 (car x)) (foo5 (cdr x)) )
            (cons (car x) (foo5 (cdr x))) ) ) )

Flacht eine Übergebene Liste ab.
*/

%Abbruchbedingung
foo5([],[]) :- !.

foo5([Head|Tail], FlatList) :-
%Rekursives abflachen des Kopfelementes
foo5(Head, FlatHead),
% und des Restes
foo5(Tail, FlatTail),
% Zusammenfügen der abgeflachten Teile
append(FlatHead,FlatTail, FlatList),
% Cut
!.

% Einzelne Elemente werden zu einer
% Liste mit einem Element.
foo5(X,[X]).



%% =============Aufgabe 3==============

/*
Wir definieren Peanozahlen als verschachtelte Liste
deren Tiefstes Element die 0 ist.
Das erste Element einer Peano-Liste ist entweder
eine 0 oder eine Liste.
Das hintere Element ist immer eine leere Liste.

Prolog      Racket
0           0
s(0)        '(0)
s(s(s(0)))  '(((0)))

*/

/*
(define (peano x)
  ; 0 ist per definition eine Peano Zahl
  (if (eq? x 0)
    #t
    ; Wenn x ungleich 0 ist muss x eine Liste sein
    ; um eine Peano Zahl zu sein
    (if (list? x)
      ; Die leere liste ist keine Peano Zahl
      (if (empty? x)
        #f
        ; Rekursiver Aufruf
        (peano (car x))
      )
      #f
    )
  )
)

(define (add x y)
  ; Diese Funktion addiert nur Peanozahlen
  (if (and (peano x) (peano y))
    ; Wenn y 0 ist gebe x zurück
    (if (eq? y 0)
      x
      ; Sonst mache X um 1 größer und y um 1 kleiner und rufe
      ; add rekursiv auf
      (add (list x) (car y))
    )
    (error "Only Peano Numbers!")
  )
)

(define (lt x y)
  ; Diese Funktion vergleicht nur Peanozahlen
  (if (and (peano x) (peano y))
    ; Wenn x gleich y ist, ist x nicht kleiner y
    (if (eq? x y)
      #f
      ; Wenn x gleich 0 ist muss es kleiner y sein
      (if (eq? x 0)
        #t
        ; Wenn y gleich 0 isat muss es kleiner x sein
        (if (eq? y 0)
          #f
          ; Mache x und y um 1 kleiner und rufe
          ; lt rekursiv auf
          (lt (car x) (car y))
        )
      )
    )
    (error "Only Peano Numbers!")
  )
)

*/